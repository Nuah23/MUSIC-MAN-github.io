// Library - Minim
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

// Global Variables
Minim audioEngine; // initializes Minim
int totalSongs = 1; // Best Practice
//int totalEffects = ???;
AudioPlayer[] songList = new AudioPlayer[ totalSongs ];
//AudioPlayer[] effectList = new AudioPlayer[ totalEffects ];
AudioMetaData[] songMetaData = new AudioMetaData[ totalSongs ];
int selectedSong = 0;

// UI Layout Variables
float exitBtnX, exitBtnY, exitBtnW, exitBtnH;
float artworkDivX, artworkDivY, artworkDivW, artworkDivH;
float stopBtnX, stopBtnY, stopBtnW, stopBtnH;
float muteBtnX, muteBtnY, muteBtnW, muteBtnH;
float prevBtnX, prevBtnY, prevBtnW, prevBtnH;
float rewindBtnX, rewindBtnY, rewindBtnW, rewindBtnH;
float pauseBtnX, pauseBtnY, pauseBtnW, pauseBtnH;
float playBtnX, playBtnY, playBtnW, playBtnH;
float loopOnceBtnX, loopOnceBtnY, loopOnceBtnW, loopOnceBtnH;
float loopForeverBtnX, loopForeverBtnY, loopForeverBtnW, loopForeverBtnH;
float fwdBtnX, fwdBtnY, fwdBtnW, fwdBtnH;
float nextBtnX, nextBtnY, nextBtnW, nextBtnH;
float shuffleBtnX, shuffleBtnY, shuffleBtnW, shuffleBtnH;
float currentPosX, currentPosY, currentPosW, currentPosH;
float timeLeftX, timeLeftY, timeLeftW, timeLeftH;
float songNameX, songNameY, songNameW, songNameH;
float progressBarX, progressBarY, progressBarW, progressBarH;
float songDurationX, songDurationY, songDurationW, songDurationH;

// Button Shapes
float stopSymbolX, stopSymbolY, stopSymbolW, stopSymbolH;
float playTriangleX1, playTriangleY1, playTriangleX2, playTriangleY2, playTriangleX3, playTriangleY3;
float fwdTriangleX1, fwdTriangleY1, fwdTriangleX2, fwdTriangleY2, fwdTriangleX3, fwdTriangleY3;
float fwdTriangleX4, fwdTriangleY4, fwdTriangleX5, fwdTriangleY5, fwdTriangleX6, fwdTriangleY6;
float pauseRectX1, pauseRectY1, pauseRectW1, pauseRectH1;
float pauseRectX2, pauseRectY2, pauseRectW2, pauseRectH2;

// Graphics & Fonts
PImage albumArt;
float albumArtX, albumArtY, albumArtW, albumArtH;

PFont interfaceFont;
float textSizeValue;
float quitBtnAspect = 1.04 * 0.7; // adjusted aspect ratio
color inkPurple = #2C08FF, inkWhite = #FFFFFF; 
 String marker = "Y";

void setup() {
  // Display Settings
  fullScreen();
  int screenW = displayWidth;
  int screenH = displayHeight;
  int minSide = (screenW < screenH) ? screenW : screenH; // Symmetry Reference
  //
  // Music System Setup
  audioEngine = new Minim(this);
  String musicFolder = "Music/";
  String selectedTrack = "groove";
  String fileType = ".mp3";
  //
  String musicLocation = "../../" + musicFolder;
  String songFile = musicLocation + selectedTrack + fileType; // Relative path
  println(songFile);
  songList[selectedSong] = audioEngine.loadFile(songFile); // Check Library Import if Error
  songMetaData[selectedSong] = songList[selectedSong].getMetaData();
  songList[selectedSong].play();
  //
  // Image Asset Loading
  String dependencyFolder = "musicApp";
  String artFolder = "images";
  String objectImage = "Temple";
  String imageExt = ".jpg";
  albumArt = loadImage(objectImage + imageExt); // File Name Completion
  //
  // Interface Component Placement
  exitBtnX = screenW - minSide*1/20;
  exitBtnY = 0;
  exitBtnW = minSide*1/20;
  exitBtnH = minSide*1/20;
  
  artworkDivX = screenW*1/4;
  artworkDivY = screenH*1/5;
  artworkDivW = screenW*1/2;
  artworkDivH = screenH*1.5/5;
  
  songNameX = screenW*1/4;
  songNameY = screenH*1/20;
  songNameW = screenW*1/2;
  songNameH = screenH*1/10;
  
  //
  int btnCount = 13;
  println("Button Width:", screenW/btnCount);
  int btnWidth = screenW/btnCount;
  int btnStartX = btnWidth;
  int btnY = screenH*3/5;
  
  stopBtnX = btnStartX + btnWidth*0;
  stopBtnY = btnY;
  stopBtnW = btnWidth;
  stopBtnH = btnWidth;
  
  muteBtnX = btnStartX + btnWidth*1;
  muteBtnY = btnY;
  muteBtnW = btnWidth;
  muteBtnH = btnWidth;
  
  prevBtnX = btnStartX + btnWidth*2;
  prevBtnY = btnY;
  prevBtnW = btnWidth;
  prevBtnH = btnWidth;
  
  rewindBtnX = btnStartX + btnWidth*3;
  rewindBtnY = btnY;
  rewindBtnW = btnWidth;
  rewindBtnH = btnWidth;
  
  pauseBtnX = btnStartX + btnWidth*4;
  pauseBtnY = btnY;
  pauseBtnW = btnWidth;
  pauseBtnH = btnWidth;
  
  playBtnX = btnStartX + btnWidth*5;
  playBtnY = btnY;
  playBtnW = btnWidth;
  playBtnH = btnWidth;
  
  loopOnceBtnX = btnStartX + btnWidth*6;
  loopOnceBtnY = btnY;
  loopOnceBtnW = btnWidth;
  loopOnceBtnH = btnWidth;
  
  loopForeverBtnX = btnStartX + btnWidth*7;
  loopForeverBtnY = btnY;
  loopForeverBtnW = btnWidth;
  loopForeverBtnH = btnWidth;
  
  fwdBtnX = btnStartX + btnWidth*8;
  fwdBtnY = btnY;
  fwdBtnW = btnWidth;
  fwdBtnH = btnWidth;
  
  nextBtnX = btnStartX + btnWidth*9;
  nextBtnY = btnY;
  nextBtnW = btnWidth;
  nextBtnH = btnWidth;
  
  shuffleBtnX = btnStartX + btnWidth*10;
  shuffleBtnY = btnY;
  shuffleBtnW = btnWidth;
  shuffleBtnH = btnWidth;
  
  //
  float songControlPaddingY = btnWidth*1/4;
  float controlAreaX = stopBtnX;
  float controlAreaY = stopBtnY + btnWidth + songControlPaddingY;
  float controlAreaW = screenW - btnWidth*2;
  float controlAreaH = screenH - songControlPaddingY - controlAreaY;
  
  songPositionDivX = controlAreaX;
  songPositionDivY = controlAreaY;
  songPositionDivW = controlAreaW*1/5;
  songPositionDivH = controlAreaH*2/5;
  
  timeLeftX = controlAreaX + controlAreaW*3/5;
  timeLeftY = controlAreaY + controlAreaH*3/5;
  timeLeftW = controlAreaW*1/5;
  timeLeftH = controlAreaH*2/5;
  
  songDurationX = controlAreaX + controlAreaW*4/5;
  songDurationY = controlAreaY + controlAreaH*3/5;
  songDurationW = controlAreaW*1/5;
  songDurationH = controlAreaH*2/5;
  
  float timeBarHeight = controlAreaH*1/5;
  
  progressBarX = controlAreaX;
  progressBarY = controlAreaY + controlAreaH*2/5;
  progressBarW = controlAreaW;
  progressBarH = timeBarHeight;
  
  // STOP Button Shape
  stopSymbolX = stopBtnX + stopBtnW*1/4;
  stopSymbolY = stopBtnY + stopBtnH*1/4;
  stopSymbolW = btnWidth*1/2;
  stopSymbolH = btnWidth*1/2;
}      
int attempts = 0;
while ( a < textWidth(playListMetaData[currentSong].title() & attempts < 100 ) {
  fontSize *= 0.99;
  textFont(appFont, fontSize);
  attempts++;
