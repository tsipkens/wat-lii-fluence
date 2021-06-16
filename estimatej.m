
% ESTIMATEJ  Estimate the peak incandescence curve.
%  
%  AUTHOR: Timothy Sipkens, 2021-06-16

function [J, DM, J0] = estimatej(F0, prop, l)

phi = 1.44e-2;

[T, ~, Tlow] = gen_peak_fun(prop);

DT = Tlow(F0) - T(F0);  % extra energy [K] to evaporation
DM = max(1 - DT ./ prop.hvb .* prop.cp, 0);  % mass loss

J = DM ./ (exp(phi ./ T(F0) ./ l) - 1);

J0 = 1 ./ (exp(phi ./ T(F0) ./ l) - 1);  % no evaporation incand.

end
