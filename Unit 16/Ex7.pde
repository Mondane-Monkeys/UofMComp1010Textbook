final int MAX_NUMBER=49;
final int NUM_DATA_ITEM=10000;
int[] theData= new int[NUM_DATA_ITEM];
int[] frequency= new int[MAX_NUMBER];
int maxVal=0;
void generateData() {
  for (int i=0; i<NUM_DATA_ITEM; i++) theData[i]=(int) random(MAX_NUMBER)+1; //so that there is no 0
}

void findFrequency() {
  for (int i=0; i<NUM_DATA_ITEM; i++) frequency[theData[i]-1]+=1;
}

/*
when you get use to this, you can combine and make some changes to "suit your taste" 
 the following code is my favorite way to set up by make make some changes with the upper code
 this is one of the basic method of counting how many times an element in an array is repeat
 
 final int MAX_NUMBER=49;
 final int NUM_DATA_ITEM=500;
 int[] theData= new int[NUM_DATA_ITEM];
 int[] frequency= new int[MAX_NUMBER+1]; //so that I can store the number directly without the off by one error
 
 void generateData() {
 for(int i=0; i<NUM_DATA_ITEM; i++) {
 theData[i]=(int) random(MAX_NUMBER)+1;
 frequency[theData[i]]+=1;
 }
 }
 
 */
void setup() {
  size(500, 500);
  generateData();
  findFrequency();
}

void draw() {
  plotHistogram();
}

void plotHistogram() {
  for (int i=0; i<MAX_NUMBER; i++) maxVal=max(frequency[i], maxVal);
  float chartWidth= (float) width/MAX_NUMBER;
  for (int i=0; i<MAX_NUMBER; i++) {
    float chartHeight= height*(float)frequency[i]/maxVal;
    float x= i*chartWidth;
    float y= height-chartHeight;
    rect(x, y, chartWidth, chartHeight);
  }
}
