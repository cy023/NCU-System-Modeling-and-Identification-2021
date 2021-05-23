clc; clear; close all;
addpath("D:\Project\SysID\System Modeling")
addpath("D:\Project\SysID\Discretization")

%% Transform the spring-mass-damper system to the state-space matrix form
DOF = 2;
m = ones(1, DOF) * 1;
b = ones(1, DOF) * 0.1;
k = ones(1, DOF) * 1;

[Ac, Bc, Cc, Dc] = Spring_Mass_Damper_System_ss(DOF, m, b, k);

%% Transform a continuous time state space to a discrete time state space
Ts = 1
[Ad, Bd, Cd, Dd] = css2dss(Ac, Bc, Cc, Dc, Ts);

%%
u_rand = rand([2, 1000]) * 10;
y_rand = responseWithNoise(Ad, Bd, Cd, Dd, u_rand);

%%
figure(1)
subplot(2,1,1)
plot(u_rand(1,:)); hold on
plot(u_rand(2,:)); hold off
title('u\_rand')

subplot(2,1,2)
plot(y_rand(1,:)); hold on
plot(y_rand(2,:)); hold off
title('y\_rand')
