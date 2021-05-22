clc; clear all; close all;
addpath("D:\Project\SysID\System Modeling")
addpath("D:\Project\SysID\Discretization")

%% Transform the spring-mass-damper system to the state-space matrix form
DOF = 2;
m = ones(1, DOF) * 1;
b = ones(1, DOF) * 0.01;
k = ones(1, DOF) * 1;

[Ac, Bc, Cc, Dc] = Spring_Mass_Damper_System_ss(DOF, m, b, k)

%% Transform a continuous time state space to a discrete time state space
f = 2;
fs = 100;
Ts = 1 / fs;
[Ad, Bd, Cd, Dd] = css2dss(Ac, Bc, Cc, Dc, Ts)

sys = ss(Ac, Bc, Cc, Dc);
d_sys = c2d(sys, Ts);

figure(1)
bode(sys)

% figure(2)
% bode(sys, d_sys)

%%
L = 500;
x = linspace(0, (L / (fs/f)) * 2*pi, L);
u_1sin = zeros([DOF, L]);
u_2sin = zeros([DOF, L]);
u_1sin(1,:) = sin(x);
u_2sin(2,:) = sin(x);    

y_1sin = sinusoidal_response(Ad, Bd, Cd, Dd, u_1sin);
y_2sin = sinusoidal_response(Ad, Bd, Cd, Dd, u_2sin);

%%
figure(3)
subplot(2,1,1)
plot(u_1sin(1,:),'k'); hold on
plot(y_1sin(1,:),'b'); hold on
plot(y_1sin(2,:),'r'); hold off

subplot(2,1,2)
plot(u_2sin(2,:),'k'); hold on
plot(y_2sin(1,:),'b'); hold on
plot(y_2sin(2,:),'r'); hold off
