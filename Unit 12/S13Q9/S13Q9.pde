int diam = 20;
int radius = 50;
int ballCount = 15;
float mainAngle = 0;
float ballAngleDelta = 0.2;

void setup() {
   size(500, 500);
   
}

void draw() {
  background(0);
  noStroke();
  fill(255);
  float ballX = mouseX+radius*cos(mainAngle);
  float ballY = mouseY+radius*sin(mainAngle);
  circle(ballX,ballY,diam);
  for(int i=0; i < ballCount; i++){
      float invPercenti = 1 - 1.0*i/ballCount;
      fill(255*invPercenti);
      ballX = mouseX+radius*cos(mainAngle-ballAngleDelta*i);
      ballY = mouseY+radius*sin(mainAngle-ballAngleDelta*i);
      circle(ballX,ballY,diam*invPercenti);
   }
   mainAngle+=0.02;
}
