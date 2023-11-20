clc;
clear all;
close all;

[y, Fs] = audioread("Viva la vida - coldplay.wav");
y = y(:, 1) + y(:, 2);

%Dominio do tempo
t = linspace(0, length(y)/Fs, length(y));
figure;
subplot(2,1,1);
plot(t, y);
title("Dom�nio do tempo");
xlabel("t(s)");
ylabel("Amplitude");

%Dominio da Frequencia
Y = fft(y);

% Calcule o vetor de frequ�ncias
frequencies = linspace(0, Fs, length(Y));

% Plote o espectro de magnitudes
subplot(2,1,2);
plot(frequencies, abs(Y));
xlabel('Frequ�ncia (Hz)');
ylabel('Magnitude');
title('Espectro de Magnitudes do Sinal de �udio');
xlim([0, Fs]);
