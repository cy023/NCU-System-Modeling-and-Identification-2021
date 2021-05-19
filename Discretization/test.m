clear all; clc;
addpath("D:\Project\SysID\System Modeling")

%% Transform the spring-mass-damper system to the state-space matrix form
DOF = 2;
m = ones(1, DOF) * 50;
b = ones(1, DOF) * 10;
k = ones(1, DOF) * 20000;

[Ac, Bc, Cc, Dc] = Spring_Mass_Damper_System_ss(DOF, m, b, k)

%% Transform a continuous time state space to a discrete time state space
Ts = 1
[Ad, Bd, Cd, Dd] = css2dss(Ac, Bc, Cc, Dc, Ts)

% built-in function
sys = ss(Ac, Bc, Cc, Dc)
d_sys = c2d(sys, Ts)



