class pulse {
  //int lastPulseMax = 0;
  int lastPulseTime = 0;
  int thisPulseMax = 0;
  int thisPulseTime = 0;
  
  int pulseTimeMin = 500;        // time = PTM / 60 * 1000ms  -> 200 BPM / 60 s/min * 1000 ms/s = 500 ms
  int pulseTimeMax = 3300;        // time = PTM / 60 * 1000ms  -> 30 BPM / 60 s/min * 1000 ms/s = 500 ms
  
  int periodeTime = 0;
  int BeatPerMinute = 0;
  
  boolean pulseEnded = false;
  
  
  pulse(int _pulseTimeMin, int _pulseTimeMax) {
    
    pulseTimeMin = _pulseTimeMin;
    pulseTimeMax = _pulseTimeMax; 
  }
  
  void addData(float _sampleData) {
    println("sampleData: " + _sampleData);
    int sampleData = int(_sampleData);
    
    int timeNow = millis();
    
    if(pulseEnded) {
      periodeTime = thisPulseTime - lastPulseTime;
      BeatPerMinute = int(60000 / float(periodeTime));
      
      //CurveA.addData(BeatPerMinute);
      
      lastPulseTime = thisPulseTime;
      thisPulseTime = timeNow;
      thisPulseMax = 0;
      pulseEnded = false;

    }
    
    if( timeNow > (thisPulseTime + pulseTimeMin)  ) {   // this pulse is over
      pulseEnded = true;
    }
        
    if(sampleData  > thisPulseMax) {            // find topp
      thisPulseMax = round(sampleData);
      thisPulseTime = timeNow;
    }

  }
  
  void display() {
    String label = "Puls: " + BeatPerMinute + " BPM\n";
    label += "Periode: " + periodeTime + " ms\n";
    label += "Periode: " + periodeTime/1000.0 + " s\n";
    text(label, 1150, 50);
  }
  
  
  
}