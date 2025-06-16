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

void setup() {
  fullScreen();
  minim = new Minim(this);

  CandaraFont = createFont("Arial", 48);
  loadCurrentSong();
}

void draw() {
  background(255);
  displayTitle();
  displayAlbumArt();
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
