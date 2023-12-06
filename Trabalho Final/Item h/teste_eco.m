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
t_atraso = 0.2; % Atraso desejado em segundos

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

% Plotar a resposta em frequência
figure;
subplot(2,1,1);
plot(Freq, abs(H));
title('Resposta em Frequência');
xlabel('Frequência (Hz)');
ylabel('Magnitude');

% Plotar o sinal original e o sinal filtrado
subplot(2,1,2);
plot((0:length(y)-1)/Fs, y);
hold on;
plot((0:length(y_filtrado)-1)/Fs, y_filtrado);
hold off;
title('Sinal Original e Sinal Filtrado');
xlabel('Tempo (s)');
ylabel('Amplitude');
legend('Original', 'Filtrado');

% Calcular a transformada de Fourier do sinal filtrado
Y = 2 * fft(y_filtrado);

% Calcular a frequência correspondente para cada componente da transformada de Fourier
frequencias = linspace(0, Fs, length(Y));

% Plotar o espectro
figure;
plot(frequencias, abs(Y));
xlim([0 Fs/2]);
title('Espectro do Sinal Filtrado');
xlabel('Frequência (Hz)');
ylabel('Amplitude');


%soundsc(y_filtrado, Fs);