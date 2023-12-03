clc;
clear all;
close all;

[y, Fs] = audioread("Viva la vida - coldplay.wav");
y = y(:, 1) + y(:, 2);

% Calculando a média do sinal
ymedio = mean(y);

% Subtraindo a média de cada elemento do sinal
% Pois: "Se a média do sinal não for zero, irá aparecer uma componente na frequência
% 0, correspondente ao ganho estático"
y = y - ymedio;

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
Y_original = 2 * fft(y);
frequencies_original = linspace(0, Fs, length(Y_original));

% Domínio da Frequência para o sinal decimado
Y_decimado = 2 * fft(y_decimado);

frequencies_decimado = linspace(0, Fs/8, length(Y_decimado));

% Plot no domínio da frequência
figure;

plot(frequencies_original(1:length(frequencies_original)/2), abs(Y_original(1:length(Y_original)/2)), 'b', 'LineWidth', 1.5);
hold on;
plot(frequencies_decimado(1:length(frequencies_decimado)/2), abs(Y_decimado(1:length(Y_decimado)/2)), 'r', 'LineWidth', 1.5);
title("Sinal Original e Sinal Decimado - Domínio do Tempo");
xlabel("Frequência (Hz)");
ylabel("Amplitude");
xlim([0, Fs/16]);
legend('Sinal Original', 'Sinal Decimado');


% Aplicando fator de correção para que a magnitude do sinal decimado,
% fique igual à do sinal original, para não haver perda de energia

Y_decimado = Y_decimado * 8;

figure;

plot(frequencies_original(1:length(frequencies_original)/2), abs(Y_original(1:length(Y_original)/2)), 'b', 'LineWidth', 1.5);
hold on;
plot(frequencies_decimado(1:length(frequencies_decimado)/2), abs(Y_decimado(1:length(Y_decimado)/2)), 'r', 'LineWidth', 1.5);
title("Sinal Original e Sinal Decimado - Domínio do Tempo");
xlabel("Frequência (Hz)");
ylabel("Amplitude");
xlim([0, Fs/16]);
legend('Sinal Original', 'Sinal Decimado');

%soundsc(y, Fs)
%soundsc(y_decimado, Fs/8)
