import ddf.minim.*;
Minim minim;
AudioPlayer song;
PImage albumImg;
PFont CandaraFont;
boolean isPlaying = false;
boolean isShuffle = false;
boolean isRepeat = false;
boolean isMuted = false;

String[] titles = {
  "Track One:2017",
  "Track Two:2020",
  "Unreleased:2005"
};
String[] audioPaths = {
  "data/Drake - Laugh Now Cry Later (Instrumental) ft. Lil Durk - M Max.mp3",
  "data/JACKBOYS, Travis Scott - OUT WEST (Audio) ft. Young Thug (OFFICIAL INSTRUMENTAL).mp3",
  "data//Three 6 Mafia - Poppin' My Collar [Instrumental] - Crucial Mixtapes.mp3"
};
String[] imagePaths = {
  "data/download.jpg",
  "data/Dunhuang.jpg",
  "data/images.jpg"
};
color[] titleColors = {
  color(0, 0, 255),
  color(255, 165, 0),
  color(0, 200, 0)
};

int currentSongIndex = 0;
float volume = 0.7;

// Button properties
int btnSize = 80;
int btnSpacing = 30;
int btnY;
int playPauseBtnX, stopBtnX;

void setup() {
  fullScreen();
  minim = new Minim(this);

  CandaraFont = createFont("Arial", 48);
  loadCurrentSong();

  // Position buttons directly below album art
  btnY = int(height / 3) + 100;

  int totalWidth = btnSize * 2 + btnSpacing;
  // Center the two buttons horizontally
  playPauseBtnX = width / 2 - totalWidth / 2;
  stopBtnX = playPauseBtnX + btnSize + btnSpacing;
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
  // Play/Pause button
  fill(230);
  stroke(0);
  rect(playPauseBtnX, btnY, btnSize, btnSize); // perfect square, no rounded corners
  fill(0);
  noStroke();
  float cx = playPauseBtnX + btnSize/2;
  float cy = btnY + btnSize/2;
  float iconSize = 35;

  if (!isPlaying) {
    // Draw play icon (triangle)
    triangle(
      cx - iconSize/2, cy - iconSize/2,
      cx - iconSize/2, cy + iconSize/2,
      cx + iconSize/2, cy
    );
  } else {
    // Draw pause icon (two vertical bars)
    float barWidth = 10;
    float barHeight = iconSize;
    rect(cx - 12, cy - barHeight/2, barWidth, barHeight);
    rect(cx + 2, cy - barHeight/2, barWidth, barHeight);
  }

  // Stop button
  fill(230);
  stroke(0);
  rect(stopBtnX, btnY, btnSize, btnSize); // perfect square, no rounded corners
  fill(0);
  noStroke();
  float scx = stopBtnX + btnSize/2;
  float scy = btnY + btnSize/2;
  float sSize = 34;
  rect(scx - sSize/2, scy - sSize/2, sSize, sSize);
}

void mousePressed() {
  // Play/Pause button click
  if (mouseX > playPauseBtnX && mouseX < playPauseBtnX + btnSize &&
      mouseY > btnY && mouseY < btnY + btnSize) {
    if (!isPlaying) {
      song.rewind();
      song.play();
      isPlaying = true;
    } else {
      song.pause();
      isPlaying = false;
    }
  }
  // Stop button click
  if (mouseX > stopBtnX && mouseX < stopBtnX + btnSize &&
      mouseY > btnY && mouseY < btnY + btnSize) {
    song.pause();
    song.rewind();
    isPlaying = false;
  }
}

void loadCurrentSong() {
  if (song != null) {
    song.close();
  }
  song = minim.loadFile(audioPaths[currentSongIndex]);
  song.setGain(volume * -20);
  if (isPlaying) {
    song.play();
  }
}

void checkPlaybackState() {
  if (song != null && !song.isPlaying() && isPlaying) {
    if (isRepeat) {
      song.rewind();
      song.play();
    } else {
      nextSong();
    }
  }
}

void nextSong() {
  currentSongIndex = (currentSongIndex + 1) % titles.length;
  loadCurrentSong();
}
