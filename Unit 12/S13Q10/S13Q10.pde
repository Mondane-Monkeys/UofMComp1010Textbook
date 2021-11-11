final int NUM_BALLS = 6;
final float BALL_SPACING = PI/6;
final float BALL_DIAMETER = 16;
final float BALL_ORBIT_RADIUS = 32;
final float ORBIT_SPEED = PI/60.0;
final float ROGUE_BALL_SPEEDUP = 1.7;

float trailingBallAngle = 0;
float rogueBallAngle = NUM_BALLS*BALL_SPACING; 

final int MIN_COLOUR = 150;
final int MAX_COLOUR = 255;
final int TRAIL_MIN_COLOUR = MIN_COLOUR;
final int TRAIL_RANGE = (MAX_COLOUR-MIN_COLOUR)/NUM_BALLS;


final int BG_COLOUR = 192;
final float RED_VALUE = 0;
final float GREEN_VALUE = 150;
final float BLUE_VALUE = 200;

float rogBallColour = MAX_COLOUR;
float trailingBallColour = TRAIL_MIN_COLOUR;


void setup() {
  size(500, 500);
}

void draw() {
  background(BG_COLOUR);
  incAngles(); 
  updateColor();
  collisionCheck(); 
  drawRogue(); 
  drawTrail();
}



void incAngles() {
  rogueBallAngle += ORBIT_SPEED*ROGUE_BALL_SPEEDUP;
  rogueBallAngle= rogueBallAngle%(2*PI);
  trailingBallAngle += ORBIT_SPEED;
  trailingBallAngle = trailingBallAngle%(2*PI);
}

void updateColor() {
  float rogCatchupSpeed  = ORBIT_SPEED*ROGUE_BALL_SPEEDUP - ORBIT_SPEED; 
  float distNotTrail = 2*PI - (NUM_BALLS*BALL_SPACING); 
  float framesBetweenColllisions = distNotTrail/rogCatchupSpeed; 
  float rogColourChangePerFrame = (MAX_COLOUR-MIN_COLOUR)/framesBetweenColllisions; 
  float trailColourChangePerFrame = (TRAIL_RANGE)/framesBetweenColllisions;
  rogBallColour-=rogColourChangePerFrame;
  trailingBallColour+=trailColourChangePerFrame;
}



void collisionCheck() {
  boolean rogLowerCheck = rogueBallAngle > trailingBallAngle-BALL_SPACING;
  boolean rogUpperCheck = rogueBallAngle < trailingBallAngle;
  if (rogLowerCheck&&rogUpperCheck) {
    float trailLength = NUM_BALLS*BALL_SPACING;
    rogueBallAngle+=trailLength;
    trailingBallAngle-=BALL_SPACING;
    rogBallColour = MAX_COLOUR;
    trailingBallColour = TRAIL_MIN_COLOUR;
  }
}


void drawRogue() {
  fill(rogBallColour, GREEN_VALUE, BLUE_VALUE);
  float thisCircX = mouseX + BALL_ORBIT_RADIUS*cos(rogueBallAngle);
  float thisCircY = mouseY + BALL_ORBIT_RADIUS*sin(rogueBallAngle);  
  circle(thisCircX, thisCircY, BALL_DIAMETER);
}


void drawTrail() {
  for (int i=0; i < NUM_BALLS; i++) {
    float dynamicColVal = trailingBallColour + i*TRAIL_RANGE;
    fill(dynamicColVal, GREEN_VALUE, BLUE_VALUE); 
    float thisCircAng = trailingBallAngle+i*BALL_SPACING;
    float thisCircX = mouseX + BALL_ORBIT_RADIUS*cos(thisCircAng);
    float thisCircY = mouseY + BALL_ORBIT_RADIUS*sin(thisCircAng);
    circle(thisCircX, thisCircY, BALL_DIAMETER);
  }
}
