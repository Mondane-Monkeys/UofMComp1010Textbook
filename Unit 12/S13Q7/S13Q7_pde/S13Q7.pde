String message = "Happy Birthday!";
int radius = 80;
float mainAngle = 0;

void setup() {
   size(500, 500);
   
}

void draw() {
  background(255);
   drawText();
   updateAngle();
}

void drawText(){
  fill(0);
   for(int i=0; i < message.length(); i++){
      float angle = i*2*PI/message.length();
      angle += mainAngle;
      float posX = cos(angle)*radius + mouseX;
      float posY = sin(angle)*radius + mouseY;
      text(message.charAt(i), posX, posY);
   }
}


void updateAngle(){
   if(mousePressed){
      mainAngle-=0.02;
   } else {
     mainAngle+=0.02;
   }
   
}
