close all
clear
% 5- Projete um filtro  digital para elimanar o ruido do arquivo de
% audio denominado som_ruido.wav

[x,Fs] = audioread('som_ruido.wav');
X = fft(x);
xf = -Fs/2:(Fs/length(x)):(Fs/2-(Fs/length(x)));
plot(xf,abs(X));

Fs = 44100;

Fc0 = 8000;
Fc1 = 9000;
Fc2 = 11000;
Fc3 = 12000;

wc0 = (Fc0/(Fs/2))*pi;
wc1 = (Fc1/(Fs/2))*pi;
wc2 = (Fc2/(Fs/2))*pi;
wc3 = (Fc3/(Fs/2))*pi;

wca = (wc0 + wc1)/2;
wcb = (wc2 + wc3)/2;

wt =(wc1 - wc0);

M = ceil(12*pi/wt);
%-------------------------------------------------
%Resposta ao impulso de filtro rejeita faixas ideal
%-------------------------------------------------
alpha = (M-1)/2;
n = [0:1:(M-1)];
m = n - alpha + eps;
hd = sin(pi*m)./(pi*m) - sin(wcb*m)./(pi*m) - sin(wca*m)./(pi*m);
figure
subplot(2,2,1)
plot(m,hd);
%-------------------------------------------------
b = hamming(M);
h = b.*hd';

subplot(2,2,2)
plot(m,h');
%-------------------------------------------------
a=1;
f=0:(Fs/2)-1;

[H,w]=freqz(h,a,xf,Fs);

mag=abs(H);

subplot(2,2,3)
plot(xf,mag);grid
title('Magnitude response of the filter')
ylabel('Magnitude')
xlabel('Frequency in Hz')


DB=20*log10(mag);
subplot(2,2,4)
plot(xf,DB);grid MINOR
title('Magnitude response in dB')
ylabel('Magnitude in dB')
xlabel('Frequency in Hz')
%--------------------------------------------------------

M = X .* H.';
m = ifft(M);
figure
plot(xf,abs(M));

audiowrite('som_ruidoFILT.wav',m,Fs);
