int xPos=100;
int yPos=100;
int r=0;
void setup(){
  size(900,900); 
  
}

void draw(){
  background(240, 230, 240);
  noStroke();
  fill(20, 20, 160);
  //triangle(xPos, yPos, xPos+200, yPos, xPos+100, yPos+150);
  //triangle(xPos, yPos+100, xPos+200, yPos+100, xPos+100, yPos-60);
  pushMatrix();
  translate(xPos+100, yPos+50);
  rotate(radians(r));
  triangle(-100, -50, 100, -50, 0, 100);
  triangle(-100, 50, 100, 50, 0, -110);
  r+=1;
  popMatrix(); 
  
  if (mousePressed){
    fill(30, random(150), 200);
   if (mouseX!=xPos+100){
     xPos+=4*(mouseX-xPos-100)/abs(mouseX-xPos-100);}
   if (mouseY!=yPos+60){  
     yPos+=4*(mouseY-yPos-60)/abs(mouseY-yPos-60);}
  }
  }
     
