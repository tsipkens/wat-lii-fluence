

clear; close all; clc;

% Generate property structure
% contains default soot properties
% will display in window (since semicolon excluded).
prop = get_prop
prop.Eml = 0.1;

% Get transition fluence and temperature.
[Tref, Fref] = get_ref(prop)


% Generate peak temperature curves,
% mostly uses default properties.
[T_fun, T_high, T_low] = ...
    gen_peak_fun(prop, -10);


% Generate plot of peak temperature curve.
F0_vec = linspace(eps, 3*Fref, 450); % fluence to evaluate funs.
T_vec = T_fun(F0_vec); % predicted peak temperature curve

figure(1);
plot(F0_vec, T_vec, 'k', 'LineWidth', 1.2); % plot overall fluence curve
hold on;
plot(F0_vec, T_low(F0_vec), '-'); % plot low-fluence regime expression
plot(F0_vec, T_high(F0_vec), '-'); % plot high-fluence regime expression
hold off;

xlim([0, 3*Fref]); % adjust x limits of the plot based on Fref
ylim([prop.Tg, 1.2*Tref]); % adjust y limits of the plot based on Tref


% Generate an appxroximate incandescence curve. 
figure(3);
F0_vec2 = linspace(eps, 6*Fref, 550);  % extended fluence range
[J, DM, J0] = estimatej(F0_vec2, prop, 500e-9);

plot(F0_vec2, J, 'k', 'LineWidth', 1.2);
hold on;
plot(F0_vec2, J0);
plot(F0_vec2, DM .* max(J));
plot(F0_vec2, nthroot(DM, 3) .* max(J));
hold off;

ylim([0, 1.5 .* max(J)]);

