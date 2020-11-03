// Game made for the tickle bear controller
// Author: Aaron Veltman
import processing.serial.*;
import processing.sound.*;

Serial mySerial; // creëer lokale Serial object
SoundFile giggle;
ArrayList<Points> points;

PImage img;
String current_target, my_port, my_string;
int current_score = 0;
String[] targets = {
  "Kietel rechter oor", 
  "Kietel linker oor", 
  "Kietel rechter zijde", 
  "Kietel linker zijde"
};

void setup() {
  size(1000, 800);

  img = loadImage("teddy_bear.png");
  giggle = new SoundFile(this, "giggle.mp3");

  points = new ArrayList<Points>();

  my_port = Serial.list() [0]; // luister naar juiste serial poort
  mySerial = new Serial(this, my_port, 9600); // link proccessing aan serial poort

  randomTarget();
}

void draw() {
  drawUI();
  moveAllPoints();

  // voer uit als data aanwezig is op de serial poort
  while (mySerial.available() > 0) {
    checkSerialInput();
  }
}

// Teken de user interface  
void drawUI() {
  background(155, 155, 155);
  image(img, 300, 100);
  textSize(32);
  fill(0, 102, 153);
  text(current_target, 50, 50);
  text("Score: " + current_score, 50, 500);
}

// kijk of de serial input value gelijk is aan de current target
void checkSerialInput() {
  my_string = mySerial.readStringUntil('\n'); // strip data uit serial poort
  int target = Integer.parseInt(my_string.trim()); // verander string naar integer

  //check of data is ontvangen en of het gelijk is aan de current_target index
  if (my_string != null && current_target == targets[target]) {
    randomTarget();
    addPoints();
    delay(100);
  }
}

// voeg random punten toe aan de current score en speel soms audio
void addPoints() {
  int random_points = int(random(10, 50));
  int playSound = int(random(0, 5));

  points.add(new Points(random_points));
  current_score += random_points;

  if (playSound == 1) {
    giggle.play();
  }
}

// beweeg alle nieuwe punten totdat die buiten het scherm zijn
void moveAllPoints() {

  for (int i=0; i<points.size(); i++) {
    Points current_points = points.get(i);
    current_points.movePoints();

    if (current_points.outOfBounds()) {
      points.remove(i);
    }
  }
}


// set current target naar random value uit targets array
void randomTarget() {
  int index = int(random(targets.length));
  current_target = targets[index];
}
