import ddf.minim.*;
Minim minim;
AudioPlayer song;
PImage albumImg;
PFont CandaraFont;
boolean isPlaying = false;

String[] titles = {
  "Track One:2017",
  "Track Two:2020",
  "Unreleased:2005",
  "Track Four:2019",
  "RELEASED DATE SOON"
};
String[] audioPaths = {
  "data/Drake - Laugh Now Cry Later (Instrumental) ft. Lil Durk - M Max.mp3",
  "data/JACKBOYS, Travis Scott - OUT WEST (Audio) ft. Young Thug (OFFICIAL INSTRUMENTAL).mp3",
  "data/Three 6 Mafia - Poppin' My Collar [Instrumental] - Crucial Mixtapes.mp3",
  "data/playboi carti - stop breathing instrumental - prod antoniolamar.mp3",
  
};
String[] imagePaths = {
  "data/download.jpg",
  "data/Dunhuang.jpg",
  "data/images.jpg",
  "data/istockphoto-1452588698-170667a.jpg",
  
};
color[] titleColors = {
  color(0, 0, 255),
  color(255, 165, 0),
  color(0, 200, 0),
  color(200, 0, 200),
  color(50, 120, 200)
};

int currentSongIndex = 0;
float volume = 0.7;

// Button properties
int btnSize = 70;
int btnSpacing = 25;
int btnY;
int[] btnXs = new int[6]; // For 6 buttons

void setup() {
  fullScreen();
  minim = new Minim(this);

  CandaraFont = createFont("Arial", 48);
  loadCurrentSong();

  // Position buttons directly below album art
  btnY = int(height / 3) + 100;
  int numBtns = btnXs.length;
  int totalWidth = btnSize * numBtns + btnSpacing * (numBtns - 1);
  int startX = width / 2 - totalWidth / 2;
  for (int i = 0; i < numBtns; i++) {
    btnXs[i] = startX + i * (btnSize + btnSpacing);
  }
}

void draw() {
  background(255);
  displayTitle();
  displayAlbumArt();
  drawButtons();
  checkPlaybackState();
}

void displayTitle() {
  fill(titleColors[currentSongIndex]);
  textFont(CandaraFont);
  textAlign(CENTER, CENTER);
  text(titles[currentSongIndex], width / 2, 50);
}

void displayAlbumArt() {
  albumImg = loadImage(imagePaths[currentSongIndex]);
  if (albumImg != null) {
    image(albumImg, width / 3, 80, width / 3, height / 3);
  } else {
    fill(200);
    rect(width / 3, 80, width / 3, height / 3);
    fill(0);
    textSize(32);
    text("Image not found", width / 2, height / 2);
  }
}

void drawButtons() {
  // Button Icons order: [Fast Rewind, Previous, Play/Pause, Stop, Next, Fast Forward]
  for (int i = 0; i < btnXs.length; i++) {
    fill(230);
    stroke(0);
    rect(btnXs[i], btnY, btnSize, btnSize);
  }

  // Fast Rewind <<
  fill(0);
  noStroke();
  float cx = btnXs[0] + btnSize / 2;
  float cy = btnY + btnSize / 2;
  float s = 20;
  // Two left triangles
  triangle(cx + 2, cy - s, cx + 2, cy + s, cx - 12, cy);
  triangle(cx - 8, cy - s, cx - 8, cy + s, cx - 22, cy);

  // Previous |<
  cx = btnXs[1] + btnSize / 2;
  triangle(cx + 10, cy - s, cx + 10, cy + s, cx - 10, cy);
  rect(cx - 17, cy - s, 6, 2 * s);

  // Play/Pause
  cx = btnXs[2] + btnSize / 2;
  if (!isPlaying) {
    triangle(
      cx - 15, cy - 22,
      cx - 15, cy + 22,
      cx + 20, cy
    );
  } else {
    rect(cx - 12, cy - 22, 10, 44);
    rect(cx + 4, cy - 22, 10, 44);
  }

  // Stop
  cx = btnXs[3] + btnSize / 2;
  rect(cx - 20, cy - 20, 40, 40);

  // Next >|
  cx = btnXs[4] + btnSize / 2;
  triangle(cx - 10, cy - s, cx - 10, cy + s, cx + 10, cy);
  rect(cx + 11, cy - s, 6, 2 * s);

  // Fast Forward >>
  cx = btnXs[5] + btnSize / 2;
  triangle(cx - 2, cy - s, cx - 2, cy + s, cx + 12, cy);
  triangle(cx + 8, cy - s, cx + 8, cy + s, cx + 22, cy);
}

void mousePressed() {
  // Button order: [Fast Rewind, Previous, Play/Pause, Stop, Next, Fast Forward]
  for (int i = 0; i < btnXs.length; i++) {
    if (mouseX > btnXs[i] && mouseX < btnXs[i] + btnSize &&
        mouseY > btnY && mouseY < btnY + btnSize) {
      handleButton(i);
      break;
    }
  }
}

void handleButton(int i) {
  switch(i) {
    case 0: // Fast Rewind
      if (song != null) {
        song.cue(max(0, song.position() - 5000));
      }
      break;
    case 1: // Previous
      currentSongIndex = (currentSongIndex - 1 + titles.length) % titles.length;
      loadCurrentSong();
      break;
    case 2: // Play/Pause
      if (song != null) {
        if (!isPlaying) {
          song.play();
          isPlaying = true;
        } else {
          song.pause();
          isPlaying = false;
        }
      }
      break;
    case 3: // Stop
      if (song != null) {
        song.pause();
        song.rewind();
        isPlaying = false;
      }
      break;
    case 4: // Next
      currentSongIndex = (currentSongIndex + 1) % titles.length;
      loadCurrentSong();
      break;
    case 5: // Fast Forward
      if (song != null) {
        int nextPos = min(song.position() + 5000, song.length() - 10);
        song.cue(nextPos);
      }
      break;
  }
}

void loadCurrentSong() {
  if (song != null) {
    song.close();
  }
  try {
    song = minim.loadFile(audioPaths[currentSongIndex]);
    song.setGain(volume * -20);
    if (isPlaying) {
      song.play();
    }
  } catch (Exception e) {
    println("Could not load file: " + audioPaths[currentSongIndex]);
    song = null;
    isPlaying = false;
  }
}

void checkPlaybackState() {
  if (song != null && !song.isPlaying() && isPlaying) {
    currentSongIndex = (currentSongIndex + 1) % titles.length;
    loadCurrentSong();
  }
}
