final int STAR_COUNT=10000;
final int MAX_Z= 500;
final int MAX_SPEED=10;
final float PERSPECTIVE=0.002;
float[] starX= new float[STAR_COUNT];
float[] starY= new float[STAR_COUNT];
float[] starZ= new float[STAR_COUNT];

float newValA, newValB;

void generateStar(int i) {
  starX[i]=random(-width/2, width/2);
  starY[i]=random(-height/2, height/2);
  starZ[i]=random(MAX_Z);
}

void setup() {
  size(500, 500);
  for(int i=0; i<STAR_COUNT; i++) {
    generateStar(i);
  }
}

void drawProjectedPixel(float x, float y, float z) {
  if (z==0) return;
  float px= x/(PERSPECTIVE*z)+250;
  float py= y/(PERSPECTIVE*z)+250;
  stroke(255*(1-(z/MAX_Z)));
  point(px, py);
}

void draw() { 
  background(0);
  int speed= (int) (-MAX_SPEED+((1-(float)mouseX/width)*2*MAX_SPEED));
  for(int i=0; i<STAR_COUNT; i++) {
    drawProjectedPixel(starX[i], starY[i], starZ[i]);
    starZ[i]+=speed;
    if (starZ[i]>MAX_Z || starZ[i]<0 ) generateStar(i);
    //the following is the rotating code
    /*rotate(0.01, starX[i], starY[i]);
    starX[i]=newValA;
    starY[i]=newValB;*/
  }
}

void rotate(float theta, float a, float b) {
  float ra= a*cos(theta) + b*sin(theta);
  float rb= -a*sin(theta) + b*cos(theta);
  newValA= ra;
  newValB= rb;
}
