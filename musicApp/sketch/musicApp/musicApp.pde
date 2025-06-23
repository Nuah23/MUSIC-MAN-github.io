import ddf.minim.*;

Minim minim;
AudioPlayer song1, song2, song3, song4;
PImage img1, img2, img3, img4;

int imageToShow = 0; // 0 = none, 1 = img1, 2 = img2, 3 = img3, 4 = img4

void setup() {
  size(800, 600);
  minim = new Minim(this);
  song1 = minim.loadFile("Drake.mp3");
  song2 = minim.loadFile("JACKBOYS, Travis Scott - OUT WEST (Audio) ft. Young Thug (OFFICIAL INSTRUMENTAL).mp3");
  song3 = minim.loadFile("playboi carti - stop breathing instrumental - prod antoniolamar.mp3");
  song4 = minim.loadFile("Three 6 Mafia - Poppin' My Collar [Instrumental] - Crucial Mixtapes.mp3");
  img1 = loadImage("download.jpg");
  img2 = loadImage("Dunhuang.jpg");
  img3 = loadImage("images.jpg");
  img4 = loadImage("istockphoto-1452588698-170667a.jpg");
}

void draw() {
  background(230);

  // Draw the current image (only one at a time)
  if (imageToShow == 1) image(img1, 500, 150, 200, 200);
  if (imageToShow == 2) image(img2, 500, 150, 200, 200);
  if (imageToShow == 3) image(img3, 500, 150, 200, 200);
  if (imageToShow == 4) image(img4, 500, 150, 200, 200);

  // Draw buttons
  drawButton("Play S1",  40, 60);
  drawButton("Img 1",   160, 60);
  drawButton("Stop S1", 280, 60);

  drawButton("Play S2",  40, 120);
  drawButton("Img 2",   160, 120);
  drawButton("Stop S2", 280, 120);

  drawButton("Play S3",  40, 180);
  drawButton("Img 3",   160, 180);
  drawButton("Stop S3", 280, 180);

  drawButton("Play S4",  40, 240);
  drawButton("Img 4",   160, 240);
  drawButton("Stop S4", 280, 240);
}

void drawButton(String label, int x, int y) {
  fill(200);
  rect(x, y, 100, 40);
  fill(0);
  textSize(16);
  text(label, x+15, y+25);
}

void mousePressed() {
  // Song 1 controls
  if (mouseOver(40, 60)) { song1.rewind(); song1.play(); }
  if (mouseOver(160, 60)) { imageToShow = 1; }
  if (mouseOver(280, 60)) { song1.pause(); song1.rewind(); }

  // Song 2 controls
  if (mouseOver(40, 120)) { song2.rewind(); song2.play(); }
  if (mouseOver(160, 120)) { imageToShow = 2; }
  if (mouseOver(280, 120)) { song2.pause(); song2.rewind(); }

  // Song 3 controls
  if (mouseOver(40, 180)) { song3.rewind(); song3.play(); }
  if (mouseOver(160, 180)) { imageToShow = 3; }
  if (mouseOver(280, 180)) { song3.pause(); song3.rewind(); }

  // Song 4 controls
  if (mouseOver(40, 240)) { song4.rewind(); song4.play(); }
  if (mouseOver(160, 240)) { imageToShow = 4; }
  if (mouseOver(280, 240)) { song4.pause(); song4.rewind(); }
}

boolean mouseOver(int x, int y) {
  return mouseX > x && mouseX < x+100 && mouseY > y && mouseY < y+40;
}

void stop() {
  song1.close();
  song2.close();
  song3.close();
  song4.close();
  minim.stop();
  super.stop();
}
