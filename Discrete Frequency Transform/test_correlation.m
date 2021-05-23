clc; clear; close all;

%%
fs = 100;       % sampling frequency
Ts = 1 / fs;    % sampling period
L  = 500;       % length of input signal
sample_t = linspace(0, Ts*L, L);

% normal probability distribution noise
noise1 = normrnd(0, 1, [1, L]);
noise2 = normrnd(0, 1, [1, L]);

% simulate signal
freq1 = 10;
freq2 = 100;
t = linspace(0, L, L);
sig1 = 10 * sin(2*pi*freq1*t*Ts) + noise1;
sig2 =  5 * sin(2*pi*freq2*t*Ts) + noise2;

figure(1);
plot(sample_t, sig1); hold on
plot(sample_t, sig2); hold off
grid on;
legend("sine wave 1", "sine wave 2")
xlabel("Time (s)");
ylabel("Amplitude");
title("sine wave with noise");

figure(2);
plot(sample_t, noise1); hold on
plot(sample_t, noise2); hold off
grid on;
legend("noise1", "noise2")
xlabel("Time (s)");
ylabel("Amplitude");
title("normal distribution noise");

%% Do correlation algorithm
N     = double(int32(L/2));
Rnn   = zeros([1, N]);
Rss   = zeros([1, N]);
Rn1n2 = zeros([1, N]);
Rns   = zeros([1, N]);
Rs1s2 = zeros([1, N]);

for i = 1 : N
    temp_nn   = 0;
    temp_ss   = 0;
    temp_n1n2 = 0;
    temp_ns   = 0;
    temp_s1s2 = 0;
    for j = 1 : N
        temp_nn   = temp_nn   + noise1(1,j+i) * noise1(1,j);
        temp_ss   = temp_ss   + sig1(1,j+i)   * sig1(1,j);
        temp_n1n2 = temp_n1n2 + noise1(1,j+i) * noise2(1,j);
        temp_ns   = temp_ns   + noise1(1,j+i) * sig1(1,j);
        temp_s1s2 = temp_s1s2 + sig1(1,j+i)   * sig2(1,j);
    end
    Rnn(1, i)   = temp_nn   / N;
    Rss(1, i)   = temp_ss   / N;
    Rn1n2(1, i) = temp_n1n2 / N;
    Rns(1, i)   = temp_ns   / N;
    Rs1s2(1, i) = temp_s1s2 / N;
end

Snn   = abs(fft(Rnn));
Sss   = abs(fft(Rss));
Sn1n2 = abs(fft(Rn1n2));
Sns   = abs(fft(Rns));
Ss1s2 = abs(fft(Rs1s2));

x_freq = linspace(0, fs/2, N/2);
x_time = linspace(0, Ts*N, N);

%%
figure(3);
subplot(2,1,1);
plot(x_time, Rnn);
grid on;
xlabel("Time (s)");
ylabel("Amplitude");
title("Circular correlation R_{nn}");

subplot(2,1,2);
plot(x_freq, Snn(1, 1:N/2));
grid on;
xlabel("Frequency (Hz)");
ylabel("Amplitude");
title("Circular correlation density spectrum S_{nn}");

%%
figure();
subplot(2,1,1);
plot(x_time, Rss);
grid on;
xlabel("Time (s)");
title("Circular correlation R_{ss}");

subplot(2,1,2);
plot(x_freq, Sss(1, 1:N/2));
grid on;
xlabel("Frequency (Hz)");
ylabel("Amplitude");
title("Circular correlation density spectrum S_{ss}");

%%
figure();
subplot(2,1,1);
plot(x_time, Rn1n2);
grid on;
xlabel("Time (s)");
title("Circular correlation R_{n1n2}");

subplot(2,1,2);
plot(x_freq, Sn1n2(1, 1:N/2));
grid on;
xlabel("Frequency (Hz)");
ylabel("Amplitude");
title("Circular correlation density spectrum S_{n1n2}");

%%
figure();
subplot(2,1,1);
plot(x_time, Rns);
grid on;
xlabel("Time (s)");
title("Circular correlation R_{ns}");

subplot(2,1,2);
plot(x_freq, Sns(1, 1:N/2));
grid on;
xlabel("Frequency (Hz)");
ylabel("Amplitude");
title("Circular correlation density spectrum S_{ns}");

%%
figure();
subplot(2,1,1);
plot(x_time, Rs1s2);
grid on;
xlabel("Time (s)");
title("Circular correlation R_{s1s2}");

subplot(2,1,2);
plot(x_freq, Ss1s2(1, 1:N/2));
grid on;
xlabel("Frequency (Hz)");
ylabel("Amplitude");
title("Circular correlation density spectrum S_{s1s2}");
