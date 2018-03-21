class visualDataGenerator {
  
  float angel = 0.0;
  float angelSpeed = 0.03;
  float amplitude = 150;
  
  
  float  out() {
    angel += angelSpeed;
    return (amplitude * sin(angel));
  }
  
}