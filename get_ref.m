
% GET_REF Calculates fluence regime transition temperature and fluence. 
%   This function takes a property struct and outputs the reference or
%   transition fluence (Fref) and temperature (Tref). 
%
%   Author: Timothy Sipkens
%=========================================================================%

function [Tref, Fref] = get_ref(prop)

% function to minimize to solve for Tref
min_fun = @(Tref) norm(...
    2*prop.hvb/prop.Rs+...
    Tref.*lambertw(-1,-prop.C1.*(prop.dp.*(Tref-prop.Tg)./prop.tlp).^2)...
    );


% optimization to find reference temperature
T0 = 3000; % starting point for minimizer, K
Tref = fminsearch(min_fun,T0); % calculate reference temperature, K


% reference fluence from reference temperature
Fref = prop.l_laser * prop.rho * prop.cp * ...
    (Tref-prop.Tg) / (6*pi*prop.Eml) / ...
    10000; % /10000 converts fluence to J/cm^2

end

