clc; clear all; close all;

%%
f  = 2;         % input signal frequency
fs = 100;       % sampling frequency
Ts = 1 / fs;    % sampling period
L = 500;        % length of input signal

sample_t = linspace(0, 2*pi * Ts*L*f, L);
noise1 = rand([1, L]);
noise2 = rand([1, L]);
input_signal  = 2 * sin(sample_t) + noise1;
output_signal = 1 * sin(sample_t) + noise2;

figure(1);
plot(sample_t,  input_signal, 'b'); hold on
plot(sample_t, output_signal, 'r'); hold off
legend("input x", "output y");
title("raw input and output");
xlabel("time (s)");
ylabel("Amplitude");

%%
R_xy1 = CircularCorrelation(input_signal, output_signal);

figure(2);
plot(sample_t(1:L/2),         R_xy1(1:L/2), 'k'); hold on
plot(sample_t(1:L/2),  input_signal(1:L/2), 'b'); hold on
plot(sample_t(1:L/2), output_signal(1:L/2), 'r'); hold off
legend("correlation R_{xy}1", "input x", "output y");
title("raw input and output");
xlabel("time (s)");
ylabel("Amplitude");
