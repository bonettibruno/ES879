% Parâmetros da função de transferência H(z)
a = 0.5;
D = 2;

% Encontre a resposta ao impulso h[n] pela transformada inversa de Z
n_values = 0:10;  % Escolha um intervalo de valores de n para calcular
hz = (z^D + a) / z^D;  % Sua função de transferência
hn = iztrans(hz);  % Transformada inversa de Z

% Substitua os valores de n para obter a resposta ao impulso h[n]
hn_values = subs(hn, n, n_values);

% Converta a expressão simbólica para uma função numérica
h_func = matlabFunction(hn_values);

% Calcule os valores de h[n]
hn_numeric = h_func();

% Plotando h[n]
stem(n_values, hn_numeric, 'o');
xlim([0 10]);
title('Resposta ao Impulso h[n], para a = 0.5 e D = 2');
xlabel('n');
ylabel('h[n]');

