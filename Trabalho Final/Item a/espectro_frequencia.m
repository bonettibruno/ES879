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


% Dominio do tempo
t = linspace(0, length(y)/Fs, length(y));
figure;
subplot(2,1,1);
plot(t, y);
title("Domínio do tempo");
xlabel("t(s)");
ylabel("Amplitude");

% Dominio da Frequencia
% Ao pegar somente a parte positiva do sinal, requer que essa amplitude da metade
%do espectro seja multiplicada por 2 para representar a amplitude do sinal com
% precisão.
Y = 2 * fft(y);

% Calculando o vetor de frequências
frequencies = linspace(0, Fs, length(Y));

% Plotando o espectro de magnitudes
subplot(2,1,2);
plot(frequencies, abs(Y));
xlabel('Frequência (Hz)');
ylabel('Magnitude');
title('Espectro de Magnitudes do Sinal de Áudio');
xlim([0, Fs/2]);

% Encontrando picos no espectro
[peaks, locs] = findpeaks(abs(Y), frequencies);

% Identificar a frequência máxima
[maxPeak, maxIndex] = max(peaks);
f_max_espectro = locs(maxIndex);

% Mostrando a frequência máxima no console
disp(['Frequência máxima no espectro: ', num2str(f_max_espectro), ' Hz']);
