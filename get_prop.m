
% GET_PROP Formats property struct for input to other functions. 
%   This sets up the proper format for the property struct used in
%   evaluating functions. Units can be altered from those given, but must
%   be consistent to proper non-dimensional quantities (that is, the units
%   must candel out). 
%   
%   The default properties are those for Carbon following the work by 
%   Sipkens et al. [1]. 
% 
%   References:
%   [1] T. A. Sipkens and K. J. Daun, “Defining regimes and analytical 
%       expressions for fluence curves in pulsed laser heating of 
%       aerosolized nanoparticles,” Optics Express, 25(5), 5684-5696 
%       (2017).
%
%   Author: Timothy Sipkens
%=========================================================================%


function prop = get_prop()

%-- Experimental parameters ------------------%
prop.Tg = 1675; % gas temperature, K
prop.dp = 33e-9; % nanoparticle diameter, m
prop.tlp = 8e-9; % FWHM of the laser pulse, s


%-- Spectroscopic properties -----------------%
prop.Eml = 0.44; % absorption function @ laser wavelength
prop.l_laser = 1064e-9; % laser wavelength, m


%-- Sensible energy properties ---------------%
prop.rho = 1.86*1000; % density, kg/m^3
prop.cp = 1900; % specific heat capacity, J/(kg*K)


%-- Vaporization properties ------------------%
prop.M = 3*0.01201; % molar mass of the vapor, kg/mol
prop.mv = prop.M*1.660538782e-24; % mass of the vapor, kg
prop.kb = 1.38064852e-23; % Boltzmann constant, m^2*kg/(s^2*K)
prop.R = 8.3144598; % unviersal gas constant, kg*?m^2/(s^2*K*?mol)
prop.Rs = prop.R/prop.M; % specific gas constant, ?m^2/(s^2*K) 
prop.hvb = 7.9078e5./prop.M; 
    % latent heat of vaporization at boiling point, J/kg

    
%-- Clausius-Clapeyron (C-C) equation --------%
prop.Tb = 3000; % reference temperature of C-C equation, K
prop.Pb = 61.5000; % reference pressure for C-C equation, Pa
prop.A = exp(log(prop.Pb)+prop.hvb/prop.Rs/prop.Tb); % constant for C-C equation, Pa
prop.pv = @(T) prop.A.*exp(-prop.hvref/prop.Rs./T); % C-C equation, Pa

prop.C1 = prop.kb*pi/(9*prop.Rs*prop.hvb*prop.mv)*...
    (prop.rho*prop.cp/prop.A)^2; 
        % parameter C1, as defined in Ref. [1]

end

