import g4p_controls.*;
GButton btnIter; //Embedded iteration button
GButton btn2D; //2d distance button
GButton btnGetChild; //get child button
GButton btnClear;
GView view; //nested window to see changes
PGraphics pg;

//variables needed for the dist2d
int n = 0;
float max_distance;


// variables needed for the map
PShape usa;
color[] colors = { #FF0000, #FFA500, #ffff00, #008000, #0000ff, #4b0082, #ee82ee};
String[] States={"MI", "OH", "IN", "PA", "KY", "WV", "NY"};
IntList idx;
int k;
int col;

public void setup() {
  size(830, 420);
  makeControls();
  usa = loadShape("usa-wikipedia.svg");
  idx = new IntList(0, 1, 2, 3, 4, 5, 6);
}

//this function is for control buttons and placing inner screen
public void makeControls() {
  G4P.setGlobalColorScheme(GCScheme.CYAN_SCHEME);
  btnIter = new GButton(this, 720, 30, 100, 40, "Iteration");//Embedded iteration button loc
  btn2D = new GButton(this, 720, 80, 100, 40, "2D-Distance"); //2d distance button loc
  btnGetChild = new GButton(this, 720, 130, 100, 40, "Get Child"); //get child button loc
  btnClear = new GButton(this, 720, 180, 100, 40, "Clear"); 
  // Create the GView control to position and display the graphic
  view = new GView(this, 20, 20, 660, 380, JAVA2D); // view window loc
  //// Now get the PGraphic so we can update it
  pg = view.getGraphics();
  updateGraphic(n);
}

//main
public void updateGraphic(int n) {
  //n = (n < 0) ? 0 : n % 30;
  col=0;
  pg.beginDraw();
  pg.background(0);
  pg.noStroke();
  pg.fill(255);
  //pg.ellipseMode(CENTER);
  int gridSize = 40;
  //default center is window middle
  int centerX=pg.width/2;
  int centerY=pg.height/2;
  
  switch(n) {
    
  case 1:

    for (int x = gridSize; x <= pg.width - gridSize; x += gridSize) {
      for (int y = gridSize; y <= pg.height - gridSize; y += gridSize) {
        if (mousePressed) { //center is changed to the click location
          centerX=mouseX;
          centerY=mouseY;
        }
        pg.rect(x, y, 3, 3);
        pg.stroke(255, 100);
        pg.line(x, y, centerX, centerY);
      }
    }
    break;
    
  case 2:
   
    max_distance = dist(0, 0, pg.width, pg.height);
    for (int i = 0; i <= pg.width; i += 20) {
      for (int j = 0; j <= pg.height; j += 20) {
        float size = dist(mouseX, mouseY, i, j);
        if (mousePressed && (mouseButton == LEFT)) {
          size = size/max_distance * 36;
          pg.ellipse(i, j, 20-size, 20-size);
        } else {
          size = size/max_distance * 66;
          pg.ellipse(i, j, size, size);
        }
      }
    }
    break;
  case 3:
     idx.shuffle(); //shuffle the colors to get colors rotate through the rainbow colors
    // Draw the full map
    pg.shape(usa, -600, -180);
    for (int i=0; i< 7; i++) {
      PShape state=usa.getChild(States[i]);
      state.disableStyle();
      k=idx.get(i);
      pg.fill(colors[k]);
      pg.noStroke();
      pg.shape(state, -600, -180);
    }
    delay(1000);
  }
  pg.endDraw();
}




public void draw() {
  background(230, 250, 240);
  updateGraphic(n);
}

//button control 
public void handleButtonEvents(GButton button, GEvent event) {

  if (button == btnIter && event == GEvent.CLICKED) {
    n=1;
  }
  if (button == btn2D && event == GEvent.CLICKED) {
    n=2;
  }

  if (button == btnGetChild && event == GEvent.CLICKED) {
    n=3;
  }
  if (button == btnClear && event == GEvent.CLICKED) {
    n=0;
  }
}
