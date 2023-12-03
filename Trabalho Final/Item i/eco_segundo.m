clc;
clear all;
close all;

% Carregar o sinal de áudio
[y, Fs] = audioread("Viva la vida - coldplay.wav");
y = y(:, 1) + y(:, 2);

% Especificações do filtro
a = 0.5; % Parâmetro dado
t_atraso = 0.025; % Atraso desejado em segundos

% Calcular o número de amostras para o atraso desejado
D = round(t_atraso * Fs);

% Construir a função de transferência
num = [1, zeros(1, D), a];
den = 1;

% Calcular a resposta em frequência usando freqz
N = 8192; % Aumente o número de pontos de frequência
[H, Freq] = freqz(num, den, N, Fs);

% Filtrar o sinal
y_filtrado = filter(num, den, y);

soundsc(y_filtrado, Fs);