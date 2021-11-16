final float MAX_SPEED = 5;
final int STARS = 10000;
float[] starX = new float[STARS];
float[] starY = new float[STARS];
float[] starSpeedX = new float[STARS];
float[] starSpeedY = new float[STARS];
float angle;
float speed;

void setup()
{
  size(500, 500);
  for (int i = 0; i < STARS; i++)
  {
    starX[i] = width/2;
    starY[i] = height/2;
    angle= random(TWO_PI);
    speed= random(MAX_SPEED);
    starSpeedX[i]= speed*cos(angle);
    starSpeedY[i]= speed*sin(angle);
  }
}

void draw() {
  background(0);
  stroke(255);
  for(int i=0; i<STARS; i++) {
    point(starX[i], starY[i]);
    starX[i]+=starSpeedX[i];
    starY[i]+=starSpeedY[i];
  }
}
