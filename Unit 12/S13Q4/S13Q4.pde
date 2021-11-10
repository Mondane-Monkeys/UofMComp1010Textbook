int radius = 100;
int edgeCount = 9;


void setup() {
  size(500, 500);
}

void draw() {
  background(0);
  stroke(255);
  //a();
  b();
}


void a() {
  float lastNodeX = width/2 + cos(0)*radius;
  float lastNodeY = height/2 + sin(0)*radius;
  for (int i=1; i <= edgeCount; i++) {
    float angle = i*2*PI/edgeCount;
    float thisNodeX = width/2 + cos(angle)*radius;
    float thisNodeY = height/2 + sin(angle)*radius;
    line(thisNodeX, thisNodeY, lastNodeX, lastNodeY);
    lastNodeX = thisNodeX;
    lastNodeY = thisNodeY;
  }
}

void b() {
  int edgeCount = mouseX/20;
  float lastNodeX = width/2 + cos(0)*radius;
  float lastNodeY = height/2 + sin(0)*radius;
  for (int i=1; i <= edgeCount; i++) {
    float angle = i*2*PI/edgeCount;
    float thisNodeX = width/2 + cos(angle)*radius;
    float thisNodeY = height/2 + sin(angle)*radius;
    line(thisNodeX, thisNodeY, lastNodeX, lastNodeY);
    lastNodeX = thisNodeX;
    lastNodeY = thisNodeY;
  }
}
