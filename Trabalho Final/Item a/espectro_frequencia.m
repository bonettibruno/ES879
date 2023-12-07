clc;
clear all;
close all;

[y, Fs] = audioread("Viva la vida - coldplay.wav");
y = y(:, 1) + y(:, 2);

ymedio = mean(y);

% Subtraindo a média de cada elemento do sinal
y = y - ymedio;


% Dominio do tempo
t = linspace(0, length(y)/Fs, length(y));
figure;
subplot(2,1,1);
plot(t, y);
title("Domínio do tempo");
xlabel("t(s)");
ylabel("Amplitude");

% Dominio da Frequencia
Y = 2 * fft(y);

frequencias = linspace(0, Fs, length(Y));

subplot(2,1,2);
plot(frequencias, abs(Y));
xlabel('Frequência (Hz)');
ylabel('Magnitude');
title('Espectro de Magnitudes do Sinal de Áudio');
xlim([0, Fs/2]);
