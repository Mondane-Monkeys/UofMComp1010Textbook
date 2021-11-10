void setup() {
  size(500, 500);
}

void draw() {
  background(0);
  stroke(255);
  for(int i=0; i <= width; i+=50){
     line(mouseX,mouseY,i,0);
     line(mouseX,mouseY,i,height);
  }
}
