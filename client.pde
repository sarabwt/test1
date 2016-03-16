import processing.net.*;

PImage imgPlayer, imgBackground;

Player Player;

boolean mouseButtonRight, mouseButtonLeft = false;
boolean ability1, ability2, ability3 =false;

Client c;
String input;
int data[];

void setup() {
  size(700, 700);
  imgPlayer = loadImage("data/z4gt3.png");
  imgBackground = loadImage("data/proga2.png");
  Player = new Player (200, 200, 2);
  frameRate(60);
  background(204);
  c = new Client(this, "192.168.1.67", 12345);
}

void draw() {   
  background(imgBackground.get(Player.getXpos()-width/2, Player.getYpos()-width/2, width, height));
  Player.move();
  
  c.write(Player.getXpos() +" "+ Player.getYpos()+" "+ Player.getAngle() + "\n");
 
  println(Player.getXpos() +" "+ Player.getYpos()+" "+ Player.getAngle());
  if (c.available() > 0) { 
    input = c.readString(); 
    input = input.substring(0,input.indexOf("\n"));  // Only up to the newline
    data = int(split(input, ' '));  // Split values into an array
    // Draw line using received coords
    pushMatrix();
    imageMode(CENTER);
    translate(data[0], data[1]);
    rotate(data[2]);
    image(imgPlayer,0,0); 
    popMatrix();
  }
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
  float playerx;
  float playery;
  float moveSpeed;

  float angle=0;
  float rad= 0.0174532925;

  float remplayerx;
  float remplayery;

  float getMousex;
  float getMousey;

  float setMousex;
  float setMousey;

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
      setMousex=-(width/2-mouseX);
      setMousey=-(height/2-mouseY);

      remplayerx=playerx;
      remplayery=playery;
      getMousex=mouseX;
      getMousey=mouseY;
      
      
    }
  }

  void move() {
    moveSpeed=2;
    rotatePlayer();

    if (int(remplayerx+setMousex)>int(playerx)-moveSpeed && int(remplayerx+setMousex)<int(playerx)+moveSpeed && int(remplayery+setMousey)<int(playery)+moveSpeed && int(remplayery+setMousey)>int(playery)-moveSpeed) {
      moveSpeed=0;
    }
    playerx = playerx + cos(angle)*moveSpeed;
    playery = playery + sin(angle)*moveSpeed;

  }

  void rotatePlayer() {
    pushMatrix();
    keyCheck();
    imageMode(CENTER);
    translate(width/2, height/2);
    rotate(angle);
    image(imgPlayer, 0, 0);
    translate(-width/2, height/2);  
    popMatrix();
  }

  int getXpos() {
    return (int)playerx;
  }

  int getYpos() {
    return (int)playery;
  }
  float getAngle(){
  return angle;
  }
}
