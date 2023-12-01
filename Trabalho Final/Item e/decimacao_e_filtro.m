clc;
clear all;
close all;

[y, Fs] = audioread("Viva la vida - coldplay.wav");
y = y(:, 1) + y(:, 2);

% Calculando a média do sinal
ymedio = mean(y);

y = y - ymedio;

% Projeto do filtro FIR
Fc = 500; % Frequência de corte (teste 50, 500, 5000)
N = 100; % Ordem do filtro (teste 50, 100, 200)
h = fir1(N + 1, Fc/(Fs/2));

% Aplicar o filtro FIR ao sinal original
y_filtrado = filter(h, 1, y);

%Dominio da Frequencia do Sinal Original
Y_original = 2 * fft(y);
frequencies_original = linspace(0, Fs, length(Y_original));

% Vetor de tempo para o sinal filtrado
t_filtrado = linspace(0, length(y_filtrado)/Fs, length(y_filtrado));

% Reduzindo a taxa de amostragem do sinal filtrado
y_filtrado_decimado = decimate(y_filtrado, 8);
t_decimado = linspace(0, length(y_filtrado_decimado)/(Fs/8), length(y_filtrado_decimado));

% Plot no domínio do tempo para o sinal original e o sinal filtrado
figure;

plot(linspace(0, length(y)/Fs, length(y)), y, 'b', 'LineWidth', 1.5);
hold on;
plot(t_decimado, y_filtrado_decimado, 'r', 'LineWidth', 1.5);
title("Sinal Original e Filtrado/Decimado - Domínio do Tempo");
xlabel("t (s)");
ylabel("Amplitude");
legend('Sinal Original', 'Sinal Decimado');

%Dominio da Frequencia do Sinal Filtrado Decimado
Y_filtrado_decimado = 2 * fft(y_filtrado_decimado);
frequencies_filtrado_decimado = linspace(0, Fs/8, length(Y_filtrado_decimado));

% Plot no domínio da frequência para o sinal original e o sinal filtrado decimado
figure;
plot(frequencies_original(1:length(frequencies_original)/2), abs(Y_original(1:length(Y_original)/2)), 'b', 'LineWidth', 1.5);
hold on;
plot(frequencies_filtrado_decimado(1:length(frequencies_filtrado_decimado)/2), abs(Y_filtrado_decimado(1:length(Y_filtrado_decimado)/2)), 'r', 'LineWidth', 1.5);
xlabel("Frequência (Hz)");
ylabel("Magnitude");
title("Sinal Original e Sinal Filtrado/Decimado - Domínio da Frequência");
legend('Sinal Original', 'Sinal Filtrado Decimado');
xlim([0, Fs/16]);

soundsc(y_filtrado_decimado, Fs/8)
