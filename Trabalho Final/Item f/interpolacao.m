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

% Aumentar a taxa de amostragem por um fator de L = 4
L = 4;
y_superamostrado = interp(y, L);

t_superamostrado = linspace(0, length(y_superamostrado)/(Fs*L), length(y_superamostrado));

% Plot no domínio do tempo para o sinal original e superamostrado
figure;
subplot(2,1,1);
plot(linspace(0, length(y)/Fs, length(y)), y, 'b', 'LineWidth', 1.5);
title("Sinal Original - Domínio do Tempo");
xlabel("t (s)");
ylabel("Amplitude");
subplot(2,1,2);
plot(t_superamostrado, y_superamostrado, 'r', 'LineWidth', 1.5);
title("Sinal Interpolado - Domínio do Tempo");
xlabel("t (s)");
ylabel("Amplitude");


%Dominio da Frequencia para o Sinal Original
Y_original = 2 * fft(y);
frequencies_original = linspace(0, Fs, length(Y_original));

% Domínio da Frequência para o Sinal Superamostrado
Y_superamostrado = 2 * fft(y_superamostrado);
frequencies_superamostrado = linspace(0, Fs*L, length(Y_superamostrado));

% Plote os espectros de magnitude do sinal original e do sinal superamostrado
figure;
subplot(2,1,1);
plot(frequencies_original(1:length(frequencies_original)/2), abs(Y_original(1:length(Y_original)/2)), 'b', 'LineWidth', 1.5);
xlabel("Frequência (Hz)");
ylabel("Magnitude");
title("Sinal Original - Domínio da Frequência");
subplot(2,1,2);
plot(frequencies_superamostrado(1:length(frequencies_superamostrado)/2), abs(Y_superamostrado(1:length(Y_superamostrado)/2)), 'r', 'LineWidth', 1.5);
xlabel("Frequência (Hz)");
ylabel("Magnitude");
title("Sinal Interpolado - Domínio da Frequência");
xlim([0, Fs/2]);

figure;

plot(frequencies_original(1:length(frequencies_original)/2), abs(Y_original(1:length(Y_original)/2)), 'b', 'LineWidth', 1.5);
hold on;
plot(frequencies_superamostrado(1:length(frequencies_superamostrado)/2), abs(Y_superamostrado(1:length(Y_superamostrado)/2))/4, 'r', 'LineWidth', 1.5);
xlabel("Frequência (Hz)");
ylabel("Magnitude");
title("Sinal Original e Interpolado - Domínio da Frequência");
legend("Sinal Original", "Sinal Interpolado dividido por 4");
xlim([0, Fs/2]);

%soundsc(y, Fs)
%soundsc(y_superamostrado, Fs*L);
