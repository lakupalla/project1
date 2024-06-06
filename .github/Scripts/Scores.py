#Python code to plot he graph:
import pandas as pd
import matplotlib.pyplot as plted
 
# reading the database
data=pd.read_csv(r"C:\\Big Data Knowledge\\python\\Score.csv")
 
# Scatter plot with day against score
plted.plot(data['day'])
plted.plot(data['Score'])
 
# Adding Title to the Plot
plted.title("Scatter Plot")
 
# Setting the X and Y labels
plted.xlabel('Day')
plted.ylabel('Score')
 
plted.show()
