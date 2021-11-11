final float CIRCLE_DIAMETER = 20;
final float TARGET_SPACING = CIRCLE_DIAMETER * 0.75;
float anchorX, anchorY;

void setup() {
  size(500, 500);
  anchorX = width/2;
  anchorY = height/2;
  strokeWeight(2);
  stroke(255);
  noFill();
}

void draw() {
  background(#000000);
  int mouseToAnch = (int)(dist(mouseX, mouseY, anchorX, anchorY));
  int circCount = round(mouseToAnch/TARGET_SPACING);
  if (circCount==0) {
    circle(anchorX, anchorY, CIRCLE_DIAMETER);
  } else {  
    for (int i=0; i <= circCount; i++) {
      float xDist = mouseX-anchorX;
      float yDist = mouseY-anchorY;
      float avDistX = xDist/circCount;
      float avDistY = yDist/circCount;
      float circX = anchorX + i*avDistX;
      float circY = anchorY + i*avDistY;
      circle(circX, circY, CIRCLE_DIAMETER);
    }
  }
}
