int[] a= {1,2,3};
int[] b= {0,0,6};
boolean compareA(int[] a, int[] b) {
  boolean result=false;
  if (a.length==b.length) {
    int sumA=0;
    int sumB=0;
    for( int i=0; i<a.length; i++) {
      sumA+=a[i];
      sumB+=b[i];
    }
    if (sumA==sumB) result=true;
  }
  return result;
}

int[] c = {1, 2, 3};
float[] d = {1.9, 2.3, 4.6};
boolean compareB(int[] a, float[] b) {
  if (a.length!=b.length) return false;
  for( int i=0; i<a.length; i++) {
      if (a[i]!=(int)b[i]) return false;
  }
  return true;
}

int[] e = {0, 2, 3};
boolean[] f = {true, true, true};
boolean compareC(int[] a, boolean[] b) {
  if (a.length!=b.length) return false;
  for( int i=0; i<a.length; i++) {
      if (a[i]%2==0 && !b[i]) return false;
      else if (a[i]%2!=0 && b[i]) return false;
  }
  return true;
}
void setup() {
println(compareC(e,f));
}
