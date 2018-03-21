//dette kjøres vær gang det kommer inn en linje tekst fra Arduinoen

void serialEvent(Serial p) {
  
  String message = p.readStringUntil('\n'); // read one line of serial data
  
  //print(message + "-");
  //try {
    if (message != null) {
      //println(" ");
      println(message);
      String [] data  = splitTokens(message, "\t"); // Split the message at ',' or '\n'
      
    //appendTextToFile(getFileName(), message);

      //  hent ut data fra plass 1 og legg det til grafen
      // prøv med f.eks. data[7] eller 8
      if(data.length>3 ) {
        
        if(countDownForSampling > 0) {
          countDownForSampling--;
        }else{
          CurveA.addData(float(data[3]));
          myPulse.addData(float(data[3]));
          dataSmooth = float(data[3]) * 0.01 + dataSmooth * 0.99;
          CurveB.addData(dataSmooth);
          
          loop();
        }
      }
      
      
    }
    /*
  }catch(IndexOutOfBoundsException e) {
    println("Caught IOException: " + e.getMessage());
  }*/
  
  
}

void appendTextToFile(String filename, String text){
  // Add a new line til obj-file
  
  File f = new File(dataPath(filename));
  if(!f.exists()){
    createFile(f);
  }
  try {
    PrintWriter out = new PrintWriter(new BufferedWriter(new FileWriter(f, true)));
    
    out.println(text);
    out.close();
  }catch (IOException e){
      e.printStackTrace();
  }
}

//Creates a new file including all subfolders

void createFile(File f){
  String textFileHeader = "time\taX\taY\taZ\tgX\tgY\tgZ\ta00\ta01";
  File parentDir = f.getParentFile();
  try{
    parentDir.mkdirs(); 
    f.createNewFile();
    
    PrintWriter out = new PrintWriter(new BufferedWriter(new FileWriter(f, true)));
    out.println(textFileHeader);
    out.close();
    
  }catch(Exception e){
    e.printStackTrace();
  }
} 



String getFileName() {
  // nytt navn hver time
  String fileName;
  
  fileName = String.valueOf(year());
  fileName += "-";
  fileName += String.valueOf(month());
  fileName += "-";
  fileName += String.valueOf(day());
  fileName += "-";
  fileName += String.valueOf(hour());
  fileName += ".txt";
  
  return fileName;
  
}