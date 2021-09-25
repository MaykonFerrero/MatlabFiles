close all
clear
% 6- Projete um filtro digital para eliminar o ruido do
% arquivo de áudio denominado audio_09.wav

[x,Fs] = audioread('audio_09.wav');
X = fft(x); %Transformada
X = fftshift(X); %Desloca transformada para o centro
xf = -Fs/2:(Fs/length(x)):(Fs/2-(Fs/length(x))); % Construção do eixo x
plot(xf,abs(X));

Fc0 = 170;
Fc1 = 470;
Fc2 = 5000;
Fc3 = 5300;

wc0 = (Fc0/(Fs/2))*pi;
wc1 = (Fc1/(Fs/2))*pi;
wc2 = (Fc2/(Fs/2))*pi;
wc3 = (Fc3/(Fs/2))*pi;

wca = (wc0 + wc1)/2;
wcb = (wc2 + wc3)/2;

wt =(wc1 - wc0);

M = ceil(12*pi/wt);
%-------------------------------------------------
%Resposta ao impulso de filtro passa faixas ideal
%-------------------------------------------------
alpha = (M-1)/2;
n = [0:1:(M-1)];
m = n - alpha + eps;
hd = sin(wcb*m)./(pi*m) - sin(wca*m)./(pi*m);
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
figure
plot(xf,abs(M));
M = fftshift(M);
m = ifft(M);


audiowrite('audio_09FILT.wav',m,Fs);
