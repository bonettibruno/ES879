%Parâmetros da função de transferência H(z)
a = 0.5;
D = 2;

syms z n;
n_values = 0:10;  
hz = (z^D + a) / z^D;  
hn = iztrans(hz);  % Transformada inversa de Z

hn_values = subs(hn, n, n_values);

h_func = matlabFunction(hn_values);

hn_numeric = h_func();

%Plotando h[n]
stem(n_values, hn_numeric, 'o');
xlim([0 10]);
title('Resposta ao Impulso h[n], para a = 0.5 e D = 2');
xlabel('n');
ylabel('h[n]');

