clc; clear all; close all;
addpath("D:\Project\SysID\System Modeling")
addpath("D:\Project\SysID\Discretization")
addpath("D:\Project\SysID\Markov parameters")

%% Transform the spring-mass-damper system to the state-space matrix form
DOF = 2;
m = ones(1, DOF) * 1;
b = ones(1, DOF) * 0.1;
k = ones(1, DOF) * 1;

[Ac, Bc, Cc, Dc] = Spring_Mass_Damper_System_ss(DOF, m, b, k);

%% Transform a continuous time state space to a discrete time state space
fs = 1
Ts = 1 / fs
[Ad, Bd, Cd, Dd] = css2dss(Ac, Bc, Cc, Dc, Ts);

%% 
L = 200
u_impulse = zeros(DOF, L);
u_impulse(:,1) = 1;

y_impulse = response(Ad, Bd, Cd, Dd, u_impulse);

%% In Time Domain
t = linspace(0, L*Ts, L);
figure(1);
title("Weighted sequence in time domain");
plot(t, y_impulse(1, :)); hold on
plot(t, y_impulse(2, :)); hold off
legend("y\_impulse(1)", "y\_impulse(2)");
xlabel("Time(s)");
ylabel("Amplitude");

%% DFT
Y1_fft = abs(fft(y_impulse(1,:)));
Y2_fft = abs(fft(y_impulse(2,:)));
Y_am1 = Y1_fft(1, 1:L/2);
Y_am2 = Y2_fft(1, 1:L/2);

figure(2);
freq = linspace(0, fs/2, L/2);
title("Weighted sequence after FFT");
plot(freq, Y_am1); hold on
plot(freq, Y_am2); hold off
xlabel("Frequency (Hz)");
ylabel("Amplitude");
legend("Y1\_fft", "Y2\_fft");