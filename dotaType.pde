PImage player;
Player myPlayer1;
boolean mouseButtonRight, mouseButtonLeft = false;


void settings() {
}

void setup() {
  background(255);
  myPlayer1 (
}

void draw() {
  myPlayer1.move();
  myPlayer1.display();
}

void playerImage() {
}

void mousePressed() {
  if (mouseButton==RIGHT) {
    mouseButtonRight=true;
  }
  if (mouseButton==LEFT) {
    mouseButtonLeft=true;
  }
}

class Player {
  float xpos;
  float ypos;
  PImage player;

  float n;
  float mousePX=0;
  float mousePY=0;
  float moveSpeed;


  Player(PImage skin, float x, float y, float move) {
    xpos=x;
    ypos=y;
    player=skin;
    moveSpeed=move;
  }

  void mouseMove() {
    if (mouseButtonRight==true) {
      mousePX=mouseX;
      mousePY=mouseY;
      mouseButtonRight=false;
    }
  }

  void move() {
    float k1=mousePX-xpos;
    float k2=mousePY-ypos;
    float h=(float) (Math.sqrt(k1*k1+k2*k2));
    if (xpos!=mousePX && ypos != mousePY) {
      n=asin((mousePY-ypos)/h);
      xpos=cos(n)*moveSpeed;
      ypos=sin(n)*moveSpeed;
    }
  }

  void display() {   
    pushMatrix();
    translate(width/2, height/2);
    rotate(radians(n));
    fill(0);
    rect(xpos,ypos,10,10);   
    popMatrix();
  }
}