final float PERSPECTIVE=0.002;
final int DIA= 1;

void setup() {
  size(500, 500);
}

void draw() {
  background(255);
  drawDotGrid(-40, 40, 5, DIA);
}

void drawProjectedCircle(float x, float y, float z, float diam) {
  if (z==0) return;
  float px= x/(PERSPECTIVE*z)+250;
  float py= y/(PERSPECTIVE*z)+250;
  circle(px, py, diam);
}

void drawDotGrid(int minValue, int maxValue, int spacing, float diam) {
  int val=mouseX;
  for (int x=minValue; x<=maxValue; x+=spacing)
    for (int y=minValue; y<=maxValue; y+=spacing)
      for (int z=minValue; z<=val; z+=spacing) {
        drawProjectedCircle(x,y,z,diam);
      }
}
