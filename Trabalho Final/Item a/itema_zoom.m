clc;
clear all;
close all;

[y, Fs] = audioread("Viva la vida - coldplay.wav");
y = y(:, 1) + y(:, 2);

%Dominio da Frequencia
Y = fft(y);

% Calcule o vetor de frequências
frequencies = linspace(0, Fs, length(Y));

% Encontre os picos no espectro de magnitude
[peaks, locations] = findpeaks(abs(Y), 'MinPeakHeight', 3000, 'MinPeakDistance', 100);

% Exiba as informações sobre os picos significativos no terminal
disp('Frequências e magnitudes dos picos significativos:');
disp('-------------------------------------------------');
disp('Frequência (Hz)   | Magnitude');
disp('------------------|-----------');
for i = 1:length(locations)
    disp([sprintf('%.4f', frequencies(locations(i))), '   ', sprintf('%.4f', peaks(i))]);
end

% Plote os picos no espectro
figure;
plot(frequencies, abs(Y));
hold on;
plot(frequencies(round(locations)), peaks, 'ro'); % marcando os picos significativos com círculos vermelhos
xlabel('Frequência (Hz)');
ylabel('Magnitude');
title('Espectro de magnitudes do sinal de áudio de 0 a Fs/16');
xlim([0, Fs/16]);
