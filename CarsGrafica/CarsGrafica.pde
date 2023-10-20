///////////////////////////////
//Shakhnoza Takhirova
//Oct. 15, 2023
//This a simple graphing program. It uses grafica to plot the datasets inside cars.csv
//In this code data dashboard for the "cards.csv" has been created using Grafica package.
//Graphs like scatterplots, boxplots are displayed 
// Interactivity is based on mouse click on scatterplots which shows the name of the cars
// Missing values are amputated. 
// in setup part: 
// 1. points for plots have been generated going through row by row in the daataset. 
// 2. Columns were saved to vector arrays for later use for barpots.
// 3. Plots were designed. 
// Independent functions:
// 1. Thresholds accepts an array (data column) and returns  values needed for drawing boxplots (min, max, IQ1, IQ3, Median).
// 2. Outliesr function for the given array returns outlier points as GPointsArray object for plotting to the barplots . 


import grafica.*;
public GPlot plot, plot1, plot2, plot3, plot4, plot21, plot22, plot23, plotbox;

public void setup() {
//////
//
String a="Bigger the cirle";

  size(1700, 900);
  Table table = loadTable("cars.csv", "header");
  String[] Name={}, Org={};
  float[] Mpg={}, Acc={};
  int[] Cyl={}, Disp={}, Hrs={}, Wgt={}, Model={};
  float[] pSizes42={}, pSizes44={}, pSizes45={}, pSizes46={}, pSizes48={};

  // Prepare the points for the first plot
  // Save the data in one GPointsArray and calculate the point sizes
  //GPointsArray points = new GPointsArray();
  GPointsArray pointsJP = new GPointsArray();
  GPointsArray pointsUS = new GPointsArray();
  GPointsArray pointsEU = new GPointsArray();
  //Pointsizes
  float[] pointSizesUS ={};
  float[] pointSizesJP={};
  float[] pointSizesEU={}, pointSizes2={};

  GPointsArray points2 = new GPointsArray(),  points42 = new GPointsArray(), points44 = new GPointsArray(), points45 = new GPointsArray(), points46 = new GPointsArray(), points48 = new GPointsArray();


  // float[] pointSizes2={}, pointSizes3={};
  GPointsArray points21 = new GPointsArray();
  GPointsArray points22 = new GPointsArray();
  GPointsArray points23 = new GPointsArray();
  GPointsArray points24 = new GPointsArray();


  for (int row = 0; row < table.getRowCount(); row++) {
    String name = table.getString(row, "Name");
    float mpg = table.getFloat(row, "mpg");
    int cyl = table.getInt(row, "cylinders");
    int disp = table.getInt(row, "displacement");
    int hrspw = table.getInt(row, "horsepower");
    int wgt = table.getInt(row, "weight");
    int mdl = table.getInt(row, "model");
    float acc=table.getFloat(row, "acceleration");
    //Adding counties as colored layers
    String origin;
    ///////////////////////////////////
    // Saving data columns into vector arrays
    Name=append(Name, name);
    Mpg=append(Mpg, mpg);
    Cyl=append(Cyl, cyl);
    Disp=append(Disp, disp);
    Hrs=append(Hrs, hrspw);
    Wgt=append(Wgt, wgt);
    Acc=append(Acc, acc);
    Model=append(Model, mdl);

    ////////////////////////////////////////////////
    ///Points For Plot 1 //////////////////
    switch(table.getInt(row, "origin")) {
    case 1:
      origin="American";
      if (hrspw!=0) {
        pointsUS.add(hrspw, wgt, name);
        pointSizesUS=append(pointSizesUS, ((20-acc)*2));
        Org=append(Org, origin);
      }
      print(pointSizesUS.length);
      break;
    case 2:
      origin="European";
      if (hrspw!=0) {
        pointsEU.add(hrspw, wgt, name);
        pointSizesEU=append(pointSizesEU, (20-acc)*2);
        Org=append(Org, origin);
      }
      break;
    case 3:
      origin="Japanese";
      if (hrspw!=0) {
        pointsJP.add(hrspw, wgt, name);
        pointSizesJP=append(pointSizesJP, (20-acc)*2);
        Org=append(Org, origin);
      }
      break;
    }

    ////////////Plot2 points/////////////////////////

    points2.add(disp, cyl, name);
    pointSizes2=append(pointSizes2, hrspw/8);

    ///////Correlationpoint
    if (mpg>0) {
      points21.add(mpg, wgt, name);
    }
    if (wgt>0) {
      points22.add(disp, wgt, name);
    }
    if (mpg>0 && hrspw>0) {
      points23.add(mpg, hrspw, name);
    }

    ////////////////////////////////////////
  ///Points for Plot 4
  // generating plot points for 5 layers based on cyl values. 
  
    int k=2;
    
    if (hrspw>0 && mpg>0){
    switch(cyl) {
    case 2:
      if (mpg>0) {
        points42.add(hrspw, mdl, name);
        pSizes42=append(pSizes42, mpg/k);
      }
      break;
    case 4:
      if (mpg>0) {
        points44.add(hrspw, mdl, name);
        pSizes44=append(pSizes44, mpg/k);
      }
      break;
    case 5:
      if (mpg>0) {
        points45.add(hrspw, mdl, name);
        pSizes45=append(pSizes45, mpg/k);
      }
      break;
    case 6:
      if (mpg>0) {
        points46.add(hrspw, mdl, name);
        pSizes46=append(pSizes46, mpg/k);
      }
      break;  
     case 8:
      if (mpg>0) {
        points48.add(hrspw, mdl, name);
        pSizes48=append(pSizes48, mpg/k);
      }
      break; 
    }
    }
    
  }



  ////////////////////////////////////////////////////

color cyl2col=color(0, 0, 255, 150); 
color cyl4col=color(0, 206, 209, 150); 
color cyl5col=color(255, 0, 0, 150); 
color cyl6col=color(102, 25, 255, 100); 
color cyl8col=color(255, 69, 0, 100); 

plot4 = new GPlot(this);
  plot4.setPos(600, 500);
  plot4.setDim(700, 275);
  plot4.getTitle().setText("Horsepower, Cylinder and MPG (point size) by Model");
  plot4.getXAxis().getAxisLabel().setText("Horsepower");
  plot4.getYAxis().getAxisLabel().setText("Model");
  //2-cylinder cars
  plot4.setPoints(points42);
  plot4.setPointSizes(pSizes42);
  plot4.setPointColor(cyl2col);
  plot4.setLineColor(cyl2col);
//4 cylinders
  plot4.addLayer("4", points44);
  plot4.getLayer("4").setPointColor(cyl4col);
  plot4.getLayer("4").setPointSizes(pSizes44);
  plot4.getLayer("4").setLineColor(cyl4col);
//5 cylinders
  plot4.addLayer("5", points45);
  plot4.getLayer("5").setPointColor(cyl5col);
  plot4.getLayer("5").setLineColor(cyl5col);
  plot4.getLayer("5").setPointSizes(pSizes45);
  //6 cylinder
  plot4.addLayer("6", points46);
  plot4.getLayer("6").setPointColor(cyl6col);
  plot4.getLayer("6").setLineColor(cyl6col);
  plot4.getLayer("6").setPointSizes(pSizes46);
  
    //8 cylinder
  plot4.addLayer("8", points48);
  plot4.getLayer("8").setPointColor(cyl8col);
  plot4.getLayer("8").setLineColor(cyl8col);
  plot4.getLayer("8").setPointSizes(pSizes48);


  plot4.activatePointLabels();
  plot4.activatePanning();
  plot4.activateZooming(1.5, CENTER, CENTER);
  
  
  // Setup for the models plot



  // Setup for the first plot
  plot1 = new GPlot(this);
  plot1.setPos(600, 0);
  plot1.setDim(700, 400);
  plot1.getTitle().setText("Horsepower, Weight and Acceleration Speed (point size)");
  plot1.getXAxis().getAxisLabel().setText("Horsepower");
  plot1.getYAxis().getAxisLabel().setText("Weight");
  plot1.setPoints(pointsUS);
  plot1.setPointSizes(pointSizesUS);
  plot1.setPointColor(color(148, 0, 211, 110));
  plot1.setLineColor(color(148, 0, 211, 110));

  plot1.addLayer("Japanese", pointsJP);
  plot1.getLayer("Japanese").setPointColor(color(255, 69, 0, 100));
  plot1.getLayer("Japanese").setPointSizes(pointSizesJP);
  plot1.getLayer("Japanese").setLineColor(color(255, 69, 0, 100));

  plot1.addLayer("European", pointsEU);
  plot1.getLayer("European").setPointColor(color(0, 206, 209, 150));
  plot1.getLayer("European").setLineColor(color(0, 206, 209, 150));
  plot1.getLayer("European").setPointSizes(pointSizesEU);

  plot1.activatePointLabels();
  plot1.activatePanning();
  plot1.activateZooming(1.5, CENTER, CENTER);


  ////////////////////////////////////////////////////////////////
//Setup for the 
  plot2 = new GPlot(this);
  plot2.setPos(0, 0);
  plot2.setDim(500, 175);
  plot2.getTitle().setText("Displacement,Cylinder sizes vs Horsepower");
  plot2.getXAxis().getAxisLabel().setText("Displacement");
  plot2.getYAxis().getAxisLabel().setText("Cylinder");
  plot2.setPoints(points2);
  plot2.setPointSizes(pointSizes2);
  plot2.setPointColor(cyl4col);
  
  plot2.activatePointLabels();
  plot2.activatePanning();
  plot2.activateZooming(1.5, CENTER, CENTER);

  ///////////////////////////////
  ///Correlation plots
  plot21 = new GPlot(this);
  plot21.setPos(1370, 0);
  plot21.setDim(200, 200);
  plot21.getXAxis().getAxisLabel().setText("Mile per Gallon");
  plot21.getYAxis().getAxisLabel().setText("Weight (lbs)");
  plot21.setPoints(points21);
  plot21.setPointColor(color(0, 70, 250, 100));
  plot21.activatePointLabels();
  plot21.activatePanning();
  plot21.activateZooming(1.5, CENTER, CENTER);

  ///

  plot22 = new GPlot(this);
  plot22.setPos(1370, 280);
  plot22.setDim(200, 200);
  plot22.getXAxis().getAxisLabel().setText("Displacement");
  plot22.getYAxis().getAxisLabel().setText("Weight (lb)");
  plot22.setPoints(points22);
  plot22.setPointColor(color(0, 70, 250, 100));
  plot22.activatePointLabels();
  plot22.activatePanning();
  plot22.activateZooming(1.5, CENTER, CENTER);
  ////////////////

  plot23 = new GPlot(this);
  plot23.setPos(1370, 570);
  plot23.setDim(200, 200);
  plot23.getXAxis().getAxisLabel().setText("MPG");
  plot23.getYAxis().getAxisLabel().setText("Horsepower");
  plot23.setPoints(points23);
  plot23.setPointColor(color(0, 70, 250, 100));
  plot23.activatePointLabels();
  plot23.activatePanning();
  plot23.activateZooming(1.5, CENTER, CENTER);

  ///////Boxplot for Acceleration/////////////

  GPointsArray points2a=new GPointsArray(), points2b=new GPointsArray(), points2c=new GPointsArray(), points2x=new GPointsArray(), points2d=new GPointsArray();

  float[] y=Thresholds(Acc);
  println(y);
  points2x=Outliers(Acc, Name);

  points2a.add(1, y[3]);
  points2a.add(4, y[3]);
  points2a.add(4, y[2]);
  points2a.add(1, y[2]);
  points2a.add(1, y[3]);

  points2b.add(2.5, y[1]);
  points2b.add(2.5, y[3]);

  points2c.add(2.5, y[2]);
  points2c.add(2.5, y[0]);

  points2d.add(1, y[4]);
  points2d.add(4, y[4]);

  // Create the plot
  plot = new GPlot(this);
  plot.setPos(0, 280);
  plot.setDim(200, 500);
  plot.setPoints(points2x);
  plot.addLayer("surface", points2a);
  plot.getLayer("surface").setLineColor(cyl8col);
  plot.addLayer("Whisker", points2b);
  plot.getLayer("Whisker").setLineColor(color(100, 0, 100));
  plot.addLayer("Whiskerb", points2c);
  plot.getLayer("Whiskerb").setLineColor(color(100, 0, 100));
  plot.addLayer("Mean", points2d);
  plot.getLayer("Mean").setLineColor(color(0, 0, 255));
  //plot.getTitle().setText("Accelaration");
  plot.getYAxis().getAxisLabel().setText("Acceleration");
  plot.activatePointLabels();

  /////////////////////////////////////////////////////////////////

  GPointsArray points3a=new GPointsArray(), points3b=new GPointsArray(), points3c=new GPointsArray(), points3x=new GPointsArray(), points3d=new GPointsArray();

  float[] w=Thresholds(Mpg);
  println(w);
  points3x=Outliers(Mpg, Name);

  points3a.add(1, w[3]);
  points3a.add(4, w[3]);
  points3a.add(4, w[2]);
  points3a.add(1, w[2]);
  points3a.add(1, w[3]);

  points3b.add(2.5, w[1]);
  points3b.add(2.5, w[3]);

  points3c.add(2.5, w[2]);
  points3c.add(2.5, w[0]);

  points3d.add(1, w[4]);
  points3d.add(4, w[4]);

  // Create the boxplot plot 
  plotbox = new GPlot(this);
  plotbox.setPos(300, 280);
  plotbox.setDim(200, 500);
  plotbox.setPoints(points3x);
  plotbox.addLayer("surface", points3a);
  plotbox.getLayer("surface").setLineColor(cyl8col);
  plotbox.addLayer("Whisker", points3b);
  plotbox.getLayer("Whisker").setLineColor(color(100, 0, 100));
  plotbox.addLayer("Whiskerb", points3c);
  plotbox.getLayer("Whiskerb").setLineColor(color(100, 0, 100));
  plotbox.addLayer("Mean", points3d);
  plotbox.getLayer("Mean").setLineColor(color(0, 0, 255));
  //plotbox.getTitle().setText("Accelaration");
  plotbox.getYAxis().getAxisLabel().setText("MPG");
}

//////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////

public void draw() {
  background(255);
  /////////////////////////////////
  plot1.beginDraw();
  plot1.drawBox();
  plot1.drawXAxis();
  plot1.drawYAxis();
  plot1.drawTitle();
  plot1.drawPoints();
  plot1.drawGridLines(GPlot.BOTH);
  plot1.drawLegend(new String[] {"American", "Japanese", "European"},
    new float[] {0.07, 0.22, 0.35}, new float[] {0.92, 0.92, 0.92});
  //plot1.drawAnnotation( "Bigger is the circle more time it takes to accelerate. ", .1, .95, 100,1000);
  plot1.drawLabels();
  plot1.endDraw();
  ///////////////////////
  
    /////////////////////////////////
  plot4.beginDraw();
  plot4.drawBox();
  plot4.drawXAxis();
  plot4.drawYAxis();
  plot4.drawTitle();
  plot4.drawPoints();
  plot4.drawGridLines(GPlot.BOTH);
  plot4.drawLegend(new String[] {"2-cyl", "4-cyl", "5-cyl", "6-cyl", "8-cyl"},
    new float[] {0.95, 0.95, 0.95, 0.95, 0.95}, new float[] {0.92, 0.85, 0.78, 0.70, 0.63});

  plot4.drawLabels();
  plot4.endDraw();
  ///////////////////////

  /////////////////////////////////
  plot2.beginDraw();
  plot2.drawBox();
  plot2.drawXAxis();
  plot2.drawYAxis();
  plot2.drawTitle();
  plot2.drawPoints();
  plot2.drawGridLines(GPlot.BOTH);
  plot2.drawLabels();
  plot2.endDraw();
  ///////////////////////
  plot.beginDraw();
  plot.drawBackground();
  plot.drawBox();
  plot.drawYAxis();
  plot.drawTitle();
  plot.getMainLayer().drawPoints();
  plot.getLayer("surface").drawFilledContour(GPlot.HORIZONTAL, 50);
  plot.getLayer("Whisker").drawLines();
  plot.getLayer("Whiskerb").drawLines();
  plot.getLayer("Mean").drawLines();
 
  plot.endDraw();
  //////////////////////////////////////////
  plotbox.beginDraw();
  plotbox.drawBackground();
  plotbox.drawBox();
  plotbox.drawYAxis();
  plotbox.drawTitle();
  plotbox.getMainLayer().drawPoints();
  plotbox.getLayer("surface").drawFilledContour(GPlot.HORIZONTAL, 50);
  plotbox.getLayer("Whisker").drawLines();
  plotbox.getLayer("Whiskerb").drawLines();
  plotbox.getLayer("Mean").drawLines();
  plotbox.endDraw();

  /////////////////////////////////////
  plot21.beginDraw();
  plot21.drawBox();
  plot21.drawXAxis();
  plot21.drawYAxis();
  plot21.drawTitle();
  plot21.drawPoints();
  plot21.drawGridLines(GPlot.BOTH);
  plot21.drawLabels();
  plot21.endDraw();


  /////////////////////////////////////
  plot22.beginDraw();
  plot22.drawBox();
  plot22.drawXAxis();
  plot22.drawYAxis();
  plot22.drawTitle();
  plot22.drawPoints();
  plot22.drawGridLines(GPlot.BOTH);
  plot22.drawLabels();
  plot22.endDraw();


  /////////////////////////////////////
  plot23.beginDraw();
  plot23.drawBox();
  plot23.drawXAxis();
  plot23.drawYAxis();
  plot23.drawTitle();
  plot23.drawPoints();
  plot23.drawGridLines(GPlot.BOTH);
  plot23.drawLabels();
  plot23.endDraw();
}


////////////////////
///Outliers///////////////////
///////////////////////////
GPointsArray Outliers(float[] x, String[] N) {

  GPointsArray pointsXout = new GPointsArray();



  float[]  boxVal=Thresholds(x);
  for (int i = 0; i < x.length; i++) {
    if (x[i] > 0) {
      if (x[i]<boxVal[0] || x[i]>boxVal[1]) {
        pointsXout.add(2.5, x[i], N[i]);
        print(x[i]);
      }
    }
  }
  return pointsXout;
}
//////////////////////////////////////////
///////// Thresholds for box plot
//////////////////////////////////////////
float[] Thresholds(float[] arr) {
  // Remove 0s from the array
  float[] nonZeroValues ={};
  float med, IQR;
  for (float value : arr) {
    if (value > 0) {
      nonZeroValues=append(nonZeroValues, value);
    }
  }

  int n = nonZeroValues.length;
  float[] rng = new float[5]; // Create a float array to store the range

  // Sort the array in ascending order
  nonZeroValues=sort(nonZeroValues);
  if (n % 2 == 0) {
    med = (nonZeroValues[n / 2] + nonZeroValues[n / 2 - 1]) / 2.0f; // Median for even n
  } else {
    med = nonZeroValues[n / 2]; // Median for odd n
  }

  int lowerIndex = (int)(n / 4); // Index for the lower quartile
  int upperIndex = (int)(3 * n / 4); // Index for the upper quartile

  IQR = nonZeroValues[upperIndex] - nonZeroValues[lowerIndex];
  // Calculate the range using the median and IQR
  rng[0] = med - 1.5 * IQR; //min
  rng[1] = med + 1.5 * IQR; //max
  rng[2] = nonZeroValues[lowerIndex];
  rng[3] = nonZeroValues[upperIndex];
  rng[4] = med;

  return rng;
}
