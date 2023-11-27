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
title("Domínio do tempo");
xlabel("t(s)");
ylabel("Amplitude");

%Dominio da Frequencia
Y = fft(y);

% Calcule o vetor de frequências
frequencies = linspace(0, Fs, length(Y));

% Plote o espectro de magnitudes
subplot(2,1,2);
plot(frequencies, abs(Y));
xlabel('Frequência (Hz)');
ylabel('Magnitude');
title('Espectro de Magnitudes do Sinal de Áudio');
xlim([0, Fs/2]);

% Encontrar picos no espectro
[peaks, locs] = findpeaks(abs(Y), frequencies);

% Identificar a frequência máxima
[maxPeak, maxIndex] = max(peaks);
f_max_espectro = locs(maxIndex);

% Mostrar a frequência máxima no console
disp(['Frequência máxima no espectro: ', num2str(f_max_espectro), ' Hz']);
