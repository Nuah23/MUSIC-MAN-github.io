import ddf.minim.*;

// Import the Processing Sound library for sound effects (like button clicks)
import processing.sound.*; // This is for the click sound effect

// =========== SONG 1 VARIABLES ===========
String song1Title = "Laugh Now Cry Later"; // The visible title of the first song
String song1File = "data/Drake - Laugh Now Cry Later (Instrumental) ft. Lil Durk - M Max.mp3"; // The file path for song 1's music file
String song1Img = "data/download.jpg"; // The file path for song 1's album cover image
color song1Color = color(0, 0, 255); // The color blue for song 1's title

// =========== SONG 2 VARIABLES ===========
String song2Title = "Out West"; // The visible title of the second song
String song2File = "data/JACKBOYS, Travis Scott - OUT WEST (Audio) ft. Young Thug (OFFICIAL INSTRUMENTAL).mp3"; // File path for song 2's music file
String song2Img = "data/Dunhuang.jpg"; // File path for song 2's album cover image
color song2Color = color(255, 165, 0); // The color orange for song 2's title

// =========== PLAYER STATE AND OBJECTS ===========
int currentSong = 1; // Keeps track of which song is playing (1 or 2, no arrays)
Minim minim; // The Minim object manages music playback and loading
AudioPlayer song; // This will actually play the current song
PImage albumImg; // This will hold the album art image for the current song
PFont myFont; // This will be the font used for the song title text

boolean isPlaying = false; // True if the music is playing right now
boolean isRepeat = false; // True if repeat mode is on for the song
boolean isShuffle = false; // True if shuffle mode is on (random song)
boolean isPaused = false; // True if the song is paused (not stopped)
boolean isMute = false; // True if the song is muted
float volume = 0.7; // The starting volume (0 = silent, 1 = max volume)

// =========== SOUND EFFECTS ===========
SoundFile clickSound; // This will play a short click sound when a button is pressed

// =========== BUTTON SETTINGS ===========
int btnCount = 12; // There are 12 buttons in the music player
int btnSize = 60; // Each button is a 60x60 square
int btnSpacing = 18; // There are 18 pixels between each button
int btnY; // This will hold the vertical position for the row of buttons
// This array holds the label (word) for each button in order
String[] btnLabels = { "Prev", "Rew", "Play", "Pause", "Stop", "FFwd", "Next", "Repeat", "Shuffle", "Vol-", "Vol+", "Mute" };

// =========== LEAVE BUTTON (TOP RIGHT) ===========
int leaveBtnX, leaveBtnY, leaveBtnW = 100, leaveBtnH = 40; // Position and size for the "Leave" button

// =========== SEEKBAR (PROGRESS BAR) SETTINGS ===========
int seekbarX, seekbarY, seekbarW = 500, seekbarH = 20; // Position and size for the song's progress bar
boolean seeking = false; // True if the user is dragging the seekbar

// =========== VOLUME BAR (SLIDER) SETTINGS ===========
int volBarX, volBarY, volBarW = 120, volBarH = 14; // Position and size for the volume slider
boolean volDragging = false; // True if the user is dragging the volume bar

// =========== ASPECT RATIO LOCK (16:9) ===========
float aspectW = 16; // The width part of the aspect ratio
float aspectH = 9;  // The height part of the aspect ratio

// =========== FONT ASPECT RATIO (EXPERIMENTAL) ===========
float fontAspectRatio = 2.0; // This stretches the song title font horizontally

// =========== SETUP FUNCTION ===========
void setup() {
  surface.setResizable(true); // Allow the window to change size
  int winW = 1280; // Set the window's width to 1280 pixels
  int winH = int(winW * aspectH / aspectW); // Calculate the height for a 16:9 window
  surface.setSize(winW, winH); // Actually set the window size

  minim = new Minim(this); // Start Minim so you can play music
  Sound s = new Sound(this); // Start the Sound system for button click effect
  clickSound = new SoundFile(this, "data/click.wav"); // Load a sound file called click.wav for button sound

  myFont = createFont("Arial Black", 54); // Load a big bold font for song titles

  loadCurrentSong(); // Load the first song and its album art

  btnY = int(height * 0.70); // Place the row of buttons at 70% of the window height

  seekbarW = int(width * 0.5); // Make the seekbar half the window's width
  seekbarX = width / 2 - seekbarW / 2; // Center the seekbar horizontally
  seekbarY = btnY + btnSize + 60; // Place the seekbar below the buttons

  volBarX = seekbarX + seekbarW + 40; // Place the volume bar to the right of the seekbar
  volBarY = seekbarY + 6; // Line up vertically with the seekbar

  leaveBtnX = width - leaveBtnW - 40; // Put the Leave button 40px from the right edge
  leaveBtnY = 40; // Put the Leave button 40px from the top
}

// =========== DRAW FUNCTION (RUNS REPEATEDLY) ===========
void draw() {
  float currentAR = float(width) / float(height); // Calculate the current window aspect ratio
  if (abs(currentAR - aspectW / aspectH) > 0.01) { // If window isn't 16:9, add black bars
    background(0); // Paint background black (for "letterbox" effect)
    int newW = width, newH = int(width * aspectH / aspectW); // Calculate area for 16:9 content
    if (newH > height) {
      newH = height;
      newW = int(height * aspectW / aspectH);
    }
    pushMatrix(); // Save drawing settings (origin, etc)
    translate((width - newW) / 2, (height - newH) / 2); // Move origin so content is centered
    drawPlayer(newW, newH); // Draw the music player UI in the centered area
    popMatrix(); // Restore drawing settings
  } else {
    background(255); // White background for normal 16:9
    drawPlayer(width, height); // Draw the music player UI for full window
  }
}

// =========== DRAW ALL PARTS OF THE PLAYER ===========
void drawPlayer(int w, int h) {
  displayTitle(w);      // Draw the song title at the top
  displayAlbumArt(w, h); // Draw the album art image
  drawButtons(w);       // Draw the buttons for music control
  drawSeekbar(w);       // Draw the progress bar for the song
  drawSongTime(w);      // Draw the time elapsed and total time
  drawVolumeBar(w);     // Draw the volume slider
  drawLeaveButton(w);   // Draw the Leave (quit) button
  checkPlaybackState(); // Check if the song ended, and handle repeat/shuffle/next
}

// =========== DRAW THE SONG TITLE AT THE TOP ===========
void displayTitle(int w) {
  pushMatrix(); // Save drawing settings
  float fontX = w/2; // X position (middle of window)
  float fontY = 60;  // Y position (near top)
  color c = (currentSong == 1) ? song1Color : song2Color; // Pick blue or orange for the title color
  fill(c); // Set the color
  textFont(myFont); // Use the big bold font
  textAlign(CENTER, CENTER); // Center the text
  translate(fontX, fontY); // Move the drawing origin to (fontX, fontY)
  scale(fontAspectRatio, 1); // Stretch the font horizontally
  String t = (currentSong == 1) ? song1Title : song2Title; // Pick the song title
  text(t, 0, 0); // Draw the song title at (0,0) (after translate)
  popMatrix(); // Restore drawing settings
}

// =========== DRAW THE ALBUM ART IMAGE ===========
void displayAlbumArt(int w, int h) {
  if (albumImg != null) { // If the image loaded successfully
    int imgW = w/3; // Make image 1/3 of the window's width
    int imgH = h/3; // Make image 1/3 of the window's height
    image(albumImg, w/3, 80, imgW, imgH); // Draw the image in the center-ish
  } else { // If the image didn't load
    fill(200); // Gray color
    rect(w/3, 80, w/3, h/3); // Draw a gray box as a placeholder
    fill(0); // Black for text
    textSize(32); // Medium text
    textAlign(CENTER, CENTER); // Centered text
    text("Image not found", w/2, h/2); // Message in the center
  }
}

// =========== DRAW THE 12 CONTROL BUTTONS ===========
void drawButtons(int w) {
  int totalWidth = btnCount * btnSize + (btnCount - 1) * btnSpacing; // Total horizontal space for all buttons and gaps
  int startX = w / 2 - totalWidth / 2; // X position to start so buttons are centered

  for (int i = 0; i < btnCount; i++) { // For every button
    int btnX = startX + i * (btnSize + btnSpacing); // X position for this button
    fill(230); // Light gray for button background
    stroke(0); // Black border
    rect(btnX, btnY, btnSize, btnSize, 16); // Draw the button as a rounded square

    // Draw the button's label (like "Play") at the bottom of the button
    fill(0); // Black text
    textFont(createFont("Arial", 16)); // Smaller font for label
    textAlign(CENTER, CENTER); // Center the label
    text(btnLabels[i], btnX + btnSize/2, btnY + btnSize - 16); // Draw the label inside the button

    // Draw button icon (like triangle for play) above the label
    float cx = btnX + btnSize / 2; // X center of the button
    float cy = btnY + btnSize / 2 - 8; // Y center of the button, shifted up for label
    float s = 17; // Size for icons
    switch(i) { // Pick icon based on button number
      case 0: // Previous
        triangle(cx-18, cy, cx-4, cy-14, cx-4, cy+14); // Triangle
        rect(cx+6, cy-14, 6, 28); // Bar
        break;
      case 1: // Rewind
        triangle(cx-12, cy, cx+2, cy-14, cx+2, cy+14); // Triangle
        triangle(cx+2, cy, cx+16, cy-14, cx+16, cy+14); // Triangle
        break;
      case 2: // Play
        triangle(cx-10, cy-16, cx-10, cy+16, cx+18, cy); // Triangle
        break;
      case 3: // Pause
        rect(cx-10, cy-16, 8, 32); // Left bar
        rect(cx+4, cy-16, 8, 32); // Right bar
        break;
      case 4: // Stop
        rect(cx-13, cy-13, 26, 26); // Square
        break;
      case 5: // Fast Forward
        triangle(cx-2, cy, cx-16, cy-14, cx-16, cy+14); // Triangle
        triangle(cx-16, cy, cx-30, cy-14, cx-30, cy+14); // Triangle
        break;
      case 6: // Next
        triangle(cx+4, cy, cx+18, cy-14, cx+18, cy+14); // Triangle
        rect(cx-10, cy-14, 6, 28); // Bar
        break;
      case 7: // Repeat
        noFill(); stroke(0); // Only draw lines/arcs
        arc(cx, cy, 28, 28, PI, TWO_PI+HALF_PI); // Arc for repeat
        arc(cx, cy, 28, 28, 0, PI/2); // Second arc
        fill(0); noStroke(); // Black triangles for arrowheads
        triangle(cx+12, cy+4, cx+18, cy+4, cx+15, cy+11);
        triangle(cx-18, cy-4, cx-12, cy-4, cx-15, cy-11);
        break;
      case 8: // Shuffle
        stroke(0); noFill(); // Only draw lines
        beginShape();
        vertex(cx-15,cy+8); vertex(cx, cy-8); vertex(cx+15,cy+8);
        endShape();
        ellipse(cx+15, cy+8, 6, 6); // Dot
        break;
      case 9: // Volume Down
        rect(cx-15, cy-7, 10, 14, 4); // Speaker box
        triangle(cx-5, cy-15, cx+12, cy, cx-5, cy+15); // Sound cone
        line(cx+16, cy-8, cx+16, cy+8); // Minus sign
        break;
      case 10: // Volume Up
        rect(cx-15, cy-7, 10, 14, 4); // Speaker box
        triangle(cx-5, cy-15, cx+12, cy, cx-5, cy+15); // Sound cone
        line(cx+16, cy-8, cx+16, cy+8); // Plus sign vertical
        line(cx+20, cy-12, cx+20, cy+12); // Plus sign horizontal
        break;
      case 11: // Mute
        rect(cx-15, cy-7, 10, 14, 4); // Speaker box
        triangle(cx-5, cy-15, cx+12, cy, cx-5, cy+15); // Sound cone
        stroke(255,0,0); strokeWeight(3); // Red X
        line(cx+15, cy-12, cx+25, cy+12);
        line(cx+25, cy-12, cx+15, cy+12);
        strokeWeight(1); // Reset stroke weight
        break;
    }
  }
}

// =========== DRAW THE SONG PROGRESS BAR ===========
void drawSeekbar(int w) {
  if (song == null) return; // Only draw if a song is loaded
  fill(210); noStroke(); // Gray background
  rect(seekbarX, seekbarY, seekbarW, seekbarH, 9); // Draw the seekbar background
  float frac = map(song.position(), 0, song.length(), 0, 1); // Calculate how much of the song has played (0 to 1)
  fill(80,150,255); // Blue fill for played part
  rect(seekbarX, seekbarY, seekbarW * frac, seekbarH, 9); // Draw the filled part
  float handleX = seekbarX + seekbarW * frac; // Position of the handle
  fill(40, 90, 200); // Dark blue handle
  ellipse(handleX, seekbarY + seekbarH/2, seekbarH+8, seekbarH+8); // Draw handle
}

// =========== DRAW THE TIME COUNTER ===========
void drawSongTime(int w) {
  if (song != null) { // Only if song loaded
    int pos = song.position(); // Current position (ms)
    int len = song.length();   // Total length (ms)
    String posStr = formatMillis(pos); // Make "mm:ss"
    String lenStr = formatMillis(len); // Make "mm:ss"
    fill(0); // Black text
    textFont(createFont("Arial", 32));
    textAlign(CENTER, CENTER);
    text(posStr + " / " + lenStr, w / 2, seekbarY - 32); // Display both times above the seekbar
  }
}

// =========== FORMAT MILLISECONDS TO MINUTES:SECONDS ===========
String formatMillis(int ms) {
  int seconds = ms / 1000; // Convert ms to total seconds
  int min = seconds / 60; // Minutes
  int sec = seconds % 60; // Seconds left over
  return nf(min, 2) + ":" + nf(sec, 2); // Format as "mm:ss"
}

// =========== DRAW THE VOLUME SLIDER ===========
void drawVolumeBar(int w) {
  fill(210); // Gray background
  rect(volBarX, volBarY, volBarW, volBarH, 7); // Draw the volume bar background
  float vFrac = volume; // How much of the bar is filled
  fill(100,200,120); // Green fill
  rect(volBarX, volBarY, volBarW * vFrac, volBarH, 7); // Draw filled portion
  fill(0); // Black handle
  ellipse(volBarX + volBarW * vFrac, volBarY + volBarH/2, volBarH+8, volBarH+8); // Draw handle
  textAlign(LEFT, CENTER); // Align text to the left
  textFont(createFont("Arial", 20));
  fill(0);
  text(int(volume * 100) + "%", volBarX + volBarW + 15, volBarY + volBarH/2); // Show percentage
}

// =========== DRAW THE LEAVE BUTTON ===========
void drawLeaveButton(int w) {
  fill(255, 80, 80); // Red background
  stroke(0); // Black border
  rect(leaveBtnX, leaveBtnY, leaveBtnW, leaveBtnH, 12); // Draw the leave button
  fill(255); // White text
  textFont(createFont("Arial", 20));
  textAlign(CENTER, CENTER);
  text("Leave", leaveBtnX + leaveBtnW/2, leaveBtnY + leaveBtnH/2); // Write "Leave"
}

// =========== HANDLE MOUSE PRESSES ===========
void mousePressed() {
  if (mouseX > leaveBtnX && mouseX < leaveBtnX + leaveBtnW &&
      mouseY > leaveBtnY && mouseY < leaveBtnY + leaveBtnH) {
    exit(); // If Leave button is clicked, quit the app
    return;
  }

  int totalWidth = btnCount * btnSize + (btnCount - 1) * btnSpacing; // Total width of all buttons
  int startX = width / 2 - totalWidth / 2; // Start X for first button
  for (int i = 0; i < btnCount; i++) { // For each button
    int btnX = startX + i * (btnSize + btnSpacing); // Calculate button X
    if (mouseX > btnX && mouseX < btnX + btnSize &&
        mouseY > btnY && mouseY < btnY + btnSize) {
      playClick(); // Play click sound
      handleButton(i); // Respond to this button
      return; // Stop after first button found
    }
  }

  if (mouseX > seekbarX && mouseX < seekbarX + seekbarW &&
      mouseY > seekbarY && mouseY < seekbarY + seekbarH) {
    seeking = true; // User is dragging the seekbar
    seekTo(mouseX); // Go to that part of the song
    playClick(); // Play click sound
    return;
  }

  if (mouseX > volBarX && mouseX < volBarX + volBarW &&
      mouseY > volBarY && mouseY < volBarY + volBarH) {
    volDragging = true; // User is dragging the volume bar
    setVolume(mouseX); // Set volume from mouse position
    playClick(); // Play click sound
    return;
  }
}

// =========== HANDLE MOUSE DRAGGING ===========
void mouseDragged() {
  if (seeking) seekTo(mouseX); // Update song position if dragging seekbar
  if (volDragging) setVolume(mouseX); // Update volume if dragging volume bar
}

// =========== HANDLE MOUSE RELEASE ===========
void mouseReleased() {
  seeking = false; // Stop dragging seekbar
  volDragging = false; // Stop dragging volume
}

// =========== JUMP TO NEW SONG POSITION ===========
void seekTo(int mx) {
  if (song != null && song.length() > 0) {
    float frac = constrain((mx - seekbarX) / float(seekbarW), 0, 1); // Find percent along seekbar
    song.cue(int(song.length() * frac)); // Move to that position
  }
}

// =========== SET VOLUME BASED ON MOUSE ===========
void setVolume(int mx) {
  volume = constrain((mx - volBarX) / float(volBarW), 0, 1); // Find percent along volume bar
  if (song != null) {
    if (isMute) song.setGain(-80); // If muted, set volume to minimum
    else song.setGain(map(volume, 0, 1, -80, 0)); // Otherwise, set to desired volume
  }
}

// =========== PLAY CLICK SOUND ===========
void playClick() {
  if (clickSound != null) clickSound.play(); // Play click sound if loaded
}

// =========== HANDLE BUTTON ACTIONS ===========
void handleButton(int i) {
  switch(i) {
    case 0: // Previous song
      switchSong(); // Go to the other song (1 <-> 2)
      break;
    case 1: // Rewind 5 sec
      if (song != null) song.cue(max(0, song.position() - 5000));
      break;
    case 2: // Play
      if (song != null && !isPlaying) {
        song.play();
        isPlaying = true;
        isPaused = false;
      }
      break;
    case 3: // Pause
      if (song != null && isPlaying && !isPaused) {
        song.pause();
        isPaused*

