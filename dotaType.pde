PImage img;

boolean keys[] = new boolean [7];
Player myPlayer1;

  boolean mouseButtonRight, mouseButtonLeft = false;

void setup() {
  size(700, 700);
  img = loadImage("data/z4gt3.png");
  myPlayer1 = new Player (img,200,200,3);
  smooth(2);
  frameRate(60);
  background(0);
}

void draw() {  
  clear();  
  myPlayer1.mouse();
  myPlayer1.keyCheck();
  myPlayer1.rotatePlayer();
  myPlayer1.move();
} 

void mousePressed() {
  if (mouseButton==RIGHT) {
    mouseButtonRight=true;
  }
  if (mouseButton==LEFT) {
    mouseButtonLeft=true;
  }
}

void mouseReleased() {
  if (mouseButton==RIGHT) {
    mouseButtonRight=false;
  }
  if (mouseButton==LEFT) {
    mouseButtonLeft=false;
  }
}

class Player {
  PImage player;
  float playerx;
  float playery;
  float moveSpeed;

  int rotateSpeed=3;
  float angle=0;
  float rad= 0.0174532925;

  float getMousex=playerx;
  float getMousey=playery;

  float xcount;
  float ycount;
  float correct;




  Player(PImage skin, float x, float y, float move) {
    playerx=x;
    playery=y;
    player=skin;
    moveSpeed=move;
  }


  void keyCheck() {
    xcount=playerx-getMousex;
    ycount=playery-getMousey;

    angle=atan(ycount/xcount);

    if (getMousex<=playerx) {
      angle=(90*rad+angle)+90*rad;
    }
  }

  void mouse() {
    if (mouseButtonRight==true) {
      getMousex=mouseX;
      getMousey=mouseY;
    }
  }

  void move(){
  playerx = playerx + cos(angle)*moveSpeed;
  playery = playery + sin(angle)*moveSpeed;
}


  void rotatePlayer() {
    imageMode(CENTER);
    translate(playerx, playery);
    rotate(angle);
    translate(-playerx, -playery); 
    image(img, playerx, playery);
    resetMatrix();
  }
}
