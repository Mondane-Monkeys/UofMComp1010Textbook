int diam = 10;
int marginX = 90;
int marginY = 17;
int textOffsetX = 5;
int textOffsetY = 5;

void setup() {
   size(500, 500);
   noLoop();
}

void draw() {
  for(int i=0; i < 20; i++){
   drawPoint();  
  }
}

void drawPoint(){
  fill(255);
   int pointX = (int)random(width-marginX);
   int pointY = (int)random(marginY,height);
   circle(pointX,pointY,diam);
   fill(0);
   int textX = pointX+textOffsetX;
   int textY = pointY-textOffsetY;
   String pos = "(" + pointX + ", " + pointY + ", " + diam + ")"; 
   text(pos, textX, textY);
}
