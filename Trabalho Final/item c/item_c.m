clc;
clear all;
close all;

[y, Fs] = audioread("Viva la vida - coldplay.wav");
y = y(:, 1) + y(:, 2);

% Projeto do filtro FIR
Fc = 85; % Frequência de corte
N = 500; % Ordem do filtro 
h = fir1(N, Fc/(Fs/2));

% Resposta em Frequência do Filtro
figure;
freqz(h, 1, 1024, Fs);

% Aplicar o filtro FIR ao sinal original
y_filtrado = filter(h, 1, y);

%Dominio da Frequencia
Y_original = fft(y);
Y_filtrado = fft(y_filtrado);

% Espectro de Magnitude do Sinal Original
figure;
plot(linspace(0, Fs, length(Y_original)), abs(Y_original));
xlabel('Frequência (Hz)');
ylabel('Magnitude');
title('Espectro de Magnitude do Sinal Original');

% Espectro de Magnitude do Sinal Filtrado
figure;
plot(linspace(0, Fs, length(Y_filtrado)), abs(Y_filtrado), 'r');
xlabel('Frequência (Hz)');
ylabel('Magnitude');
title('Espectro de Magnitude do Sinal Filtrado');

%soundsc(y, Fs)
soundsc(y_filtrado, Fs)
