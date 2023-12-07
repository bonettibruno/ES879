clc;
clear all;
close all;

[y, Fs] = audioread("Viva la vida - coldplay.wav");
y = y(:, 1) + y(:, 2);

ymedio = mean(y);

% Subtraindo a média de cada elemento do sinal
y = y - ymedio;

% Função usada para decimar
y_decimado = decimate(y, 8);

t = linspace(0, length(y_decimado)/(Fs/8), length(y_decimado));

%Plotando
figure;
subplot(2,1,1);
plot(t, y_decimado);
title("Domínio do tempo");
xlabel("t(s)");
ylabel("Amplitude");

%Dominio da Frequencia
Y = 2 * fft(y_decimado);

frequencias = linspace(0, Fs/8, length(Y));

% Plote o espectro de magnitudes
subplot(2,1,2);
plot(frequencias, abs(Y));
xlabel('Frequência (Hz)');
ylabel('Magnitude');
title('Espectro de Magnitudes do Sinal de Áudio');
xlim([0, Fs/16]);

%audiowrite("Audio Decimado por 8.wav", y_decimado, round(Fs/8)); 

%soundsc(y, Fs)
%soundsc(y_decimado, Fs/8)
