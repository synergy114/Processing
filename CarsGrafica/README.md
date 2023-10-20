VISUALIZATION OF CARS DATASETS

This project generates visualization dashboard fthe cars dataset which contains 406 observation on 8 variables i.e, MPG (miles per gallon), Number of cylinders, engine displacement (cu. inches), horsepower, vehicle weight (lbs.), time to accelerate from O to 60 mph (sec.), model year, and origin of car (1. American, 2. European, 3. Japanese).

 
Prerequsites:
1. Processing Programming Editor https://processing.org/ 
2. Grafica Library for Processing.
 Install them using Tools => Manage Tools => Library => Grafica  in Processing Environment.
3. DataSet.
cars.csv dataset file must be in the same folder as CarsGraphica.pde .

Implement the program:
Open the CarsGrafica.pde file and click on run. 

Data Preprocessing:
Missing values are amputated. 

Setup part: 
1. points for plots have been generated going through row by row in the daataset. 
2. Columns were saved to vector arrays for later use for barpots.
3. Plots were designed. 

Independent functions:
1. Thresholds accepts an array (data column) and returns  values needed for drawing boxplots (min, max, IQ1, IQ3, Median).
2. Outliers function for the given array returns outlier points as GPointsArray object for plotting on the boxplots . 

 _------------------------------
 
ABOUT Viz

For plots with colored categories, attempt was made to ensure that the minority group is “visible” by adjusting color hue and transperancy.

Mpg is represented as a point size in the central lower plot.  Mpg/2 was used as a metric for the pixel size diameter.

Horsepower is visualized in left upper corner plot as point pixel size (metric is horsepower/8).

Acceleration can be seen in one of the barplots and central upper plot as point sizes. Metric is (20-acceleration)*2. The reason for this choice is that perceptually users consider “car great at acceleration” if it takes shorter time to accelerate.  If acceleration is plotted as given, it gave misleading perception: better was smaller. 