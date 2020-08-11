
% GEN_PEAK_FUN Outputs peak temperature expression with fluence.
%   Generates three function handles: 
%       (1) an interpolated function between T_high and T_low;
%       (2) T_high, corresponding to the high fluence regime expression;
%       (3) T_low, corresponding to the low fluence regime expression. 
%   
%   By default this function outputs function handles that take a fluence
%   in J/cm^2 and outputs a peak temperature in K. The opts struct allows
%   output as follows: 
%       opts = 'dimless' - outputs a function handle that takes a
%           dimensionless fluence and outputs a dimensionless peak
%           temperature
%       opts = 'mix' - outputs a function handle that takes a dimensionless
%           fluence and outputs a peak temperature in K
%       opts = 'default' - outputs the default function handle, which takes
%           a normal fluence in J/cm2 and outputs a peak temperature in K
%
%   F1 = dimensionless fluence
%   F0 = fluence in J/cm^2
%
%   Author: Timothy Sipkens
%=========================================================================%

function [T_fun, T_high, T_low] = gen_peak_fun(prop, opts, n, Tref, Fref)

%== Parse inputs ===================================%
if nargin<2; opts = []; end
if isempty(opts); opts = 'default'; end % set default options (output T in K and F0 in J/cm2)

% power in interpolation function
if nargin<3; n = -10; end

% check if Tref and Fref were not included
% get transition/reference fluence and temperature
if nargin<5
    [Tref, Fref] = get_ref(prop);    
end
%===================================================%


% Generate basic function handles / mix
T_high_dl = @(F1) -2 * prop.hvb / prop.Rs ./...
    lambertw(-1, -prop.C1 .* (prop.dp .* (Tref - prop.Tg) ./ prop.tlp .* F1) .^ 2);
        % high fluence expression
T_low_dl = @(F1) F1 .* (Tref - prop.Tg) + prop.Tg; % low fluence expression
T_fun_dl = @(F1) (T_high_dl(F1) .^ n + ...
    (T_low_dl(F1)) .^ n) .^ (1 ./ n); % interpolation function


% Consider opts variable for output
switch opts
    case {'dimless','dimensionless'}
        T_fun = @(F1) (T_fun_dl(F1) - prop.Tg)./(Tref - prop.Tg);
        T_high = @(F1) (T_high_dl(F1) - prop.Tg)./(Tref - prop.Tg);
        T_low = @(F1) (T_low_dl(F1) - prop.Tg)./(Tref - prop.Tg);
    case 'mix'
        T_fun = T_fun_dl;
        T_high = T_high_dl;
        T_low = T_low_dl;
    otherwise % /10000 converts fluence from J/cm^2 to J/m^2
        T_fun = @(F0) T_fun_dl(F0 ./ Fref);
        T_high = @(F0) T_high_dl(F0 ./ Fref);
        T_low = @(F0) T_low_dl(F0 ./ Fref);
end

end

