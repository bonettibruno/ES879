clc;
clear all;
close all;

[y, Fs] = audioread("Viva la vida - coldplay.wav");
y = y(:, 1) + y(:, 2);

ymedio = mean(y);

y = y - ymedio;

% Projeto do filtro FIR
Fc = 500; 
N = 200; 
h = fir1(N + 1, Fc/(Fs/2));

y_filtrado = filter(h, 1, y);

y_filtrado_decimado = decimate(y_filtrado, 8);

y_decimado = decimate(y, 8);

% Vetor de tempo para o sinal decimado
t_decimado = linspace(0, length(y_decimado)/(Fs/8), length(y_decimado));

% Vetor de tempo para o sinal filtrado/decimado
t_filtrado_decimado = linspace(0, length(y_filtrado_decimado)/(Fs/8), length(y_filtrado_decimado));

% Dominio da Frequencia do Sinal Original Decimado
Y_decimado = 2 * fft(y_decimado);
frequencies_decimado = linspace(0, Fs/8, length(Y_decimado));

% Dominio da Frequencia do Sinal Filtrado Decimado
Y_filtrado_decimado = 2 * fft(y_filtrado_decimado);
frequencies_filtrado_decimado = linspace(0, Fs/8, length(Y_filtrado_decimado));

% Plot no domínio do tempo para o sinal decimado e o sinal filtrado/decimado
figure;
plot(t_decimado, y_decimado, 'b', 'LineWidth', 1.5);
hold on;
plot(t_filtrado_decimado, y_filtrado_decimado, 'r', 'LineWidth', 1.5);
title("Sinal Decimado e Sinal Filtrado/Decimado - Domínio do Tempo");
xlabel("t (s)");
ylabel("Amplitude");
legend('Sinal Decimado', 'Sinal Filtrado e Decimado');
xlim([0, length(y_decimado)/(Fs/8)]);

% Plot no domínio da frequência para o sinal decimado e o sinal filtrado/decimado
figure;
plot(frequencies_decimado(1:length(frequencies_decimado)/2), abs(Y_decimado(1:length(Y_decimado)/2)), 'b', 'LineWidth', 1.5);
hold on;
plot(frequencies_filtrado_decimado(1:length(frequencies_filtrado_decimado)/2), abs(Y_filtrado_decimado(1:length(Y_filtrado_decimado)/2)), 'r', 'LineWidth', 1.5);
xlabel("Frequência (Hz)");
ylabel("Magnitude");
title("Sinal Decimado e Sinal Filtrado/Decimado - Domínio da Frequência");
legend('Sinal Decimado', 'Sinal Filtrado e Decimado');
xlim([0, Fs/16]);

%soundsc(y_decimado, Fs/8)
%soundsc(y_filtrado_decimado, Fs/8)

%audiowrite("Áudio filtrado em 500 Hz e Decimado em 8.wav", y_filtrado_decimado, round(Fs/8));
