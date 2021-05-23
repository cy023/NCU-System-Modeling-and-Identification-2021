clc; clear all; close all;

%%
fs = 0.5;
Ts = 1 / fs;
L  = 1000;

sin_period = [10, 10.25, 10.5, 100, 100.25, 100.5];
sin_freq   = 1 ./ sin_period

u     = zeros([1, L]);
fft_u = zeros([size(sin_period, 2), L]);

for i = 1 : size(sin_period, 2)
    x = linspace(0, (L / (fs/sin_freq(i))) * 2*pi, L);
    u(1, :) = 5 * sin(x) + rand([1, L]);
    fft_u(i, :) = abs(fft(u(1, :)));
end

figure(1);
hold on
grid on
xlim([0, max(sin_freq) + 0.05]);
x_freq = linspace(0, fs/2, L/2);
for i = 1 : size(sin_period, 2)
    plot(x_freq, fft_u(i, 1:L/2));
end
legend("Frequency : 1 / " + num2str(sin_period(1)), ...
        "Frequency : 1 / " + num2str(sin_period(2)), ...
        "Frequency : 1 / " + num2str(sin_period(3)), ...
        "Frequency : 1 / " + num2str(sin_period(4)), ...
        "Frequency : 1 / " + num2str(sin_period(5)), ...
        "Frequency : 1 / " + num2str(sin_period(6)));
xlabel("Frequency (Hz)");
ylabel("Amplitude");
