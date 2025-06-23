import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

import ddf.minim.*;

Minim minim;
AudioPlayer song;
PImage cover;
boolean isMuted = false;
float volume = 0.5;



void setup() {
  size(800, 600);
  minim = new Minim(this);
  song = minim.loadFile("data/Drake.mp3");
  song.play();
  

  cover = loadImage("data/download.jpg");
  imageMode(CENTER);


}
