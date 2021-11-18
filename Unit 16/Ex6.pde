final int DROP_Y_LEN = 10;
final int MAX_ADDITIONAL_DROPS= 10000;
final float ANGLE=PI/3;
float[] drops, x;
void setup() {
  size(500, 500);
  int count = (int)random(MAX_ADDITIONAL_DROPS)+500;
  drops=new float[count];
  x= new float[count];
  for (int i = 0; i < drops.length; i++)
  {
    drops[i] = (int)random(height);
  }
  for (int i = 0; i < x.length; i++)
  {
    x[i] =i%width;
  } 
}

void draw() {
  background(0);
  stroke(255);
  for (int i = 0; i<drops.length; i++)
  {
    float y = drops[i];
    stroke(random(256),0,random(256));
    line(x[i], y, x[i]+DROP_Y_LEN*cos(ANGLE), y+DROP_Y_LEN*sin(ANGLE));
    drops[i]=(drops[i]+(i%3+1)*sin(ANGLE))%height;
    x[i]= (x[i]+(i%3+1)*cos(ANGLE))%width;
  }
}
