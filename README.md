# Matlab tools for TiRe-LII fluence curves

August 11 / 2020

This constitutes a software package demonstrating the use of the expressions association with work published by [Sipkens and Daun (2017)][1]. The included functions evaluate to: (1) compute the transition or reference fluence and temperature for the given material set and (2) evaluate the fluence curve itself, with non-dimensional values or fluences in J/cm<sup>2</sup> and peak temperatures in K. This code replaces an older version available on [figshare][2].  

### Demonstration

To start, generate a structure containing all of the relevant properties and display it in the window

```Matlab
prop = get_prop
```

The user should see an output structure that contain fields corresponding to quantities like the density and specific heat capacity of the particle material, gas temperature, laser wavelength, Clausius-Clapeyron equation parameters, etc. The full list of parameters and their meaning are provided in the gen_prop function for reference. Further details on the physics are also given in [Sipkens and Daun][1]. Users can manually code these values or generate the default structure, as above, and modify the relevant values. It is worth noting that most of the properties are scalars. For example, the density takes on a single value, rather than being temperature-dependent. This is necessary for the simplified analysis suggested by this approach. Typically, evaluating temperature dependent properties around 2,500 K is sufficient to achieve reasonable estimates of the transition temperature and fluence. 

Next, compute the transition fluence and temperature,

```Matlab
[Tref, Fref] = get_ref(prop)
```

The users should now see a set of outputs, where `Tref` corresponds to the peak temperature marking the transition from the low- to high-fluence regime and `Fref` constains the corresponding transition fluence. For the default properties, T<sub>ref</sub> =  4,255.5 K and F<sub>ref</sub> = 0.1170 J/cm<sup>2</sup>. 

One can also generate the actual fluence curves. First, generate function handles corresponding to the low-, high-, and overall expressions from [Sipkens and Daun][1] using

```Matlab
[T_fun, T_high, T_low] = ...
    gen_peak_fun(prop, -10);
```

Then, evaluating and plotting these expressions at a range of fluences. 

```Matlab
F0_vec = linspace(eps, 3*Fref, 450); % fluence to evaluate funs.
T_vec = T_fun(F0_vec); % predicted peak temperature curve

figure(1);
plot(F0_vec, T_vec); % plot overall fluence curve
hold on;
plot(F0_vec, T_low(F0_vec), '--'); % plot low-fluence regime expression
plot(F0_vec, T_high(F0_vec), '--'); % plot high-fluence regime expression
hold off;

xlim([0, 3*Fref]); % adjust x limits of the plot based on Fref
ylim([prop.Tg, 1.2*Tref]); % adjust y limits of the plot based on Tref
```

Note that the plotting limits can be specified relative to the transition temperature and fluence. 

This code is included as the `main` script. 

### Components

This software distribution includes the following files:

1. *README.md*: This file. 
2. *main.m* - Sample script which illustrates how the code can be used. This includes finding the reference fluence and temperature and plotting the fluence curves. 
3. *get_prop.m* - Generates a property structure that contains the information required for the other functions. Alternatively, one can simply load a pre-computed property structure. 
4. *get_ref.m* - Calculates the transition or reference fluence and temperature.
5. *gen_peak_fun.m* - Generates function handles describing the fluence curve. The `opts` input handles whether the generated function handle has non-dimensional inputs and outputs. 
6. *main.m* - A simple script to demonstrate use of this program. 

More information on each file is available in the function / script headers. 

---------

#### Contact information

The primary author of the code is Timothy A. Sipkens, while at the University of Waterloo, who can be contacted at tsipkens@uwaterloo.ca. 

#### How to cite

Individuals who use the relations in this code should cite:

[T. A. Sipkens, K. J. Daun. (2017). "Defining regimes and analytical expressions for fluence curves in pulsed laser heating of aerosolized nanoparticles." Optics Express 25(5).][1]

Those who use this code directly can also make reference to this repository:

T. A. Sipkens. Matlab tools for TiRe-LII fluence curves. url: https://github.com/tsipkens/wat-lii-fluence. 


[1]: https://doi.org/10.1364/OE.25.005684

[2]: https://figshare.com/articles/dataset/MATLAB_tools_for_TiRe-LII_fluence_curves/5513497