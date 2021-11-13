/* 
I have no idea how this is ever supposed to work
Please help
*/


float step = 50;
float t1 = 0.5;

float pt0X = 0;
float pt0Y = 0;
float pt1X = 25;
float pt1Y = 25;
float pt2X = 50;
float pt2Y = 0;


void setup() {
  size(500, 500);
}

void draw() {
  background(0);
  ////updateMouse();
  //circle(pt0X, pt0Y, 5);
  //circle(pt1X, pt1Y, 5);
  //circle(pt2X, pt2Y, 5);
  for (int i=1; i < 100; i+=10) {
    println(i/10.0);
    fill(25*i);
    t1 = i/10.0;
    updateCoef();
  }
}

void updateMouse() {
  pt0X = mouseX;
  pt0Y = mouseY;
}

void updateCoef() {
  float a0X = pt0X;
  float a0Y = pt0Y;
  float a2X = ((pt1X-pt0X)/(t1*(t1-1))) - ((pt2X-pt0X)/(t1-1));
  float a2Y = ((pt1Y-pt0Y)-((pt2Y-pt0Y)*t1))/ t1*(t1-1);
  float a1X = pt2X - pt0X - a2X;
  float a1Y = pt2Y - pt0Y - a2Y;
  //println(a2X*t1*t1);
  //println(a2Y +", " +a1Y+", " +a0Y);
  float outputX = a2X*t1*t1 + a1X*t1 + a0X;
  float outputY = a2Y*t1*t1 + a1Y*t1 + a0Y;
  circle(outputX, outputY, 10);
  
  float numerX = (pt1X-pt0X)-(pt2X-pt0X)*t1;
  float numerY = (pt1Y-pt0Y)-(pt2Y-pt0Y)*t1;
  float term0X = pt0X;
  float term0Y = pt0Y;
  float term2X = t1*numerX/(t1-1);
  float term2Y = t1*numerY/(t1-1);
  float term1X = pt2X*t1 - pt0X*t1 - numerX/(t1-1);
  float term1Y = pt2Y*t1 - pt0Y*t1 - numerY/(t1-1);
  fill(#ff0000);
  float pontX = term0X + term1X + term2X;
  float pontY = term0Y + term1Y + term2Y;
  println(numerX/(t1-1));
  println(pontX+", "+pontY);
  circle(pontX, pontY, 5);
}
