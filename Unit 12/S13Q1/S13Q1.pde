void setup() {
  size(100, 100);
  noLoop();
}

void draw() {
  a();
  //b();
  //c();
  //d();
  //e();
}


void a() {
  for (int i=1; i <= 20; i++) {
    println(i);
  }
}

void b() {
  for (int i=25; i <= 30; i++) {
    println(i);
  }
}

void c() {
  for (int i=10; i >= 0; i--) {
    println(i);
  }
}

void d() {
  for (int i=2; i <= 100; i+=2) {
    println(i);
  }
}

void e() {
  for (int i=-50; i <= 50; i++) {
    println(i);
  }
}
