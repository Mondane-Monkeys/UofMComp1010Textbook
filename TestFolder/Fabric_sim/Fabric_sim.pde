/*****
Author:Josh Chartrand
Simulate beads connected by springs
*****/

//generalConstants
final int timeCoef = 1;
final int gravConst = 2;
final int defaultSpringConst=2;

final int frictionConst = 1;
final int mouseRange=30;

//Grid Constants
int columns=6;
int rows=5;
int nodeCount = columns*rows;
final int defaultEdgeLength=height/nodeCount;


//Arrays to store nodes and edges
int MasterEdgeCount=0;
int[] nodeX = new int[0];
int[] nodeY = new int[0];
int[][] edges = new int[nodeCount][]; //stores origin/destination of edges by [someNodeID0(ID referenced in nodeX&Y)[linkedNode0ID,linkedNode1ID], someNodeID1[linkedNodeID0,linkedNodeID1],...]
int[][] edgeLength = new int[nodeCount][]; //stores edge stable length by [someNodeID0[linkedNode0EdgeLength,linkedNode1EdgeLength]...
int[][] springConst = new int[nodeCount][]; //stores spring coeffiecent by [someNodeID0[linkedNode0Coef, linkedNode1Coef]
int[] speedX = new int[0];
int[] speedY = new int[0];
int[] fixedNodes = new int[] {};//stores Id of fixed points
int[] fixedNodeX = new int[] {};//stores x location. 
int[] fixedNodeY = new int[] {};
int heldNode=-5;

void setup(){
  size(1000,1000);
  //manualInitArrays();
  gridInitArray();
}

void draw(){
  background(200);
  drawNodeEtEdges();
  calcForces();
  applyForces();
  println("frame");
}



//Populates the node and edge arrays
void manualInitArrays(){
  //createNodes
  for (int i=0;i<nodeCount;i++){
    int thisNodeID = i;
    int posX=width/2;
    int posY=i*height/(nodeCount+1);
    int declaredSpeedX=0;
    int declaredSpeedY=0;
    
    //Create Edges
    int[][] edgeDeclare = new int[3][];
    int thisEdgeCount =0;
    int thisLinkRelID=0;
    for (int e=-1;e<2;e+=2){
      if((e+i<nodeCount) && (e+i>=0)){
        int thisLinkID = i+e;
        int thisEdgeLength = defaultEdgeLength;
        int thisSpringConst = defaultSpringConst;
        int[] thisEdge = new int[]{thisLinkID,thisEdgeLength,thisSpringConst}; 
        edgeDeclare[thisLinkRelID] = thisEdge;
        thisEdgeCount++;

        thisLinkRelID++;
      }
    }
    createNode(thisNodeID, posX, posY, declaredSpeedX, declaredSpeedY);
    createBulkEdges(thisNodeID, edgeDeclare, thisEdgeCount);
  }  
  
}


//Populates the node and edge arrays
void gridInitArray(){
  //adjust counts
  nodeCount=columns*rows;
  
  //create nodes 
  for(int i=0;i<nodeCount;i++){
    int nodeID = i;
    int posX = ((i%columns)*width/columns)+((width/columns)/2);//centers grid
    int posY = ((i/columns)*height/rows)+((height/rows)/2);//centers grid
    int declaredSpeedX=0;
    int declaredSpeedY=0;
    createNode(nodeID,posX,posY,declaredSpeedX,declaredSpeedY);
  }
  //create horizontal edges
  for(int i=0;i<nodeCount;i++){
    int thisColumn = i%columns; //number between 0,columns that defines its horizontal position (starting at 0)
    int thisRow=i/columns;// number between 0 and rows that defines its veertical position(starting at 0)
    if(thisColumn==0){
      createFirstSingleEdge(i, i+1, defaultEdgeLength,defaultSpringConst);
    } else if (thisColumn==columns-1){
      createFirstSingleEdge(i, i-1, defaultEdgeLength,defaultSpringConst);
    } else{
      createFirstSingleEdge(i, i-1, defaultEdgeLength,defaultSpringConst);
      createSingleEdge(i, i+1, defaultEdgeLength,defaultSpringConst);
    }
    //create vertical edges
    if(thisRow==0){
      createFixedNodes(i, nodeX[i], nodeY[i]);
      createSingleEdge(i, i+columns, defaultEdgeLength,defaultSpringConst);
    } else if (thisRow==rows-1){
      createSingleEdge(i, i-columns, defaultEdgeLength,defaultSpringConst);
    } else{
      createSingleEdge(i, i-columns, defaultEdgeLength,defaultSpringConst);
      createSingleEdge(i, i+columns, defaultEdgeLength,defaultSpringConst);
    }
  }
}


//create fixed nodes
void createFixedNodes(int thisNodeID, int posX, int posY) {
  fixedNodes = append(fixedNodes, thisNodeID);
  fixedNodeX = append(fixedNodeX, posX);
  fixedNodeY = append(fixedNodeY, posY);
}



void createNode(int thisNodeID, int posX, int posY, int declaredSpeedX, int declaredSpeedY){
  //establish Node
    nodeX = append(nodeX, posX);
    nodeY = append(nodeY, posY);
    speedX = append(speedX, declaredSpeedX);
    speedY = append(speedY, declaredSpeedY);    
}



void createFirstSingleEdge(int thisNodeID, int linkID, int thisEdgeLength, int thisSpringConst){
  //create edge locator array
  int[] thisEdgesIDs = new int[] {linkID};
  
  //create edge length array
  int[] thisEdgeLengthArr = new int[] {thisEdgeLength};
  
  //create springConst array
  int[] thisSpringConstArr = new int[] {thisSpringConst};
  
  //append to master arrays
  MasterEdgeCount++;
  edges[thisNodeID] = thisEdgesIDs;
  edgeLength[thisNodeID] = thisEdgeLengthArr;
  springConst[thisNodeID] = thisSpringConstArr;
}



void createSingleEdge(int thisNodeID, int linkID, int thisEdgeLength, int thisSpringConst){
  //establish Edges
  //create edge locator array
  int[] thisEdgesIDs = edges[thisNodeID];
  thisEdgesIDs=append(thisEdgesIDs, linkID);
  
  //create edge length array
  int[] thisEdgeLengthArr = edgeLength[thisNodeID];
  thisEdgeLengthArr=append(thisEdgeLengthArr, thisEdgeLength);
  
  //create springConst array
  int[] thisSpringConstArr = springConst[thisNodeID];
  thisSpringConstArr =append(thisSpringConstArr, thisSpringConst);
  
  //append to master arrays
  MasterEdgeCount++;
  edges[thisNodeID] = thisEdgesIDs;
  edgeLength[thisNodeID] = thisEdgeLengthArr;
  springConst[thisNodeID] = thisSpringConstArr;  
}


void createBulkEdges(int thisNodeID, int[][] edgeDeclare, int edgeCount){ //edgeDeclare{LinkID, EdgeLength, SpringConst}
  //establish Edge 
    int[] thisNodeEdges = new int[edgeDeclare.length];
    int[] thisNodeEdgeLengths = new int[edgeDeclare.length];  
    int[] thisSpringConst = new int[edgeDeclare.length];
    for(int i=0;i<edgeCount;i++){
      thisNodeEdges[i] = edgeDeclare[i][0];
      thisNodeEdgeLengths[i] = edgeDeclare[i][1];
      thisSpringConst[i] = edgeDeclare[i][2];
    }
    MasterEdgeCount++;
    edges[thisNodeID] = thisNodeEdges;
    edgeLength[thisNodeID] = thisNodeEdgeLengths;
    springConst[thisNodeID] = thisSpringConst;
}

//calculate all forces a given node experiences
//"Force" is equivelant to speed. It has 2 components:1)acceleration(Ie gravity and springs), 2) movement(ie momentum). These two factors dictate distance traveled per tick
void calcForcesTrials(){ //
  for (int i=0;i<nodeCount;i++){
    //gravity&resistance force 
    speedY[i] += gravConst; //accelerate Downwards
    //sping force
    for(int e=0;e<edges[i].length;e++){
      int thisNodeID = i;
      int linkNodeRelativeID=e;
      int linkNodeID = edges[thisNodeID][linkNodeRelativeID];
      int linkX=nodeX[linkNodeID];
      int linkY=nodeY[linkNodeID];
      int thisNodeX=nodeX[thisNodeID];
      int thisNodeY=nodeY[thisNodeID];
      int distanceX=linkX-thisNodeX;
      int distanceY=linkY-thisNodeY;
      int thisSpringConst=springConst[thisNodeID][linkNodeRelativeID];
      
      //Calculate forces
      int forceX = (distanceX-edgeLength[thisNodeID][linkNodeRelativeID])*thisSpringConst*timeCoef;
      int forceY = (distanceY-edgeLength[thisNodeID][linkNodeRelativeID])*thisSpringConst*timeCoef;
      //println("nodeCount: " +i +" linkedNode "+linkNodeID+" force "+forceX);
      
      //Adjust speed
      speedX[thisNodeID] += (forceX*timeCoef)/frictionConst;
      speedY[thisNodeID] += (forceY*timeCoef)/frictionConst;
      //speedX[thisNodeID] = speedX[thisNodeID]/frictionConst;
      //speedY[thisNodeID] = speedY[thisNodeID]/frictionConst;
      
      //break distance
      if(distanceX>200){
        speedX[thisNodeID]=speedX[thisNodeID]/100;
      }
      if(distanceY>200){
        speedY[thisNodeID]=speedY[thisNodeID]/100;
      }
    };
    
    //Friction system
    
  }
}


void calcForces(){ //Legacy
  for (int i=0;i<nodeCount;i++){
    //gravity&resistance force
    if(speedX[i]>0){speedX[i] -=frictionConst;}
    else if (speedX[i]<0){speedX[i] +=frictionConst;}
    if(speedY[i]>0){speedY[i] -=frictionConst;}
    else if (speedY[i]<0){speedY[i] +=frictionConst;}
    speedX[i] -=frictionConst;
    speedY[i] -=frictionConst;    
    speedY[i] += gravConst; //accelerate Downwards
    //sping force
    for(int e=0;e<edges[i].length;e++){
      int thisNodeID = i;
      int linkNodeRelativeID=e;
      int linkNodeID = edges[thisNodeID][linkNodeRelativeID];
      int linkX=nodeX[linkNodeID];
      int linkY=nodeY[linkNodeID];
      int thisNodeX=nodeX[thisNodeID];
      int thisNodeY=nodeY[thisNodeID];
      int distanceX=linkX-thisNodeX;
      int distanceY=linkY-thisNodeY;
      int thisSpringConst=springConst[thisNodeID][linkNodeRelativeID];
      
      //Calculate forces
      int forceX = (distanceX-edgeLength[thisNodeID][linkNodeRelativeID])*thisSpringConst*timeCoef;
      int forceY = (distanceY-edgeLength[thisNodeID][linkNodeRelativeID])*thisSpringConst*timeCoef;
      //println("nodeCount: " +i +" linkedNode "+linkNodeID+" force "+forceX);
      
      //Adjust speed
      speedX[thisNodeID] += forceX*timeCoef/40;
      speedY[thisNodeID] += forceY*timeCoef/40;
    };
  }
}
//Iterate over array of points to calculate next positions
void applyForces(){ //moves all points according to calculated forces
  for (int i=0;i<nodeCount;i++){
    nodeX[i]+=speedX[i];
    nodeY[i]+=speedY[i];
  }
  for(int i=0;i<fixedNodes.length;i++){
    int nodeID = fixedNodes[i];
    nodeX[nodeID] = fixedNodeX[i];
    nodeY[nodeID] = fixedNodeY[i];
  }
  if(heldNode>=0){
    nodeX[heldNode]=mouseX;
    nodeY[heldNode]=mouseY;
  }
}

//Draw the nodes and edges
void drawNodeEtEdges(){
  for(int i =0;i<nodeCount;i++){
    int posX = nodeX[i];
    int posY = nodeY[i];
    //circle(posX,posY,30);
    if(MasterEdgeCount>0){
      for(int e=0;e<edges[i].length;e++){
        int linkNodeID=edges[i][e];
        int linkX=nodeX[linkNodeID];
        int linkY=nodeY[linkNodeID];      
        line(posX,posY,linkX,linkY);  
      }
    }
  }
}
//add interactive cursor
void mousePressed(){
  //check if mouse intersects any nodes
  for(int i=0;i<nodeCount;i++){
    if((nodeY[i]<mouseY+mouseRange)&&(nodeY[i]>mouseY-mouseRange)){
      if((nodeX[i]<mouseX+mouseRange)&&(nodeX[i]>mouseX-mouseRange)){
        heldNode=i;
        return;
      }
    }
  }
}
  //if so, return only the first node ID into heldNode
  
void mouseReleased(){
    if (heldNode>=0){
    speedX[heldNode]=0;
    speedY[heldNode]=0;
  }
  heldNode=-5;
}
  //mouse-collision Check
  //move to mouse if click
//Array integrity check
//add color based on tension
