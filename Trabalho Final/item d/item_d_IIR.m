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

% Projeto do filtro IIR (Butterworth)
Fc_b = 50; % Frequência de corte
N_b = 4;   % Ordem do filtro (ajuste conforme necessário:1,2,4)
[b, a] = butter(N_b, Fc_b/(Fs/2), 'low');

% Aplicar o filtro IIR ao sinal original
y_iir = filter(b, a, y);

%Dominio da Frequencia
Y_original = 2 * fft(y);
Y_iir = 2 * fft(y_iir);

% Plotar os espectros de magnitude do sinal original e do sinal filtrado
figure;
plot(linspace(0, Fs, length(Y_original)), abs(Y_original), 'b', 'LineWidth', 1.5);
hold on;
plot(linspace(0, Fs, length(Y_iir)), abs(Y_iir), 'r', 'LineWidth', 1.5);
xlabel('Frequência (Hz)');
ylabel('Magnitude');
title('Comparação do Espectro de Magnitude do Sinal Original e Filtrado (IIR)');
legend('Original', 'Filtrado (IIR)');
xlim([0, Fs/2]);

%soundsc(y, Fs)
soundsc(y_iir, Fs)
