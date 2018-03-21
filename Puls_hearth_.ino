
unsigned long lastTime = 0;        // will store last time value was sendt
const long interval = 20;           // interval at which to send result

long sensorValueA = 0;
long sensorValueB = 0;
int sampleCount = 0;

String c = "";

void setup() {
  // set the digital pin as output:
  Serial.begin(38400);   
}

void loop()
{
  // Do the sample
  doSampling();
  
  // Chedk if it's time to sendt data
  if(timeIntervall()) {
    sendData();
    resetSampling();
    
  }
}

void doSampling() {
  sampleCount++;
  sensorValueA += float(analogRead(A0));
  sensorValueB += float(analogRead(A1));
}

void resetSampling() {
  sampleCount = 0;
  sensorValueA = 0;
  sensorValueB = 0;
}



void sendData() {
  Serial.print(lastTime);
  Serial.print("\t");
  Serial.print(sensorValueA);
  Serial.print("\t");
  Serial.print(sampleCount);
  Serial.print("\t");
  Serial.print(float(sensorValueA) / float(sampleCount));      //Calculate RMS and send
  Serial.print("\t");
  Serial.print(float(sensorValueB) / float(sampleCount));      //Calculate RMS and send
  Serial.println(c);
}



