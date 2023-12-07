clc;
clear all;
close all;

[y, Fs] = audioread("Viva la vida - coldplay.wav");
y = y(:, 1) + y(:, 2);

ymedio = mean(y);

% Subtraindo a média de cada elemento do sinal
y = y - ymedio;

% Projeto do filtro FIR
Fc = 5000; % Frequência de corte(teste 50, 500, 5000)
N = 200; % Ordem do filtro (teste 50, 100, 200)
h = fir1(N + 1, Fc/(Fs/2));

% Resposta em Frequência do Filtro
freqz(h, 1, 1024, Fs);

% Aplicando o filtro FIR ao sinal original
y_filtrado = filter(h, 1, y);

%Dominio da Frequencia
Y_original = 2 * fft(y);
Y_filtrado = 2 * fft(y_filtrado);

%Espectros original e filtrado
figure;
plot(linspace(0, Fs, length(Y_original)), abs(Y_original), 'b', 'LineWidth', 1.5);
hold on;
plot(linspace(0, Fs, length(Y_filtrado)), abs(Y_filtrado), 'r', 'LineWidth', 1.5);
xlabel('Frequência (Hz)');
ylabel('Magnitude');
title('Comparação do Espectro de Magnitude do Sinal Original e Filtrado');
legend('Sinal Original', 'Sinal Filtrado');
xlim([0, Fs/2]);

% Vetor de tempo para o sinal filtrado
t_filtrado = linspace(0, length(y_filtrado)/Fs, length(y_filtrado));

%Plotando no domínio do tempo
figure;
plot(linspace(0, length(y)/Fs, length(y)), y, 'b', 'LineWidth', 1.5);
hold on;
plot(t_filtrado, y_filtrado, 'r', 'LineWidth', 1.5);
title("Comparação do Sinal Original e Filtrado no Dominio do tempo");
xlabel("t (s)");
ylabel("Amplitude");
legend('Sinal Original', 'Sinal Filtrado');


%audiowrite("Audio Filtrado em 5000 Hz.wav", y_filtrado, Fs);  

%soundsc(y, Fs)
%soundsc(y_filtrado, Fs)
