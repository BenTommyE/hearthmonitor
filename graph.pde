class GraphPlot {
    int borderTopp = 27;
    int borderLeft = 10;
    int borderRight = 100;
    int borderBottom = 27;
    
    int GraphWidth = 1000;
    int GraphHeight = 600;
    int GraphBorderTopLeftX = 10;
    int GraphBorderTopLeftY = 10;
    int GraphTopLeftX = GraphBorderTopLeftX + borderLeft;
    int GraphTopLeftY = GraphBorderTopLeftY + borderTopp;
    
    int GraphBottom = GraphTopLeftX + GraphHeight;
    
    String label = "Arduino";
    color labelColor = color(0,255,255);
    int autoZoomPlace = 0;

    int GraphHeightMid = GraphTopLeftY + GraphHeight / 2;
    float[] yGraphValueArr = new float[GraphWidth]; //graf array
    int[] yGraphTimeArr = new int[GraphWidth]; //graf array
    float GraphMax = 260;
    float GraphMin = -60;
    float GraphMid = 100;
    float GraphOffset = 0;
    float GraphGain = 1;
    int zoomFactor = 4;
    
    boolean autoZoom = true;
    
    GraphPlot(String _label, color _labelColor) {
      label = _label;
      labelColor = _labelColor;
    }
    
    
    void addData(float newYValue) {
      //skroll kurven og legg til data på slutten
      if(autoZoom) {
        GraphMax = yGraphValueArr[0];
        GraphMin = yGraphValueArr[0];
      }
      
      if(autoZoomPlace < GraphWidth/zoomFactor) {
        autoZoomPlace++;
      }else{
        for(int x = 1; x<GraphWidth/zoomFactor; x++) {
          yGraphValueArr[x-1] = yGraphValueArr[x];         //flytt alle dataene i arrayen en plass til venstre
          yGraphTimeArr[x-1] = yGraphTimeArr[x];
        }
      }
      
      yGraphValueArr[autoZoomPlace-1] = newYValue;          //legg til data på plassen lengst til høyre
      yGraphTimeArr[autoZoomPlace-1] = millis();
      
      // find min and max
      if(autoZoom) {
        for(int x = 0; x<autoZoomPlace; x++) {
            if(GraphMax < yGraphValueArr[x]) {
              GraphMax = yGraphValueArr[x];
            }
            if(GraphMin > yGraphValueArr[x]) {
              GraphMin = yGraphValueArr[x];
            }          
        }
      }
      
      
      GraphMid = (GraphMax - GraphMin) / 2;
      
      if(GraphMin == GraphMax) {
        GraphGain = 1;
        //println("GraphMid: " + GraphMid + "\tGraphMin: " + GraphMin + "\tGraphMax: " + GraphMax+ "\tGraphGain: "  + GraphGain + "\tGraphMin == GraphMax");
      }else{
        GraphGain = GraphHeight / (GraphMax - GraphMin);
        //println("GraphMid: " + GraphMid + "\tGraphMin: " + GraphMin + "\tGraphMax: " + GraphMax+ "\tGraphGain: "  + GraphGain);
      }
      GraphOffset = GraphHeightMid - GraphMid * GraphGain;
    }

    void displayAll() {
      displayBackground();
      displayGraph();
      
    }
    
    void displayBackground() {
      // border
      fill(0,32,64);
      stroke(0,50,128);
      rect(GraphBorderTopLeftX, GraphBorderTopLeftY, GraphWidth + borderRight, GraphHeight + borderTopp + borderBottom, 10);
      
      //graph erea
      fill(0,25,50);
      rect(GraphTopLeftX, GraphTopLeftY, GraphWidth, GraphHeight);
      line(GraphTopLeftX, GraphHeightMid, GraphTopLeftX + GraphWidth, GraphHeightMid);
      
    }
    
    void displayGraph() {
      if(autoZoomPlace>1) {
        // tegne grafen
        noFill();
        stroke(labelColor);          //set strekfarge til svart
        
        float xStrech = float(GraphWidth) / float(autoZoomPlace);
        
        float tempOffset = GraphHeight + GraphTopLeftY;
        
        for(int x = 1; x<autoZoomPlace; x++) {                  //lopp gjennom arrayen start 1 ikke null da x-1 bilr 0
          //float y1 = tempOffset - GraphGain * yGraphValueArr[x-1];   //beregn første y punkt (x-1)
          //float y2 = tempOffset - GraphGain * yGraphValueArr[x];     //beregn andre y punkt  (x)
          
          float x1 = xStrech * (x - 1.0) + GraphTopLeftX;
          float x2 = xStrech * x + GraphTopLeftX;
          
          float y1 = map(yGraphValueArr[x-1], GraphMin, GraphMax, GraphBottom+10, GraphTopLeftY+10);
          float y2 = map(yGraphValueArr[x], GraphMin, GraphMax, GraphBottom+10, GraphTopLeftY+10);
          
          line(x1, y1, x2, y2);                               //tegn en linje fra første til andre punktet på kurven
        }
        
        textFont(font,12); 
        fill(labelColor);
        text(label, GraphTopLeftX + graphTextLabelPos, GraphBorderTopLeftY + 19);
        graphTextLabelPos += 100;
        // y labels
        text(GraphMax, GraphTopLeftX + GraphWidth + 5, GraphTopLeftY + 10);      
        text((GraphMax+GraphMin)/2, GraphTopLeftX + GraphWidth + 5, GraphHeightMid + 5);      
        text(GraphMin, GraphTopLeftX + GraphWidth + 5, GraphTopLeftY + GraphHeight);
        // x labels
        String timeLabel = "Time: " + ((yGraphTimeArr[autoZoomPlace-1] - yGraphTimeArr[0]) / 1000) + " s";
        text(timeLabel, GraphTopLeftX, GraphTopLeftY + GraphHeight+20);
      }
    }

}