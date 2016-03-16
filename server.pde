import processing.net.*;

Server s; 
Client c;
String input;
int data[];

void setup() { 
  frameRate(60); // Slow it down a little
  s = new Server(this, 12345);  // Start a simple server on a port
} 
void draw() { 
  // Receive data from client
  c = s.available();
  if (c != null) {
    input = c.readString(); 
    input = input.substring(0, input.indexOf("\n"));  // Only up to the newline
    data = int(split(input, ' '));  // Split values into an array
    s.write(data[0] + " " + data[1] + " " + data[2] + " " + data[3] + "\n");
  }
}
