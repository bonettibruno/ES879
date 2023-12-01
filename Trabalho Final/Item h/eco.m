clc;
clear all;
close all;

[y, Fs] = audioread("Viva la vida - coldplay.wav");
y = y(:, 1) + y(:, 2);

% Parâmetros do Filtro de Eco
a = 5; % Ganho do eco

% Escolha de D para atraso de 0,5s
Fs = 44100; % Exemplo de frequência de amostragem
D = round(0.5 * Fs); % Atraso de 0,5s

% Função de Transferência
numerator = [1, zeros(1, D), a];
denominator = 1;

% Resposta em Frequência
freq_response = freqz(numerator, denominator, 1024, Fs);

% Plote a Resposta em Frequência
figure;
subplot(2,1,1);
plot(linspace(0, Fs/2, length(freq_response)), 20*log10(abs(freq_response)), 'b', 'LineWidth', 1.5);
title('Resposta em Frequência do Filtro de Eco');
xlabel('Frequência (Hz)');
ylabel('Magnitude (dB)');

% Aplique o filtro de eco ao sinal original
y_eco = filter(numerator, denominator, y);

% Plote o sinal após passar pelo filtro de eco
subplot(2,1,2);
plot(linspace(0, length(y_eco)/Fs, length(y_eco)), y_eco, 'r', 'LineWidth', 1.5);
title('Sinal Após Filtro de Eco');
xlabel('Tempo (s)');
ylabel('Amplitude');

% Reproduza o sinal após passar pelo filtro de eco
soundsc(y_eco, Fs);
