clc;
clear all;
close all;

% Carregar o sinal de áudio
[y, Fs] = audioread("Viva la vida - coldplay.wav");
y = y(:, 1) + y(:, 2);

ymedio = mean(y);
y = y - ymedio;

% Especificações do filtro
a = 0.5; % Parâmetro dado
t_atraso = 0.5; % Atraso desejado em segundos

% Calcular o número de amostras para o atraso desejado
D = round(t_atraso * Fs);

% Construir a função de transferência
num = [1, zeros(1, D), a];
den = 1;

% Calcular a resposta em frequência usando freqz
N = 1024; 
[H, Freq] = freqz(num, den, N, Fs);

% Filtrar o sinal
y_filtrado = filter(num, den, y);

% Plotar a resposta em frequência e os sinais no domínio do tempo
figure;
plot(Freq, abs(H));
title('Resposta em Frequência');
xlabel('Frequência (Hz)');
ylabel('Magnitude');

figure;
subplot(2,1,1);
plot((0:length(y)-1)/Fs, y, 'b', 'LineWidth', 1.5);
title('Sinal Original - Domínio do Tempo');
xlabel('Tempo (s)');
ylabel('Amplitude');

subplot(2,1,2);
plot((0:length(y_filtrado)-1)/Fs, y_filtrado, 'r', 'LineWidth', 1.5);
title('Sinal com Eco - Domínio do Tempo');
xlabel('Tempo (s)');
ylabel('Amplitude');


% Calcular a transformada de Fourier do sinal original e filtrado
Y_original = 2 * fft(y);
Y_filtrado = 2 * fft(y_filtrado);

% Calcular a frequência correspondente para cada componente da transformada de Fourier
frequencias = linspace(0, Fs, length(Y_original));

% Plotar o espectro no domínio da frequência
figure;
subplot(2,1,1);
plot(frequencias, abs(Y_original), 'b', 'LineWidth', 1.5);
title('Espectro do Sinal original');
xlabel('Frequência (Hz)');
ylabel('Amplitude');
xlim([0 Fs/16]);

subplot(2,1,2);
plot(frequencias, abs(Y_filtrado), 'r', 'LineWidth', 1.5);
xlim([0 Fs/16]);
title('Espectro do Sinal com Eco');
xlabel('Frequência (Hz)');
ylabel('Amplitude');


