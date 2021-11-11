/*
  The goal is to modify this code to move the second hand in a smooth manner. 
  You must use millis() which returns the # of milliseconds since the program began
*/


int clockRadius = 100;
int tickSize = 1;
int largeTickSize = 3;
int lastSec = 0;
int milliOffset = 0;

void setup() {
  size(500, 500);
  stroke(255);
}

void draw() {
  background(0);
  float angle;
  float x;
  float y;

  // draw tick marks
  for (int i = 0; i < 60; i++) {
    angle = i/60.0 * 2 * PI; // angle to dot
    // center these on canvas
    x = cos(angle)*clockRadius + width/2;
    y = sin(angle)*clockRadius + height/2;
    if (i%5 == 0) {
      ellipse(x, y, largeTickSize, largeTickSize);
    } else {
      ellipse(x, y, tickSize, tickSize);
    }
  }
  //check if seconds have changed
  if(lastSec!=second()){
    milliOffset = millis(); //store offset between millis() == 0 and true millisecond == 0
  }
  lastSec = second(); // update lastSec
  // calculate and draw the second hand
  stroke(255);
  angle = second()/60.0*PI*2 - PI/2; //PI/2 to set 0 to vertical
  angle+=(millis()-milliOffset)%1000/60000.0*PI*2; //change millis() into a looping 1000 interval
  x = cos(angle)*clockRadius + width/2;
  y = sin(angle)*clockRadius + height/2;
  line(width/2, height/2, x, y);

  //calculate and draw the minute hand
  stroke(#ff0000);
  angle = minute()/60.0*PI*2 - PI/2;
  x = cos(angle)*clockRadius + width/2;
  y = sin(angle)*clockRadius + height/2;
  line(width/2, height/2, x, y);
  
  //calculate and draw the hour hand
  angle = hour()/24.0*PI*2 - PI/2;
  x = cos(angle)*clockRadius + width/2;
  y = sin(angle)*clockRadius + height/2;
  stroke(#0000ff);
  line(width/2, height/2, x, y);
}
