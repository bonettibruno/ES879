clc;
clear all;
close all;

[y, Fs] = audioread("Viva la vida - coldplay.wav");
y = y(:, 1) + y(:, 2);

% Calculando a média do sinal
ymedio = mean(y);

y = y - ymedio;

%Interpolando com L = 4
L = 4;
y_superamostrado = interp(y, L);

t_superamostrado = linspace(0, length(y_superamostrado)/(Fs*L), length(y_superamostrado));

%Plotando no domínio do tempo para o sinal original e superamostrado
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

% Plotando os espectros original e superamostrado
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

%audiowrite("Audio interpolado em 4.wav", y_superamostrado, Fs*L);
