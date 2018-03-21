boolean timeIntervall() {
  unsigned long currentTime = millis();
   
  // Chedk if it's time to make an interupt
  if(currentTime - lastTime >= interval) {
    lastTime = lastTime + interval;

    return true;
  }else if(currentTime<lastTime) {
    // After 50 day millis() will start 0 again
    lastTime = 0;
    
  }else{
    return false;
  }
  
}
