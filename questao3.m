close all
clear
% 3-Projete um filtro passa-altas com as seguintes
% especificações: FC1 = 3kHz; FC2 = 5kHz;
% atenução minima na faixa de passagem: -40dB

Fs = 44100;
Fc1 = 3000;
Fc2 = 5000;

wc1 = (Fc1/(Fs/2))*pi;
wc2 = (Fc2/(Fs/2))*pi;

wc = (wc1 + wc2)/2;

wt =(wc2 - wc1);

M = ceil(6.6*pi/wt);
%-------------------------------------------------
%Resposta ao impulso de filtro passa alta ideal
%-------------------------------------------------
alpha = (M-1)/2;
n = [0:1:(M-1)];
m = n - alpha + eps;
hd1 = sin(wc*m)./(pi*m);
hd2 = sin(pi*m)./(pi*m);
hd = hd1 - hd2;
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

[H,w]=freqz(h,a,f,Fs);

mag=abs(H);

subplot(2,2,3)
plot(f,mag);grid
title('Magnitude response of the filter')
ylabel('Magnitude')
xlabel('Frequency in Hz')
[H,w]=freqz(h,a,f,Fs);
mag=abs(H);

DB=20*log10(mag);
subplot(2,2,4)
plot(f,DB);grid MINOR
title('Magnitude response in dB')
ylabel('Magnitude in dB')
xlabel('Frequency in Hz')

%--------------------------------------------------------