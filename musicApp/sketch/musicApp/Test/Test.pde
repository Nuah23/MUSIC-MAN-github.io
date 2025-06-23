import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

//import ddf.minim.*;

Minim minim;
AudioPlayer song;
PImage cover;

void setup() {
  size(700, 500);
  minim = new Minim(this);
  song = minim.loadFile("data/Drake.mp3");  
  song.play();                       

  cover = loadImage("data/download.jpg");    
  imageMode(CENTER);
}

void draw() {
  background(0);
  image(cover, width/2, height/2, 400, 400);

  // Optionally, display the song's position and length
  fill(255);
  textAlign(CENTER, BOTTOM);
  text("Time: " + nf(song.position()/1000, 1, 2) + " / " + nf(song.length()/1000, 1, 2) + " seconds", width/2, height - 20);
}
