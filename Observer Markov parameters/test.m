clc; clear; close all;
addpath("D:\Project\SysID\System Modeling")
addpath("D:\Project\SysID\Discretization")
addpath("D:\Project\SysID\Markov parameters")

%% Transform the spring-mass-damper system to the state-space matrix form
DOF = 2;
m = ones(1, DOF) * 1;
b = ones(1, DOF) * 0.1;
k = ones(1, DOF) * 1;

[Ac, Bc, Cc, Dc] = Spring_Mass_Damper_System_ss(DOF, m, b, k)

%% Transform a continuous time state space to a discrete time state space
Ts = 1
[Ad, Bd, Cd, Dd] = css2dss(Ac, Bc, Cc, Dc, Ts)

%% Observer Model with deadbeat observer gain
u_impulse = zeros(DOF,100);
u_impulse(:,1) = 1;

y_impulse     = StateSpaceModel_response(Ad, Bd, Cd, Dd, u_impulse);
y_impulse_bar = StateSpaceObserverModel_response(Ad, Bd, Cd, Dd, u_impulse);

%% plot the response
figure(1)
subplot(3,1,1)
plot(u_impulse(1,:)); hold on
plot(u_impulse(2,:)); hold off
title('impluse input')

subplot(3,1,2)
plot(y_impulse(1,:)); hold on
plot(y_impulse(2,:)); hold off
title('impluse response')

subplot(3,1,3)
plot(y_impulse_bar(1,:)); hold on
plot(y_impulse_bar(2,:)); hold off
title('impluse response with deadbeat observer gain')


%% built-in function
sys = ss(Ac, Bc, Cc, Dc);
d_sys = c2d(sys, Ts);

figure(2);
impulse(d_sys);



