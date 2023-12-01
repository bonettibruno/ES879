clc;
clear all;
close all;

[y, Fs] = audioread("Viva la vida - coldplay.wav");
y = y(:, 1) + y(:, 2);

% Calculando a média do sinal
ymedio = mean(y);

% Subtraindo a média de cada elemento do sinal
y = y - ymedio;

%Dominio da Frequencia
Y = 2 * fft(y);

% Calcule o vetor de frequências
frequencies = linspace(0, Fs, length(Y));

% Encontre os picos no espectro de magnitude
[peaks, locations] = findpeaks(abs(Y), 'MinPeakHeight', 3000, 'MinPeakDistance', 100);

% Ordenando os picos em ordem decrescente
[sorted_peaks, sorted_indices] = sort(peaks, 'descend');

% Selecionando os 10 maiores picos
top_10_peaks = sorted_peaks(1:20);
top_10_locations = locations(sorted_indices(1:20));

% Exibindo as informações sobre os 10 maiores picos no terminal
disp('As 10 maiores frequências e magnitudes dos picos:');
disp('-------------------------------------------------');
disp('Frequência (Hz)   | Magnitude');
disp('------------------|-----------');
for i = 1:20
    disp([sprintf('%.4f', frequencies(top_10_locations(i))), '   ', sprintf('%.4f', top_10_peaks(i))]);
end

% Plote os 10 maiores picos no espectro
figure;
plot(frequencies, abs(Y));
hold on;
plot(frequencies(round(top_10_locations)), top_10_peaks, 'ro'); % marcando os 10 maiores picos com círculos vermelhos
xlabel('Frequência (Hz)');
ylabel('Magnitude');
title('Picos no espectro de magnitudes');
xlim([0, Fs/16]);
