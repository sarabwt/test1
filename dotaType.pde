PImage imgPlayer, imgBackground;

Player Player;

boolean mouseButtonRight, mouseButtonLeft = false;
boolean ability1, ability2, ability3 =false;

void setup() {
  size(700, 700);
  imgPlayer = loadImage("data/z4gt3.png");
  imgBackground = loadImage("data/proga2.png");
  Player = new Player (200, 200, 2);
  smooth(2);
  frameRate(60);
}

void draw() {  
  clear();  
  background(imgBackground.get(Player.getXpos()-width/2, Player.getYpos()-width/2, width, height));
  Player.move();
} 

void keyPressed() {
  switch(key) {
  case 'q':
    ability1=!ability1;
    break;
  case 'w':
    ability2=!ability2;
    break;
  case 'e':
    ability3=!ability3;
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
  float playerx=200;
  float playery=200;
  float moveSpeed;

  float angle=0;
  float rad= 0.0174532925;

  float getMousex=300;
  float getMousey=300;

  float xcount;
  float ycount;

  Player(float x, float y, float move) {
    playerx=x;
    playery=y;
    moveSpeed=move;
  }


  void keyCheck() {
    mouse();
    xcount=width/2-getMousex;
    ycount=height/2-getMousey;

    angle=atan(ycount/xcount);

    if (getMousex<=width/2) {
      angle=(90*rad+angle)+90*rad;
    }
  }

  void mouse() {
    if (mouseButtonRight==true) {
      if(mouseX>width/2){
      getMousex=getMousex+mouseX-width/2;
      }
      if(mouseX<width/2){
      getMousex=getMousex+mouseX-width/2;
      }
      if(mouseY>height/2){
      getMousey=getMousey+mouseY-height/2;
      }
      if(mouseY<height/2){
      getMousey=getMousey+mouseY-height/2;
      }
      println(getMousex+" "+getMousey+" "+(mouseX-width/2)+" "+(mouseY-height/2));
      mouseButtonRight=false;
    }
  }

  void move() {
    moveSpeed=2;
    rotatePlayer();

    if (abs(playerx-getMousex)<moveSpeed+0.1 && abs(playery-getMousey)<moveSpeed+0.1) {
      moveSpeed=0;
    }
    //if(playerx != getMousex && playery != getMousey){
    //playerx = playerx + cos(angle)*moveSpeed;
    //playery = playery + sin(angle)*moveSpeed;
    //}
    playerx=getMousex;
    playery=getMousey;
  }

  void rotatePlayer() {
    pushMatrix();
    keyCheck();
    imageMode(CENTER);
    translate(width/2, height/2);
    rotate(angle);
    image(imgPlayer, 0, 0);
    translate(-width/2, -height/2);  
    popMatrix();
  }

  int getXpos() {
    return (int)playerx;
  }

  int getYpos() {
    return (int)playery;
  }
}
