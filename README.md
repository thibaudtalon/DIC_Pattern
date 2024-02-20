# DIC_Pattern
Generate a pseudo-random pattern for using Digital Image Correlation with large structures

This code is designed to run with MATLAB

Please see my thesis: https://thesis.library.caltech.edu/13650/1/Thibaud_Talon_2020_Thesis.pdf (page 59) and my website https://www.thibaudtalon.com/large-dic-patterns for more informations

You need to use both files (PerlinNoise.m is a function). 

Launch CreatePattern.m where you can modify the following:
  1. Size of pattern X x Y [mm]
  2. Size of camera pixel on pattern [mm]
     -  This is the projected size of one pixel on the surface to measure
     -  p = (Distance from cameras to surface [mm]) / (Focal length of the cameras [mm]) * (Size of sensor pixel [mm])
     -  Size of sensor pixel is usually in the order of 3 micons
  3. Amount of white/black (50% yield good results)

The output will be 2 figures:
  1. A plot of the cutout to be used to create a stencil
  2. The black and white pattern
