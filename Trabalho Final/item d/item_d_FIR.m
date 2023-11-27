clc;
clear all;
close all;

[y, Fs] = audioread("Viva la vida - coldplay.wav");
y = y(:, 1) + y(:, 2);

% Projeto do filtro FIR
Fc = 50; % Frequência de corte(teste 50,100,200)
N = 50; % Ordem do filtro (teste 50,100,200)
h = fir1(N, Fc/(Fs/2));

% Resposta em Frequência do Filtro
figure;
freqz(h, 1, 1024, Fs);

% Aplicar o filtro FIR ao sinal original
y_filtrado = filter(h, 1, y);

%Dominio da Frequencia
Y_original = fft(y);
Y_filtrado = fft(y_filtrado);

% Plote os espectros de magnitude do sinal original e do sinal filtrado
figure;
plot(linspace(0, Fs, length(Y_original)), abs(Y_original), 'b', 'LineWidth', 1.5);
hold on;
plot(linspace(0, Fs, length(Y_filtrado)), abs(Y_filtrado), 'r', 'LineWidth', 1.5);
xlabel('Frequência (Hz)');
ylabel('Magnitude');
title('Comparação do Espectro de Magnitude do Sinal Original e Filtrado');
legend('Original', 'Filtrado');
xlim([0, Fs/2]);

%soundsc(y, Fs)
soundsc(y_filtrado, Fs)
