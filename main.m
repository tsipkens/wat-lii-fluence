

clear; close all; clc;

% generate property structure
% contains default soot properties
prop = get_prop;


% get transition fluence and temperature
[Tref, Fref] = get_ref(prop)


% generate peak temperature curves
% mostly uses default properties
[T_fun, T_high, T_low] = ...
    gen_peak_fun(prop, -10);


% generate plot of peak temperature curve
F0_vec = linspace(eps, 3*Fref, 450);
T_vec = T_fun(F0_vec);

figure(1);
plot(F0_vec, T_vec); % plot overall fluence curve
hold on;
plot(F0_vec, T_low(F0_vec), '--'); % plot low-fluence regime expression
plot(F0_vec, T_high(F0_vec), '--'); % plot high-fluence regime expression
hold off;

xlim([0, 3*Fref]);
ylim([prop.Tg, 1.2*Tref]);

