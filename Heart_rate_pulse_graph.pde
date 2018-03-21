import java.io.BufferedWriter;
import java.io.FileWriter;
import processing.serial.*;
Serial port;

PFont font;
int countDownForSampling = 10;

int graphTextLabelPos = 0;


GraphPlot CurveA = new GraphPlot("Pulse", color(0, 255,128));  //Lag et curveobjekt
GraphPlot CurveB = new GraphPlot("Pulse Smooth", color(0, 128,255));  //Lag et curveobjekt
visualDataGenerator simulatedData = new visualDataGenerator();

pulse myPulse = new pulse(500, 3300);

float dataSmooth = 0;

void setup() {
  size(1350, 700);      //Skjermstørrelse
  font = createFont("Arial", 16, true);
  
  String portName = Serial.list()[3];
  println(Serial.list());
  port = new Serial(this, portName, 38400);
  port.bufferUntil('\n');

}

void draw() {
  background(0,20,40);
  graphTextLabelPos = 0;

  
  CurveA.displayBackground();
  CurveA.displayGraph();
  //CurveB.displayGraph();
  
  myPulse.display();
  noLoop();
}