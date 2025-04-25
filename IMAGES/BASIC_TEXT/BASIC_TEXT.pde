// Text: Static
//
String title = "Alleyway Monastries";
//
//Display
//fullScreen();
size(700, 500);
int appWidth = width; //displayWidth
int appHeight = height; //displayHeight
int shorterSide = ( appWidth >= appHeight ) ? appHeight : appWidth ; //Landscape, Portrait, & Square
//
/*Fonts from OS
 println("Start of Console");
 String[] fontList = PFont.list(); //To list all fonts available on system
 printArray(fontList); //For listing all possible fonts to choose, then createFont
 */
float fontSize = shorterSide; //changed int to float for strongly formatted language
PFont titleFont = createFont("Cambria-Bold", fontSize); // <-- updated font
//Tools / Create Font / Find Font / Do Not Press "OK", known bug
//
//Population
float titleX, titleY, titleWidth, titleHeight;
titleX = appWidth * 1 / 4;
titleY = appHeight * 1 / 4;
titleWidth = appWidth * 1 / 2;
titleHeight = appHeight * 1 / 10;
//
//DIVs
rect(titleX, titleY, titleWidth, titleHeight);
//
//Font Size Algorithm
float cambriaAspectRatio = 1.04;
fontSize = titleHeight * cambriaAspectRatio;
textFont(titleFont, fontSize);
println(textWidth(title), titleWidth);
while (textWidth(title) > titleWidth) {
  fontSize = fontSize * 0.99;
  textFont(titleFont, fontSize);
  println("Step:", textWidth(title), titleWidth);
}
//
//Ink Color
color redInk = #2C08FF;
fill(redInk);
textAlign(CENTER, CENTER);
textFont(titleFont, fontSize);
//
//Drawing Text
text(title, titleX, titleY, titleWidth, titleHeight);
color whiteInk = #FFFFFF;
fill(whiteInk);
