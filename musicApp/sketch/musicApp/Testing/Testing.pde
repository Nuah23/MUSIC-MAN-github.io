// Import the Minim audio library
import ddf.minim.*;

Minim minim;
AudioPlayer song;
PImage cover;

void setup() {
  size(500, 500); // Set window size

  

  // Initialize Minim and load song
  minim = new Minim(this);
  song = minim.loadFile("../data/Drake.mp3");

  // Play the song
  song.play();
}

void draw() {
  
}
