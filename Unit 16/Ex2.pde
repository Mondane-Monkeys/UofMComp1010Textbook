float[] x= new float[500];
float[] y= new float[500];

void setup() {
  size(500,500);
  for(int i=0; i<500; i++) {
    x[i]=random(width);
    y[i]=random(height);
  }
}

void draw() {
  background(255);
  float preX=x[0];
  float preY=y[0];
  //moving point to the right
  for(int i=0; i<500; i++) {
    point(x[i],y[i]);
    x[i]-=0.1;
  }
  
  //drawing line between each point
  for(int i=0; i<500; i++) {
    line(preX, preY, x[i], y[i]);
    preX=x[i];
    preY=y[i];
  }
}
