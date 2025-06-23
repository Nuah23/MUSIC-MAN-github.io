import ddf.minim.*;

Minim minim;
AudioPlayer song1, song2, song3, song4;
AudioMetaData meta1, meta2, meta3, meta4;

PImage img1, img2, img3, img4;

boolean playSong1 = false, playSong2 = false, playSong3 = false, playSong4 = false;
boolean showImg1 = false, showImg2 = true, showImg3 = false, showImg4 = false;
boolean fullscreenMode = false;

String file1 = "Drake.mp3";
String file2 = "JACKBOYS, Travis Scott - OUT WEST (Audio) ft. Young Thug (OFFICIAL INSTRUMENTAL).mp3";
String file3 = "Three 6 Mafia - Poppin' My Collar [Instrumental] - Crucial Mixtapes.mp3";
String file4 = "playboi carti - stop breathing instrumental - prod antoniolamar.mp3";

String nowPlaying = "";
String nowArtist = "";
String nowAlbum = "";

float btnSize = 50, btnY = 30;
float bx1 = 50,  by1 = btnY;
float bx2 = 120, by2 = btnY;
float bx3 = 190, by3 = btnY;
float bx4 = 260, by4 = btnY;
float bx5 = 330, by5 = btnY;
float bx6 = 400, by6 = btnY;
float bx7 = 470, by7 = btnY;
float bx8 = 540, by8 = btnY;
float bx9 = 610, by9 = btnY;
float bx10 = 680, by10 = btnY;
float bx11 = 750, by11 = btnY;

float imgX = 1000, imgY1 = 120, imgY2 = 260, imgY3 = 400, imgY4 = 540;
float imgW = 200, imgH = 120;

float sbtnW = 120, sbtnH = 50, sbY = 650;
float sbtn1X = 200, sbtn2X = 370, sbtn3X = 540, sbtn4X = 710;

// GCD for reduced fractions
int gcd(int a, int b) {
  if (b == 0) return a;
  else return gcd(b, a % b);
}

// Fullscreen toggle with real fullscreen mode
void setFullscreen(boolean fs) {
  if (fs) {
    surface.setLocation(0, 0);
    surface.setSize(displayWidth, displayHeight);
  } else {
    surface.setSize(1280, 720);
    surface.setLocation(100, 100);
  }
  fullscreenMode = fs;
}

void setup() {
  size(1280, 720);
  minim = new Minim(this);

  song1 = minim.loadFile(file1);
  song2 = minim.loadFile(file2);
  song3 = minim.loadFile(file3);
  song4 = minim.loadFile(file4);

  meta1 = song1.getMetaData();
  meta2 = song2.getMetaData();
  meta3 = song3.getMetaData();
  meta4 = song4.getMetaData();

  img1 = loadImage("download.jpg");
  img2 = loadImage("Dunhuang.jpg");
  img3 = loadImage("images.jpg");
  img4 = loadImage("istockphoto-1452588698-170667a.jpg");

  textFont(createFont("Candara", 22));
  nowPlaying = meta1.title();
  nowArtist = meta1.author();
  nowAlbum = meta1.album();

  showImg1 = false;
  showImg2 = true;
  showImg3 = false;
  showImg4 = false;
}

void draw() {
  background(50);

  // 1. Play (triangle)
  fill(230); rect(bx1, by1, btnSize, btnSize, 8);
  fill(40,200,80);
  float px = bx1+btnSize*0.33, py = by1+btnSize*0.22, pw = btnSize*0.40, ph = btnSize*0.56;
  triangle(px, py, px, py+ph, px+pw, by1+btnSize/2);

  // 2. Pause (bars)
  fill(230); rect(bx2, by2, btnSize, btnSize, 8);
  fill(40,100,200);
  rect(bx2+btnSize*0.22, by2+btnSize*0.22, btnSize*0.15, btnSize*0.56);
  rect(bx2+btnSize*0.63, by2+btnSize*0.22, btnSize*0.15, btnSize*0.56);

  // 3. Stop (square)
  fill(230); rect(bx3, by3, btnSize, btnSize, 8);
  fill(240,60,40);
  rect(bx3+btnSize*0.28, by3+btnSize*0.28, btnSize*0.44, btnSize*0.44);

  // 4. Repeat (circle + triangle)
  fill(230); rect(bx4, by4, btnSize, btnSize, 8);
  noFill(); stroke(20,180,80); strokeWeight(4);
  arc(bx4+btnSize/2, by4+btnSize*0.58, btnSize*0.60, btnSize*0.60, PI*0.1, PI*1.3);
  fill(20,180,80); noStroke();
  triangle(bx4+btnSize*0.78, by4+btnSize*0.45, bx4+btnSize*0.91, by4+btnSize*0.52, bx4+btnSize*0.78, by4+btnSize*0.60);
  strokeWeight(1); noStroke();

  // 5. Next (triangle + rect)
  fill(230); rect(bx5, by5, btnSize, btnSize, 8);
  fill(40,200,80);
  triangle(bx5+btnSize*0.20, by5+btnSize*0.22, bx5+btnSize*0.20, by5+btnSize*0.78, bx5+btnSize*0.60, by5+btnSize*0.50);
  rect(bx5+btnSize*0.65, by5+btnSize*0.24, btnSize*0.12, btnSize*0.52);

  // 6. Prev (triangle + rect)
  fill(230); rect(bx6, by6, btnSize, btnSize, 8);
  fill(40,200,80);
  triangle(bx6+btnSize*0.80, by6+btnSize*0.22, bx6+btnSize*0.80, by6+btnSize*0.78, bx6+btnSize*0.40, by6+btnSize*0.50);
  rect(bx6+btnSize*0.23, by6+btnSize*0.24, btnSize*0.12, btnSize*0.52);

  // 7. Mute (rect + triangle + X)
  fill(230); rect(bx7, by7, btnSize, btnSize, 8);
  fill(120); rect(bx7+btnSize*0.28, by7+btnSize*0.39, btnSize*0.18, btnSize*0.22);
  triangle(bx7+btnSize*0.28, by7+btnSize*0.39, bx7+btnSize*0.28, by7+btnSize*0.61, bx7+btnSize*0.15, by7+btnSize*0.50);
  stroke(220,40,40); strokeWeight(4);
  line(bx7+btnSize*0.65, by7+btnSize*0.40, bx7+btnSize*0.85, by7+btnSize*0.60);
  line(bx7+btnSize*0.85, by7+btnSize*0.40, bx7+btnSize*0.65, by7+btnSize*0.60);
  strokeWeight(1); noStroke();

  // 8. Unmute (rect + triangle + arcs)
  fill(230); rect(bx8, by8, btnSize, btnSize, 8);
  fill(120); rect(bx8+btnSize*0.28, by8+btnSize*0.39, btnSize*0.18, btnSize*0.22);
  triangle(bx8+btnSize*0.28, by8+btnSize*0.39, bx8+btnSize*0.28, by8+btnSize*0.61, bx8+btnSize*0.15, by8+btnSize*0.50);
  noFill(); stroke(60,180,80); strokeWeight(4);
  arc(bx8+btnSize*0.55, by8+btnSize*0.50, btnSize*0.40, btnSize*0.40, -PI/6, PI/6);
  arc(bx8+btnSize*0.62, by8+btnSize*0.50, btnSize*0.56, btnSize*0.56, -PI/6, PI/6);
  strokeWeight(1); noStroke();

  // 9. Shuffle (two crossing lines)
  fill(230); rect(bx9, by9, btnSize, btnSize, 8);
  stroke(60,150,200); strokeWeight(4);
  line(bx9+btnSize*0.18, by9+btnSize*0.35, bx9+btnSize*0.82, by9+btnSize*0.65);
  line(bx9+btnSize*0.18, by9+btnSize*0.65, bx9+btnSize*0.82, by9+btnSize*0.35);
  strokeWeight(1); noStroke();

  // 10. Fullscreen (corner squares)
  fill(230); rect(bx10, by10, btnSize, btnSize, 8);
  stroke(60,220,80); strokeWeight(4);
  noFill();
  rect(bx10+btnSize*0.18, by10+btnSize*0.18, btnSize*0.20, btnSize*0.20);
  rect(bx10+btnSize*0.62, by10+btnSize*0.62, btnSize*0.20, btnSize*0.20);
  strokeWeight(1); noStroke();

  // 11. Quit (X)
  fill(230); rect(bx11, by11, btnSize, btnSize, 8);
  stroke(220,40,40); strokeWeight(5);
  line(bx11+btnSize*0.25, by11+btnSize*0.25, bx11+btnSize*0.75, by11+btnSize*0.75);
  line(bx11+btnSize*0.75, by11+btnSize*0.25, bx11+btnSize*0.25, by11+btnSize*0.75);
  strokeWeight(1); noStroke();

  float metaY = 300;
  fill(30, 30, 90, 180); rect(50, metaY, 900, 100, 10);
  fill(255);
  text("Now Playing: " + nowPlaying, 70, metaY+35);
  text("Artist: " + nowArtist, 70, metaY+65);
  text("Album: " + nowAlbum, 400, metaY+65);

  fill(showImg1 ? color(180,220,255) : color(200)); rect(imgX-30, imgY1, imgW+60, imgH, 12);
  fill(showImg2 ? color(180,220,255) : color(200)); rect(imgX-30, imgY2, imgW+60, imgH, 12);
  fill(showImg3 ? color(180,220,255) : color(200)); rect(imgX-30, imgY3, imgW+60, imgH, 12);
  fill(showImg4 ? color(180,220,255) : color(200)); rect(imgX-30, imgY4, imgW+60, imgH, 12);

  if (showImg1) image(img1, imgX, imgY1+10, imgW, imgH-20);
  if (showImg2) {
    image(img2, imgX, imgY2+10, imgW, imgH-20);
    int w = img2.width;
    int h = img2.height;
    int divisor = gcd(w, h);
    int num = w / divisor;
    int den = h / divisor;
    float img2AR = float(w) / float(h);
    fill(255,255,0);
    text("Size: " + w + " x " + h, imgX, imgY2+imgH-15);
    text("Aspect: " + num + "/" + den + " (" + nf(img2AR, 1, 2) + ")", imgX, imgY2+imgH+10);
  }
  if (showImg3) image(img3, imgX, imgY3+10, imgW, imgH-20);
  if (showImg4) image(img4, imgX, imgY4+10, imgW, imgH-20);

  textFont(createFont("Candara", 22));
  fill(playSong1 ? color(0,255,0) : color(200)); rect(sbtn1X, sbY, sbtnW, sbtnH, 12); fill(0); text("Song 1", sbtn1X+22, sbY+32);
  fill(playSong2 ? color(0,255,0) : color(200)); rect(sbtn2X, sbY, sbtnW, sbtnH, 12); fill(0); text("Song 2", sbtn2X+22, sbY+32);
  fill(playSong3 ? color(0,255,0) : color(200)); rect(sbtn3X, sbY, sbtnW, sbtnH, 12); fill(0); text("Song 3", sbtn3X+22, sbY+32);
  fill(playSong4 ? color(0,255,0) : color(200)); rect(sbtn4X, sbY, sbtnW, sbtnH, 12); fill(0); text("Song 4", sbtn4X+22, sbY+32);

  fill(255);
  text("Window Aspect Ratio: " + nf(float(width)/float(height), 1, 2), 70, 100);

  if (fullscreenMode) {
    fill(0, 0, 0, 60);
    rect(0, 0, width, height);
    fill(255, 255, 0);
    textSize(36);
    text("FULLSCREEN", width/2-120, height/2);
    textSize(22);
  }
}

void mousePressed() {
  if (mouseX > bx1 && mouseX < bx1+btnSize && mouseY > by1 && mouseY < by1+btnSize) {
    playSong1 = true; playSong2 = playSong3 = playSong4 = false;
    song1.rewind(); song1.play(); song2.pause(); song3.pause(); song4.pause();
    nowPlaying = meta1.title(); nowArtist = meta1.author(); nowAlbum = meta1.album();
  }
  if (mouseX > bx2 && mouseX < bx2+btnSize && mouseY > by2 && mouseY < by2+btnSize) {
    song1.pause(); song2.pause(); song3.pause(); song4.pause();
  }
  if (mouseX > bx3 && mouseX < bx3+btnSize && mouseY > by3 && mouseY < by3+btnSize) {
    song1.pause(); song2.pause(); song3.pause(); song4.pause();
    song1.rewind(); song2.rewind(); song3.rewind(); song4.rewind();
    playSong1 = playSong2 = playSong3 = playSong4 = false;
  }
  if (mouseX > bx4 && mouseX < bx4+btnSize && mouseY > by4 && mouseY < by4+btnSize) {
    if (playSong1) song1.loop(1);
    if (playSong2) song2.loop(1);
    if (playSong3) song3.loop(1);
    if (playSong4) song4.loop(1);
  }
  if (mouseX > bx5 && mouseX < bx5+btnSize && mouseY > by5 && mouseY < by5+btnSize) {
    if (playSong1) { playSong1 = false; playSong2 = true; song1.pause(); song2.rewind(); song2.play(); nowPlaying = meta2.title(); nowArtist = meta2.author(); nowAlbum = meta2.album(); }
    else if (playSong2) { playSong2 = false; playSong3 = true; song2.pause(); song3.rewind(); song3.play(); nowPlaying = meta3.title(); nowArtist = meta3.author(); nowAlbum = meta3.album(); }
    else if (playSong3) { playSong3 = false; playSong4 = true; song3.pause(); song4.rewind(); song4.play(); nowPlaying = meta4.title(); nowArtist = meta4.author(); nowAlbum = meta4.album(); }
    else if (playSong4) { playSong4 = false; playSong1 = true; song4.pause(); song1.rewind(); song1.play(); nowPlaying = meta1.title(); nowArtist = meta1.author(); nowAlbum = meta1.album(); }
  }
  if (mouseX > bx6 && mouseX < bx6+btnSize && mouseY > by6 && mouseY < by6+btnSize) {
    if (playSong1) { playSong1 = false; playSong4 = true; song1.pause(); song4.rewind(); song4.play(); nowPlaying = meta4.title(); nowArtist = meta4.author(); nowAlbum = meta4.album(); }
    else if (playSong2) { playSong2 = false; playSong1 = true; song2.pause(); song1.rewind(); song1.play(); nowPlaying = meta1.title(); nowArtist = meta1.author(); nowAlbum = meta1.album(); }
    else if (playSong3) { playSong3 = false; playSong2 = true; song3.pause(); song2.rewind(); song2.play(); nowPlaying = meta2.title(); nowArtist = meta2.author(); nowAlbum = meta2.album(); }
    else if (playSong4) { playSong4 = false; playSong3 = true; song4.pause(); song3.rewind(); song3.play(); nowPlaying = meta3.title(); nowArtist = meta3.author(); nowAlbum = meta3.album(); }
  }
  if (mouseX > bx7 && mouseX < bx7+btnSize && mouseY > by7 && mouseY < by7+btnSize) {
    if (playSong1) song1.mute();
    if (playSong2) song2.mute();
    if (playSong3) song3.mute();
    if (playSong4) song4.mute();
  }
  if (mouseX > bx8 && mouseX < bx8+btnSize && mouseY > by8 && mouseY < by8+btnSize) {
    if (playSong1) song1.unmute();
    if (playSong2) song2.unmute();
    if (playSong3) song3.unmute();
    if (playSong4) song4.unmute();
  }
  if (mouseX > bx9 && mouseX < bx9+btnSize && mouseY > by9 && mouseY < by9+btnSize) {
    int pick = int(random(1, 5));
    playSong1 = playSong2 = playSong3 = playSong4 = false;
    song1.pause(); song1.rewind();
    song2.pause(); song2.rewind();
    song3.pause(); song3.rewind();
    song4.pause(); song4.rewind();
    if (pick == 1) { playSong1 = true; song1.play(); nowPlaying = meta1.title(); nowArtist = meta1.author(); nowAlbum = meta1.album(); }
    if (pick == 2) { playSong2 = true; song2.play(); nowPlaying = meta2.title(); nowArtist = meta2.author(); nowAlbum = meta2.album(); }
    if (pick == 3) { playSong3 = true; song3.play(); nowPlaying = meta3.title(); nowArtist = meta3.author(); nowAlbum = meta3.album(); }
    if (pick == 4) { playSong4 = true; song4.play(); nowPlaying = meta4.title(); nowArtist = meta4.author(); nowAlbum = meta4.album(); }
  }
  if (mouseX > bx10 && mouseX < bx10+btnSize && mouseY > by10 && mouseY < by10+btnSize) {
    setFullscreen(!fullscreenMode);
  }
  if (mouseX > bx11 && mouseX < bx11+btnSize && mouseY > by11 && mouseY < by11+btnSize) {
    exit();
  }

  if (mouseX > imgX-30 && mouseX < imgX+imgW+30 && mouseY > imgY1 && mouseY < imgY1+imgH) { showImg1=true; showImg2=false; showImg3=false; showImg4=false; }
  if (mouseX > imgX-30 && mouseX < imgX+imgW+30 && mouseY > imgY2 && mouseY < imgY2+imgH) { showImg1=false; showImg2=true; showImg3=false; showImg4=false; }
  if (mouseX > imgX-30 && mouseX < imgX+imgW+30 && mouseY > imgY3 && mouseY < imgY3+imgH) { showImg1=false; showImg2=false; showImg3=true; showImg4=false; }
  if (mouseX > imgX-30 && mouseX < imgX+imgW+30 && mouseY > imgY4 && mouseY < imgY4+imgH) { showImg1=false; showImg2=false; showImg3=false; showImg4=true; }

  if (mouseX > sbtn1X && mouseX < sbtn1X+sbtnW && mouseY > sbY && mouseY < sbY+sbtnH) {
    playSong1 = true; playSong2 = false; playSong3 = false; playSong4 = false;
    song1.rewind(); song1.play(); song2.pause(); song3.pause(); song4.pause();
    nowPlaying = meta1.title(); nowArtist = meta1.author(); nowAlbum = meta1.album();
  }
  if (mouseX > sbtn2X && mouseX < sbtn2X+sbtnW && mouseY > sbY && mouseY < sbY+sbtnH) {
    playSong1 = false; playSong2 = true; playSong3 = false; playSong4 = false;
    song2.rewind(); song2.play(); song1.pause(); song3.pause(); song4.pause();
    nowPlaying = meta2.title(); nowArtist = meta2.author(); nowAlbum = meta2.album();
  }
  if (mouseX > sbtn3X && mouseX < sbtn3X+sbtnW && mouseY > sbY && mouseY < sbY+sbtnH) {
    playSong1 = false; playSong2 = false; playSong3 = true; playSong4 = false;
    song3.rewind(); song3.play(); song1.pause(); song2.pause(); song4.pause();
    nowPlaying = meta3.title(); nowArtist = meta3.author(); nowAlbum = meta3.album();
  }
  if (mouseX > sbtn4X && mouseX < sbtn4X+sbtnW && mouseY > sbY && mouseY < sbY+sbtnH) {
    playSong1 = false; playSong2 = false; playSong3 = false; playSong4 = true;
    song4.rewind(); song4.play(); song1.pause(); song2.pause(); song3.pause();
    nowPlaying = meta4.title(); nowArtist = meta4.author(); nowAlbum = meta4.album();
  }
}

void keyPressed() {
  if (key == 'f' || key == 'F') setFullscreen(!fullscreenMode);
  if (key == 's' || key == 'S') {
    song1.pause(); song1.rewind();
    song2.pause(); song2.rewind();
    song3.pause(); song3.rewind();
    song4.pause(); song4.rewind();
    playSong1 = playSong2 = playSong3 = playSong4 = false;
  }
  if (key == 'q' || key == 'Q') exit();
}
