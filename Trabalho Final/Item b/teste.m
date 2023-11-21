load train
soundsc(y,Fs)
Fs
figure
z = fft(y); w = ((1:length(y))-1)*Fs/length(y);
plot(w,abs(z))
