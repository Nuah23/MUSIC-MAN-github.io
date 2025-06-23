//Library - Minim
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;
//
//Global Variables
Minim minim; //initates entire class
int numberOfSongs = 4; //Updated for 4 audio files
//int numberOfSoundEffects = ???
AudioPlayer[] playList = new AudioPlayer[ numberOfSongs ];
//AudioPlayer[] soundEffects = new AudioPlayer[ numberOfSoundEffects ];
AudioMetaData[] playListMetaData = new AudioMetaData[ numberOfSongs ];
int currentSong = numberOfSongs - numberOfSongs; //ZERO
//
float quitX, quitY, quitWidth, quitHeight;
float imageDivX, imageDivY, imageDivWidth, imageDivHeight;
float messageDIV_X, messageDIV_Y, messageDIV_Width, messageDIV_Height;
float stopDivX, stopDivY, stopDivWidth, stopDivHeight;
float muteDivX, muteDivY, muteDivWidth, muteDivHeight;
float previousDivX, previousDivY, previousDivWidth, previousDivHeight;
float fastRewindDivX, fastRewindDivY, fastRewindDivWidth, fastRewindDivHeight;
float pauseDivX, pauseDivY, pauseDivWidth, pauseDivHeight;
float playDivX, playDivY, playDivWidth, playDivHeight;
float loopOnceDivX, loopOnceDivY, loopOnceDivWidth, loopOnceDivHeight;
float loopInfiniteDivX, loopInfiniteDivY, loopInfiniteDivWidth, loopInfiniteDivHeight;
float fastForwardDivX, fastForwardDivY, fastForwardDivWidth, fastForwardDivHeight;
float nextDivX, nextDivY, nextDivWidth, nextDivHeight;
float shuffleDivX, shuffleDivY, shuffleDivWidth, shuffleDivHeight;
float songPositionDivX, songPositionDivY, songPositionDivWidth, songPositionDivHeight;
float timeRemainingDivX, timeRemainingDivY, timeRemainingDivWidth, timeRemainingDivHeight;
float songTitleDivX, songTitleDivY, songTitleDivWidth, songTitleDivHeight;
float timeBarDivX, timeBarDivY, timeBarDivWidth, timeBarDivHeight;
float totalTimeDivX, totalTimeDivY, totalTimeDivWidth, totalTimeDivHeight;
//
//Button Shape Variables
float stopButtonX, stopButtonY, stopButtonWidth, stopButtonHeight;
float playX1, playY1, playX2, playY2, playX3, playY3;
float fastForwardX1, fastForwardY1, fastForwardX2, fastForwardY2, fastForwardX3, fastForwardY3;
float fastForwardX4, fastForwardY4, fastForwardX5, fastForwardY5, fastForwardX6, fastForwardY6;
float pauseX1, pauseY1, pauseWidth1, pauseHeight1;
float pauseX2, pauseY2, pauseWidth2, pauseHeight2;
//
PImage myFirstImage, mySecondImage;
float imageWidthChanged_First, imageHeightChanged_First;
float imageWidthChanged_Second, imageHeightChanged_Second;
//
PFont appFont;
float fontSize;
//
void setup() {
  //Display
  //fullScreen();
  size(700, 500);
  int appWidth = width; //displayWidth
  int appHeight = height; //displayHeight
  int appShortSide = ( appWidth < appHeight ) ? appWidth : appHeight ;
  //
  //Music Loading - STRUCTURED
  minim = new Minim(this);

  // --- ONLY THE LINES BELOW ARE CHANGED ---
  String[] songNames = {
    "Drake - Laugh Now Cry Later (Instrumental) ft. Lil Durk - M Max",
    "playboi carti - stop breathing instrumental - prod antoniolamar",
    "Three 6 Mafia - Poppin' My Collar [Instrumental] - Crucial Mixtapes",
    "JACKBOYS, Travis Scott - OUT WEST (Audio) ft. Young Thug (OFFICIAL INSTRUMENTAL)"
  };
  String fileExtension_mp3 = ".mp3";
  String musicDirectory = "data/";

  for (int i = 0; i < numberOfSongs; i++) {
    String file = musicDirectory + songNames[i] ;
    playList[i] = minim.loadFile(file);
    
  }
  currentSong=0;
  // --- END OF CHANGED SECTION ---

  //println("Start of Console");
  //Fonts from OS
  /*
  String[] fontList = PFont.list(); //To list all fonts available on system
   printArray(fontList); //For listing all possible fonts to choose, then createFont
   */
  appFont = createFont ("Candara", appShortSide); //Verify font exists
  //Tools / Create Font / Find Font / Do Not Press "OK", known bug, cannot mix loadFont() and createFont()
  //
  //Population
  //rect(DIV) is a square to start, by design
  int numberOfButtons = 13; //Half a button on either side as space, Center Button is Play
  int widthOfButton = appWidth/numberOfButtons;
  int beginningButtonSpace = widthOfButton;
  int buttonY = appHeight*3/5;
  //
  quitX = appWidth - appShortSide*1/20;
  quitY = 0;
  quitWidth = appShortSide*1/20;
  quitHeight = appShortSide*1/20;
  songTitleDivX = beginningButtonSpace;
  songTitleDivY = appHeight*1.5/20;
  songTitleDivWidth = appWidth*1/2 - beginningButtonSpace*1.5;
  songTitleDivHeight = appHeight*1/10;
  imageDivX = beginningButtonSpace;
  imageDivY = appHeight*4.5/20;
  imageDivWidth = appWidth*1/2 - beginningButtonSpace*1.5;
  imageDivHeight = appHeight*1.5/5; //1+1.5=2.5, half of the total height
  messageDIV_X = appWidth*1/2 + beginningButtonSpace*1/2;
  messageDIV_Y = appHeight*1.5/20;
  messageDIV_Width = appWidth*1/2 - beginningButtonSpace*1.5;
  messageDIV_Height = appHeight*9/20;
  //
  stopDivX = beginningButtonSpace + widthOfButton*0;
  stopDivY = buttonY;
  stopDivWidth = widthOfButton;
  stopDivHeight = widthOfButton;
  //
  //STOP BUTTON
  stopButtonX = stopDivX + stopDivWidth*1/4;
  stopButtonY = stopDivY + stopDivHeight*1/4;
  stopButtonWidth = widthOfButton*1/2;
  stopButtonHeight = widthOfButton*1/2;
  //
  muteDivX = beginningButtonSpace + widthOfButton*1;
  muteDivY = buttonY;
  muteDivWidth = widthOfButton;
  muteDivHeight = widthOfButton;
  previousDivX = beginningButtonSpace + widthOfButton*2;
  previousDivY = buttonY;
  previousDivWidth = widthOfButton;
  previousDivHeight = widthOfButton;
  fastRewindDivX = beginningButtonSpace + widthOfButton*3;
  fastRewindDivY = buttonY;
  fastRewindDivWidth = widthOfButton;
  fastRewindDivHeight = widthOfButton;
  pauseDivX = beginningButtonSpace + widthOfButton*4;
  pauseDivY = buttonY;
  pauseDivWidth = widthOfButton;
  pauseDivHeight = widthOfButton;
  //
  //Pause Button
  pauseX1 = pauseDivX + pauseDivWidth*1/4;
  pauseY1 = pauseDivY + pauseDivHeight*1/4;
  pauseWidth1 = pauseDivWidth*1/8;
  pauseHeight1 = pauseDivHeight*1/2;
  pauseX2 = pauseDivX + pauseDivWidth*5/8;
  pauseY2 = pauseDivY + pauseDivHeight*1/4;
  pauseWidth2 = pauseDivWidth*1/8;
  pauseHeight2 = pauseDivHeight*1/2;
  //
  playDivX = beginningButtonSpace + widthOfButton*5; //TEACHER Only" manipulate this number to draw simulate all buttons
  playDivY = buttonY;
  playDivWidth = widthOfButton;
  playDivHeight = widthOfButton;
  //
  //Play Button
  playX1 = playDivX + playDivWidth*1/4;
  playY1 = playDivY + playDivHeight*1/4;
  playX2 = playDivX + playDivWidth*3/4;
  playY2 = playDivY + playDivHeight*1/2;
  playX3 = playDivX + playDivWidth*1/4;
  playY3 = playDivY + playDivHeight*3/4;
  //
  loopOnceDivX = beginningButtonSpace + widthOfButton*6;
  loopOnceDivY = buttonY;
  loopOnceDivWidth = widthOfButton;
  loopOnceDivHeight = widthOfButton;
  loopInfiniteDivX = beginningButtonSpace + widthOfButton*7;
  loopInfiniteDivY = buttonY;
  loopInfiniteDivWidth = widthOfButton;
  loopInfiniteDivHeight = widthOfButton;
  fastForwardDivX = beginningButtonSpace + widthOfButton*8;
  fastForwardDivY = buttonY;
  fastForwardDivWidth = widthOfButton;
  fastForwardDivHeight = widthOfButton;
  //
  //Fast Forward Button
  fastForwardX1 = fastForwardDivX + fastForwardDivWidth*1/4;
  fastForwardY1 = fastForwardDivY + fastForwardDivHeight*1/4;
  fastForwardX2 = fastForwardDivX + fastForwardDivWidth*1/2;
  fastForwardY2 = fastForwardDivY + fastForwardDivHeight*1/2;
  fastForwardX3 = fastForwardDivX + fastForwardDivWidth*1/4;
  fastForwardY3 = fastForwardDivY + fastForwardDivHeight*3/4;
  fastForwardX4 = fastForwardDivX + fastForwardDivWidth*1/2;
  fastForwardY4 = fastForwardDivY + fastForwardDivHeight*1/4;
  fastForwardX5 = fastForwardDivX + fastForwardDivWidth*3/4;
  fastForwardY5 = fastForwardDivY + fastForwardDivHeight*1/2;
  fastForwardX6 = fastForwardDivX + fastForwardDivWidth*1/2;
  fastForwardY6 = fastForwardDivY + fastForwardDivHeight*3/4;
  //
  nextDivX = beginningButtonSpace + widthOfButton*9;
  nextDivY = buttonY;
  nextDivWidth = widthOfButton;
  nextDivHeight = widthOfButton;
  shuffleDivX = beginningButtonSpace + widthOfButton*10;
  shuffleDivY = buttonY;
  shuffleDivWidth = widthOfButton;
  shuffleDivHeight = widthOfButton;
  //
  float musicSongPaddingY = widthOfButton*1/4;
  float musicSongSpaceX = stopDivX;
  float musicSongSpaceY = stopDivY + widthOfButton + musicSongPaddingY;
  float musicSongSpaceWidth = appWidth - widthOfButton*2;
  float musicSongSpaceHeight = appHeight - musicSongPaddingY - musicSongSpaceY;
  //rect(musicSongSpaceX, musicSongSpaceY, musicSongSpaceWidth, musicSongSpaceHeight); //testing only
  songPositionDivX = musicSongSpaceX;
  songPositionDivY = musicSongSpaceY;
  songPositionDivWidth = musicSongSpaceWidth*1/5;
  songPositionDivHeight = musicSongSpaceHeight*2/5;
  timeRemainingDivX = musicSongSpaceX + musicSongSpaceWidth*3/5;
  timeRemainingDivY = musicSongSpaceY + musicSongSpaceHeight*3/5;
  timeRemainingDivWidth = musicSongSpaceWidth*1/5;
  timeRemainingDivHeight = musicSongSpaceHeight*2/5;
  totalTimeDivX = musicSongSpaceX + musicSongSpaceWidth*4/5;
  totalTimeDivY = musicSongSpaceY + musicSongSpaceHeight*3/5;
  totalTimeDivWidth = musicSongSpaceWidth*1/5;
  totalTimeDivHeight = musicSongSpaceHeight*2/5;
  float musicSongSpaceButtonHeight = musicSongSpaceHeight*1/5;
  timeBarDivX = musicSongSpaceX;
  timeBarDivY = musicSongSpaceY + musicSongSpaceHeight*2/5;
  timeBarDivWidth = musicSongSpaceWidth;
  timeBarDivHeight = musicSongSpaceHeight*1/5;
  //
  //DIVs
  //rect(X, Y, Width, Height)
  rect(quitX, quitY, quitWidth, quitHeight);
  rect(imageDivX, imageDivY, imageDivWidth, imageDivHeight);
  rect(messageDIV_X, messageDIV_Y, messageDIV_Width, messageDIV_Height);
  rect(stopDivX, stopDivY, stopDivWidth, stopDivHeight);  //*0
  rect(muteDivX, muteDivY, muteDivWidth, muteDivHeight); //*1
  rect(previousDivX, previousDivY, previousDivWidth, previousDivHeight); //*2
  rect(fastRewindDivX, fastRewindDivY, fastRewindDivWidth, fastRewindDivHeight); //*3
  rect(pauseDivX, pauseDivY, pauseDivWidth, pauseDivHeight); //*4
  rect(playDivX, playDivY, playDivWidth, playDivHeight); //*5
  rect(loopOnceDivX, loopOnceDivY, loopOnceDivWidth, loopOnceDivHeight);
  rect(loopInfiniteDivX, loopInfiniteDivY, loopInfiniteDivWidth, loopInfiniteDivHeight);
  rect(fastForwardDivX, fastForwardDivY, fastForwardDivWidth, fastForwardDivHeight);
  rect(nextDivX, nextDivY, nextDivWidth, nextDivHeight);
  rect(shuffleDivX, shuffleDivY, shuffleDivWidth, shuffleDivHeight);
  rect(songPositionDivX, songPositionDivY, songPositionDivWidth, songPositionDivHeight);
  rect(songTitleDivX, songTitleDivY, songTitleDivWidth, songTitleDivHeight);
  rect(timeBarDivX, timeBarDivY, timeBarDivWidth, timeBarDivHeight);
  rect(timeRemainingDivX, timeRemainingDivY, timeRemainingDivWidth, timeRemainingDivHeight);
  rect(totalTimeDivX, totalTimeDivY, totalTimeDivWidth, totalTimeDivHeight);
  //
  //rect(timeBarDivX, timeBarDivY, timeBarDivWidth, timeBarDivHeight);
  rect(stopButtonX, stopButtonY, stopButtonWidth, stopButtonHeight);
  triangle(playX1, playY1, playX2, playY2, playX3, playY3);
  triangle(fastForwardX1, fastForwardY1, fastForwardX2, fastForwardY2, fastForwardX3, fastForwardY3);
  triangle(fastForwardX4, fastForwardY4, fastForwardX5, fastForwardY5, fastForwardX6, fastForwardY6);
  rect(pauseX1, pauseY1, pauseWidth1, pauseHeight1);
  rect(pauseX2, pauseY2, pauseWidth2, pauseHeight2);
  //
  //Images Drawing
  //
  //Image Aspect Ratio Algorithm: demonstrating Landscape to Portrait
  String upArrow = "../";
  String folders = "data/";
  String download = "download.jpg"; //Fpr QUIT Button
  String dunhuang = "Dunhuang.jpg"; //MAIN Image DIV
  
  
  String myFirstImagePathway = upArrow + folders + dunhuang ;
  String mySecondImagePathway = upArrow + folders + download;
  myFirstImage = loadImage( myFirstImagePathway );
  mySecondImage = loadImage( mySecondImagePathway );
  int myFirstImageWidth = 2800;
  int myFirstImageHeight = 3500;
  int mySecondImageWidth = 860;
  int mySecondImageHeight = 529;
  float imageAspectRatioFirst_GreaterOne = ( myFirstImageWidth >= myFirstImageHeight ) ? float(myFirstImageWidth)/float(myFirstImageHeight) : float(myFirstImageHeight)/float(myFirstImageWidth) ; // Choice x / for bigger or smaller
  float imageAspectRatioSecond_GreaterOne = ( mySecondImageWidth >= mySecondImageHeight ) ? float(mySecondImageWidth)/float(mySecondImageHeight) : float(mySecondImageHeight)/float(mySecondImageWidth) ; // Choice x / for bigger or smaller
  Boolean imageLandscapeFirst = ( myFirstImageWidth >= myFirstImageHeight ) ? true : false ;
  Boolean imageLandscapeSecond = ( mySecondImageWidth >= mySecondImageHeight ) ? true : false ;
  
  if ( imageLandscapeFirst==true ) {
    imageWidthChanged_First = imageDivWidth;
    imageHeightChanged_First = ( myFirstImageWidth >= imageDivWidth ) ? imageWidthChanged_First/imageAspectRatioFirst_GreaterOne : imageWidthChanged_First*imageAspectRatioFirst_GreaterOne ;
    if ( imageHeightChanged_First > imageDivHeight ) { //ERROR Catch
      println("First Image Aspect Ratio algorithm Landscape ERROR");
      exit();
      //noLoop(); //Debugging only
    }
  } else {
    imageHeightChanged_First = imageDivHeight;
    imageWidthChanged_First = ( myFirstImageHeight >= imageDivHeight ) ? imageHeightChanged_First/imageAspectRatioFirst_GreaterOne : imageHeightChanged_First*imageAspectRatioFirst_GreaterOne ;
    if ( imageWidthChanged_First > imageDivWidth ) { //ERROR Catch
      println("First Image Aspect Ratio algorithm Portrait ERROR");
      exit();
      //noLoop(); //Debugging only
    }
  }
  
  image( myFirstImage, imageDivX, imageDivY, imageWidthChanged_First, imageHeightChanged_First );
  
  if ( imageLandscapeSecond==true ) {
    imageWidthChanged_Second = quitWidth;
    imageHeightChanged_Second = ( mySecondImageWidth >= quitWidth ) ? imageWidthChanged_Second/imageAspectRatioSecond_GreaterOne : imageWidthChanged_Second*imageAspectRatioSecond_GreaterOne ;
    if ( imageHeightChanged_Second > quitHeight ) { //ERROR Catch
      println("Second Image Aspect Ratio algorithm Landscape ERROR");
      exit();
      //noLoop(); //Debugging only
    }
  } else {
    imageHeightChanged_Second = quitHeight;
    imageWidthChanged_Second = ( mySecondImageHeight >= quitHeight ) ? imageHeightChanged_Second/imageAspectRatioSecond_GreaterOne : imageHeightChanged_Second*imageAspectRatioSecond_GreaterOne ;
    if ( imageWidthChanged_Second > quitWidth ) { //ERROR Catch
      println("Second Image Aspect Ratio algorithm Portrait ERROR");
      exit();
      //noLoop(); //Debugging only
    }
  }
  // Bike Image in QUIT Div
  image( mySecondImage, quitX, quitY, imageWidthChanged_Second, imageHeightChanged_Second );
  //
  //Font Size relative to rect(height)
  float fontSize = 52; //Change the number until it fits, largest font size, int only to ease guessing
  //
  /* Aspect Ratio Manipulations (changes to variables)
   - choose Aspect Ratio that must be mutliplied: fontSize/titleHeight
   - Rewriting fontSize with formulae
   */
  float candaraAspectRatio = fontSize / songTitleDivHeight;
  fontSize = songTitleDivHeight*candaraAspectRatio;
  //
  //Minimum Lines of code to format and draw text with colour
  color purpleInk = #2C08FF;
  fill(purpleInk); //Ink, hexidecimal copied from Color Selector
  textAlign (CENTER, CENTER); //Align X&Y, see Processing.org / Reference
  //Values: [LEFT | CENTER | RIGHT] & [TOP | CENTER | BOTTOM | BASELINE]
  textFont(appFont, fontSize); //see variable note
  //textFont() has option to combine font declaration with textSize()
  //
  //Drawing Text
  //Option draw ```title```
  //Decrease Font when wrapped around
  while ( songTitleDivWidth < textWidth( playListMetaData[currentSong].title() ) ) { //decrease font
    fontSize *= 0.99; //Assignment Operator  //fontSize = fontSize*0.99;
    //Update WHILE Conditional with fontSize
    textFont(appFont, fontSize);
  } //End Wrap-Around Notification
  //
  //Option, drawing ```title``` v playListMetaData[currentSong].title()
  text(playListMetaData[currentSong].title(), songTitleDivX, songTitleDivY, songTitleDivWidth, songTitleDivHeight);
  color whiteInk = #FFFFFF;
  fill(whiteInk); //reset
 
} //End setup
//
void draw() {
  //Song title and individual song time data will change, see .mp3 exemplar programs
  //QUIT Button - Hoverover and activate
  //QUIT Button - Save the Last Song
  //HoverOver for all Buttons - Procedures
} //End draw
//
void mousePressed() {
  //QUIT Button to form
  //Data Structure for: mouseX> && mouseX< && mouseY> && mouseY<
  if ( mouseX>quitX && mouseX<quitX+quitWidth && mouseY>quitY && mouseY<quitY+quitHeight ) {
    //Procedures: active Saving Program state or last song, prompt a double click for exit()
    //Use a procedure to access mouse & key board
    exit();
  }
} //End mousePressed
//
void keyPressed() {
  /* Key Board Short Cuts ... learning what the Music Buttons could be
   Note: CAP Lock with ||
   if ( key==? || key==? ) ; //'' only
   -
   if ( key==CODED || keyCode==SpecialKey ) ; //Special Keys abriviated CAPS
   All Music Player Features are built out of these Minim AudioPlayer() functions
   .isPlaying()
   .isMuted()
   .loop(0), parameter is number of iterations after play
   .loop(), parameter is infinite interations
   .play(), parameter is built-in skip (milli-seconds or crystal-time)
   .pause()
   .rewind()
   .skip()
   .unmute()
   .mute()
   -
   Lesson Music Button Features based on single, double, and spamming taps
   - Play
   - Pause
   - Stop
   - Loop Once
   - Loop Infinite
   - Fast Forward
   - Fast Rewind
   - Mute
   - Next Song
   - Previous Song
   - Shuffle
   -
   - Advanced Buttons & Combinations
   - Play-Pause-Stop
   - Auto Play
   - Random Song
   */
  //if ( key=='P' || key=='p' ) playList[currentSong].play(); //Simple Play, no double tap possible
  //
  if ( key=='P' || key=='p' ) playList[currentSong].loop(0); //Simple Play, double tap possible
  /* Note: double tap is automatic rewind, no pause
   Symbol is two triangles
   This changes what the button might become after it is pressed
   */
  if ( key=='O' || key=='o' ) { // Pause
    //
    if ( playList[currentSong].isPlaying() ) {
      playList[currentSong].pause();
    } else {
      playList[currentSong].play();
    }
  }
  //if ( key=='S' || key=='s' ) song[currentSong].pause(); //Simple Stop, no double taps
  //
  if ( key=='S' | key=='s' ) {
    if ( playList[currentSong].isPlaying() ) {
      playList[currentSong].pause(); //single tap
    } else {
      playList[currentSong].rewind(); //double tap
    }
  }
  if ( key=='L' || key=='l' ) playList[currentSong].loop(1); // Loop ONCE: Plays, then plays again, then stops & rewinds
  if ( key=='K' || key=='k' ) playList[currentSong].loop(); // Loop Infinitely //Parameter: BLANK or -1
  if ( key=='F' || key=='f' ) playList[currentSong].skip( 10000 ); // Fast Forward, Rewind, & Play Again //Parameter: milliseconds
  if ( key=='R' || key=='r' ) playList[currentSong].skip( -10000 ); // Fast Reverse & Play //Parameter: negative numbers
  if ( key=='W' || key=='w' ) { // MUTE
    //
    //MUTE Behaviour: stops electricty to speakers, does not stop file
    //NOTE: MUTE has NO built-in PUASE button, NO built-in rewind button
    //ERROR: if song near end of file, user will not know song is at the end
    //Known ERROR: once song plays, MUTE acts like it doesn't work
    if ( playList[currentSong].isMuted() ) {
      //ERROR: song might not be playing
      //CATCH: ask .isPlaying() or !.isPlaying()
      playList[currentSong].unmute();
    } else {
      //Possible ERROR: Might rewind the song
      playList[currentSong].mute();
    }
  }
  if ( key==CODED || keyCode==ESC ) exit(); // QUIT //UP
  if ( key=='Q' || key=='q' ) exit(); // QUIT
  //
  if ( key=='N' || key=='n' ) { // NEXT //See .txt for starter hint
    if ( playList[currentSong].isPlaying() ) {
      playList[currentSong].pause();
      playList[currentSong].rewind();
      //
      if ( currentSong==numberOfSongs-1 ) {
        currentSong = 0;
      } else {
        currentSong++;
      }
      playList[currentSong].play();
    } else {
      //
      playList[currentSong].rewind();
      //
      if ( currentSong==numberOfSongs-1 ) {
        currentSong = 0;
      } else {
        currentSong++;
      }
      // NEXT will not automatically play the song
      //song[currentSong].play();
    }
  }
  //if ( key=='P' || key=='p' ) ; // Previous //Students to finish
  //
  //if ( key=='S' || key=='s' ) ; // Shuffle - PLAY (Random)
  //Note: will randomize the currentSong number
  //Caution: random() is used very often
  //Question: how does truncating decimals affect returning random() floats
  /*
  if ( key=='' || key=='' ) ; // Play-Pause-STOP //Advanced, beyond single buttons
   - need to have basic GUI complete first
   */
  //
} //End keyPressed
//
// End Main Program
