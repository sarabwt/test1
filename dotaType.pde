PImage img, bg;

boolean keys[] = new boolean [7];
Player myPlayer1;

boolean mouseButtonRight, mouseButtonLeft = false;
boolean ability1, ability2, ability3 =false;

void setup() {
  size(700, 700);
  img = loadImage("data/z4gt3.png");
  bg= loadImage("data/proga2.png");
  myPlayer1 = new Player (img, 200, 200, 3);
  smooth(2);
  frameRate(60);

}

void draw() {  
  clear();  
  background(bg.get(myPlayer1.getXpos()-width/2, myPlayer1.getYpos()-width/2, width, height));
  myPlayer1.move();
} 

void keyPressed() {
  switch(key) {
  case 'q':
    ability1=true;
    break;
  case 'w':
    ability2=true;
    break;
  case 'e':
    ability1=true;
    break;
  }
}

void keyReleased() {
  switch(key) {
  case 'q':
    ability1=false;
    break;
  case 'w':
    ability2=false;
    break;
  case 'e':
    ability1=false;
    break;
  }
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

  float getMousex=300;
  float getMousey=300;

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
    mouse();
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

  void move() {
    rotatePlayer();
    playerx = playerx + cos(angle)*moveSpeed;
    playery = playery + sin(angle)*moveSpeed;
  }


  void rotatePlayer() {
    keyCheck();
    imageMode(CENTER);
    translate(playerx, playery);
    rotate(angle);
    translate(-playerx, -playery); 
    image(img, playerx, playery);
    resetMatrix();
  }
  
  int getXpos(){
  return (int)playerx;
  }
  
  int getYpos(){
  return (int)playery;
  }
}
