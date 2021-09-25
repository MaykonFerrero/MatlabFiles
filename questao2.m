close all
clear
%--------------------------------------------------------
% 2- Compare a atenuação mínima na faixa de passagem
%de cada uma das janelas abaixo para um Filtro passa-baixas
%com as seguintes especificações: Fc1 = 4000Hz, Fc2 = 5000Hz
%Fs = 44100Hz
% a) Hamming; M = ceil(6.6*pi/wt); b = hamming(M); atenuação: -52 dB
% b) Retangular; M = ceil(1.8*pi/wt); b = boxcar(M); atenuação: -20 dB
% c) Hanning; M = ceil(6.2*pi/wt); b = hanning(M); atenuação: -45 dB
% d) Barlett; M = ceil(6.1*pi/wt); b = triang(M); atenuação: -27 dB
% e) Blackman; M = ceil(11*pi/wt); b = blackman(M); atenuação: -75 dB
% Exibir os gráficos para comparação
%--------------------------------------------------------
Fs = 44100;

Fc1 = 4000;
Fc2 = 5000;

wc1 = (Fc1/(Fs/2))*pi;
wc2 = (Fc2/(Fs/2))*pi;

wc = (wc1 + wc2)/2;

wt =(wc2 - wc1);

Mm = [ceil(6.6*pi/wt) ceil(1.8*pi/wt) ceil(6.2*pi/wt) ceil(6.1*pi/wt) ceil(11*pi/wt)];

%-------------------------------------------------
%Resposta ao impulso de filtro passa baixas ideal
%-------------------------------------------------
for i = 1:length(Mm)
M = Mm(i);
alpha = (M-1)/2;
n = [0:1:(M-1)];
m = n - alpha + eps;
hd = sin(wc*m)./(pi*m);

figure
subplot(2,2,1)
plot(m,hd);
%-------------------------------------------------
switch i
    case 1
        b = hamming(M);   %(a)
    case 2
        b = boxcar(M);    %(b)
    case 3
        b = hanning(M);   %(c)
    case 4
        b = triang(M);    %(d)
    case 5
        b = blackman(M);  %(e)
end

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
end
