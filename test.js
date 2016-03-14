PImage player;
Player myPlayer1;
boolean mouseButtonRight, mouseButtonLeft = false;

PImage bmw;



void setup() {
  size(800,800);
 
  
  myPlayer1 =new Player(bmw,100,100,3);
}

void draw() {
   background(255);
  myPlayer1.move();
  myPlayer1.display();
  myPlayer1.mouseMove();
}

void playerImage() {
  bmw=loadImage("data/z4gt3");
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
  float mousePX=xpos;
  float mousePY=ypos;
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
      n=asin((k2)/h);
      //xpos+=cos(n)*1;
       println(k1+" "+k2+" "+xpos+" "+ypos+" "+mousePX+" "+mousePY+" "+mouseX+" "+mouseY+" "+n);
      //ypos+=sin(n)*1;
    }
  }

  void display() {   
    pushMatrix();
    translate(xpos, ypos);
    rectMode(CENTER);
    rotate(degrees(n));
    fill(0);
    rect(xpos,ypos,10,30);   
    popMatrix();
  }
}
