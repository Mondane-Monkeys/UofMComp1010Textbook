final int POINTS = 8;
final int[] x = new int[POINTS];
final int[] y = new int[POINTS];

int maxX=0, minX=500/*width*/, maxY=0, minY=500/*height*/;
void setup() {
  size(500, 500); 
}
void newPoints()
{
  maxX=0; minX=500/*width*/; maxY=0; minY=500/*height*/;
  for (int i = 0; i < POINTS; i++)
  {
    x[i] = (int)random(width);
    y[i] = (int)random(height);
    maxX= max(maxX, x[i]);
    minX= min(minX, x[i]);
    maxY= max(maxY, y[i]);
    minY= min(minY, y[i]);
  }
}

void drawLines()
{
  for (int i = 0; i < POINTS; i++)
  {
    line(mouseX, mouseY, x[i], y[i]);
  }
}

void draw()
{
  background(0);
  stroke(255);
  if (mousePressed) newPoints();
  drawLines();
  noFill();
  rect(minX, minY, maxX-minX, maxY-minY);
}
