int diam = 20;

void setup() {
   size(500, 500);
   
}

void draw() {
   background(0);
   fill(255);
   float pointX = mouseX;
   float pointY = mouseY;
   boolean onScreen = pointX>0&&pointX<width&&pointY>0&&pointY<width;
   while(pointX>0&&pointX<width&&pointY>0&&pointY<width){
     pointX += random(diam);
     pointY -= random(diam);
      circle(pointX,pointY,diam);
      onScreen = pointX>0&&pointX<width&&pointY>0&&pointY<width;
   }
}
