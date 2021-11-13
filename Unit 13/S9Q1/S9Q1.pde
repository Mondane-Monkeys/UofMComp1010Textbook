float colCount = 10;
float rowCount = 10;
float maxDist = dist(0,0,500,500);
int minSize = 25;
int maxSize = 50;
int minCol = 0;
int maxCol = 255;
int colOffset = 25;
int rowOffset = 25;

void setup() {
   size(500, 500);
   
}

void draw() {
  background(0);
   drawGrid();
}

void drawGrid(){
   for(int i=0; i < colCount; i++){
      for(int j=0; j < rowCount; j++){
        float posX = i/colCount*width + colOffset;
        float posY = j/rowCount*height + rowOffset;
        float distance = dist(posX,posY,mouseX,mouseY);
        float distPercent = distance/maxDist;
        float size = minSize + distPercent*(maxSize-minSize);
        float col = minCol + distPercent*(maxCol-minCol);
        fill(#CC0055, 255);
        circle(posX,posY,size);
        fill(#0000ff,col); //opacity is used to control color gradient
        circle(posX,posY,size);
      }
   }
}
