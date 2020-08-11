# Matlab tools for TiRe-LII fluence curves

Version 1.0
October 20 / 2017

This constitutes a software package demonstrating the use of the expressions association with work published in the Optics Express entitled "Defining regimes and analytical expressions for fluence curves in pulsed laser heating of aerosolized nanoparticles" by Sipkens and Daun. 

### Description

This software is an implementation of the simple fluence model presented and Sipkens and Daun. The included function are evaluate the presented expressions to find: (1) the transition or reference fluence and temperature for the given material set and (2) the fluence curve itself, with non-dimensional values or fluences in J/cm^2 and temperatures in K.  

### Components

This software distribution includes the following files:

| File | Description |
| -- | ----|
| README.txt | This file.  |
| main.m | Sample script which illustrates how the code can be used. This includes finding the reference fluence and temperature and plotting the fluence curves.  |
| getProp.m | Sets up property structure that contains the information required for the other functions. Alternatively, one can simply load a pre-computed property structure.  |
| calcTransitionPoint.m | Calculated the transition or reference fluence and temperature. |
| genPeakTempFun.m | Generate function handles describing the fluence curve. The opts input handles whether the generated function handle has non-dimensional inputs and outputs.  |

#### Contact information

The primary author of the code is Timothy A. Sipkens, who can be 
emailed at tsipkens@uwaterloo.ca. 
