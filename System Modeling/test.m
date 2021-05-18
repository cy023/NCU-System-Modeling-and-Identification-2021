clear all; clc;

% Determine the model
DOF = 3;
m = ones(1, DOF) * 50;
b = ones(1, DOF) * 10;
k = ones(1, DOF) * 20000;

[Ac, Bc, Cc, Dc] = Spring_Mass_Damper_System_ss(DOF, m, b, k)