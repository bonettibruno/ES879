clc;
clear all;
close all;

[y, Fs] = audioread("Viva la vida - coldplay.wav");
y = y(:, 1) + y(:, 2);

y_decimado = decimate(y, 8);

% Vetor de tempo para o sinal original
t_original = linspace(0, length(y)/Fs, length(y));

% Vetor de tempo para o sinal decimado
t_decimado = linspace(0, length(y_decimado)/(Fs/8), length(y_decimado));

% Plot no domínio do tempo
figure;
plot(t_original, y, 'b', 'LineWidth', 1.5);
hold on;
plot(t_decimado, y_decimado, 'r', 'LineWidth', 1.5);
hold off;
title("Sinal Original e Sinal Decimado - Domínio do Tempo");
xlabel("t (s)");
ylabel("Amplitude");
legend('Sinal Original', 'Sinal Decimado');

% Domínio da Frequência para o sinal original
Y_original = fft(y);
frequencies_original = linspace(0, Fs, length(Y_original));

% Domínio da Frequência para o sinal decimado
Y_decimado = fft(y_decimado);

%Para não haver perda de energia do sinal
Y_decimado = Y_decimado * 8;

frequencies_decimado = linspace(0, Fs/8, length(Y_decimado));

% Plot no domínio da frequência
figure;
plot(frequencies_original, abs(Y_original), 'b', 'LineWidth', 1.5);
hold on;
plot(frequencies_decimado, abs(Y_decimado), 'r', 'LineWidth', 1.5);
hold off;
title('Espectro de Magnitudes - Sinal Original e Sinal Decimado');
xlabel('Frequência (Hz)');
ylabel('Magnitude');
legend('Sinal Original', 'Sinal Decimado');
xlim([0, Fs/16]);

soundsc(y_decimado, Fs/8)
