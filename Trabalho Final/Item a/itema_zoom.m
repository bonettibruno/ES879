clc;
clear all;
close all;

[y, Fs] = audioread("Viva la vida - coldplay.wav");
y = y(:, 1) + y(:, 2);

ymedio = mean(y);

% Subtraindo a média de cada elemento do sinal
y = y - ymedio;

%Dominio da Frequencia
Y = 2 * fft(y);

% Calcule o vetor de frequências
frequencias = linspace(0, Fs, length(Y));

% Picos de magnitude em ordem decrescente
[peaks, locations] = findpeaks(abs(Y), 'MinPeakHeight', 3000, 'MinPeakDistance', 100);
[sorted_peaks, sorted_indices] = sort(peaks, 'descend');

% Selecionando os 20 maiores picos, pois 10 são espelhados
top_20_picos = sorted_peaks(1:20);
top_20_localizacao = locations(sorted_indices(1:20));

for i = 1:20
    disp([sprintf('%.4f', frequencias(top_20_localizacao(i))), '   ', sprintf('%.4f', top_20_picos(i))]);
end

% Plotando
figure;
plot(frequencias, abs(Y));
hold on;
plot(frequencias(round(top_20_localizacao)), top_20_picos, 'ro');
xlabel('Frequência (Hz)');
ylabel('Magnitude');
title('Picos no espectro de magnitudes');
xlim([0, Fs/16]);
