PImage img, bg, ab;
Player myPlayer1;

boolean mouseButtonRight, mouseButtonLeft = false;
boolean ability1, ability2, ability3 =false;

void setup() {
  size(700, 700);
  img = loadImage("player.png");
  ab = loadImage("ab.png");
  //bg= loadImage("map.png");
  myPlayer1 = new Player (200, 200, 2, 1);
  frameRate(60);
}

void draw() {  
  clear();  
  // background(bg.get(myPlayer1.getXpos()-width/2, myPlayer1.getYpos()-width/2, width, height));
  myPlayer1.trigger();
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

/*
void keyReleased() {
  switch(key) {
  case 'q':
    ability1=false;
    break;
  case 'w':
    ability2=false;
    break;
  case 'e':
    ability3=false;
    break;
  }
}
*/

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
  float playerx;
  float playery;
  float moveSpeed;

  float angle=0;
  float rad= 0.0174532925;

  float getMousex;
  float getMousey;
  
  float getPressx;
  float getPressy;

  float xcount;
  float ycount;

  int range=300;
  int playerAbility;

  Player(float x, float y, float move, int ability) {
    playerx=x;
    playery=y;
    moveSpeed=move;
    playerAbility=ability;
  }

  void trigger() {
    chooseAbility();
    move();
  }

  void chooseAbility(){
    if(playerAbility==1){
      ability();
    }
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
      moveSpeed=2;
    }
    if (mouseButtonLeft==true) {
      getPressx=mouseX;
      getPressy=mouseY;
    }
  }

  void move() {
    if (abs(playerx-getMousex)<moveSpeed+0.1 && abs(playery-getMousey)<moveSpeed+0.1) {
      moveSpeed=0;
    }

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

  int getXpos() {
    return (int)playerx;
  }

  int getYpos() {
    return (int)playery;
  }



    void ability() {
    if (ability1==true) {
      ellipseMode(CENTER);
      fill(0);
      stroke(255);
      ellipse(playerx, playery, range, range);
    }
    if( ability1==true){
      if(  (abs(playery-getPressy))*(abs(playerx-getPressx))*(abs(playery-getPressy))*(abs(playerx-getPressx))<range)
      println(getPressx+"    "+getPressy);
      ellipse(getPressx, getPressy, 20, 20);
    }
    
  }

}
  
