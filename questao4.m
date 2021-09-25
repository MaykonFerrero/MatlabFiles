close all
clear
% 4- Projete um filtro passa-faixas com as seguintes
% especificações: FC1 = 2kHz; FC2 = 6kHz;
% atenução minima na faixa de passagem: -50dB

Fs = 44100;
Fc0 = 1000;
Fc1 = 2000;
Fc2 = 5000;
Fc3 = 6000;

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