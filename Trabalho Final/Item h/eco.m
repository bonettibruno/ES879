clc;
clear all;
close all;

% Carregar o sinal de áudio
[y, Fs] = audioread("Viva la vida - coldplay.wav");
y = y(:, 1) + y(:, 2);

% Parte h - Resposta em Frequência e Sinal Após Filtro
a = 0.5;  % valor fornecido
D = round(0.5 * Fs);  % atraso de 0,5 segundos em termos de amostras

% Criar a resposta ao impulso
impulse_response = [1, zeros(1, D-1), a];

% Filtrar o sinal original
y_filtered = filter(impulse_response, 1, y);

N = length(y);

% Calcular a resposta em frequência do filtro
[Hz, freq] = freqz(impulse_response, 1, N, Fs);

% Calcular a FFT do sinal filtrado
Y_ECO = 2 * fft(y_filtered, N);
Y_ECO_amp = abs(Y_ECO);

% Gráficos
figure;
subplot(2, 1, 1);
freqz(impulse_response, 1, N, Fs);
title('Resposta em Frequência do filtro');
xlabel('Frequência (Hz)');
ylabel('Magnitude');

% Espectro em Frequência do Sinal Filtrado
subplot(2,1,2);
plot(freq(1:N/2), Y_ECO_amp(1:N/2));
xlim([0 Fs/2]);
xlabel('Frequência (Hz)');
ylabel('Amplitude');
title('Sinal após passar pelo filtro de eco - Domínio da Frequência');

% Sinal Original e Sinal Após Filtro
figure;
t = (0:N-1)/Fs;
plot(t, y, 'b', t, y_filtered, 'r');
title('Sinal Original e Sinal Após Filtro de eco - Domínio do tempo');
xlabel('Tempo (s)');
ylabel('Amplitude');
legend('Sinal Original', 'Sinal com eco');

% Reproduzir o sinal filtrado
% sound(y_filtered, Fs);
