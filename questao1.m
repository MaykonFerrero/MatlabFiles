close all
clear
%--------------------------------------------------------
% 1- Anote os valores de M para cada uma das frequências de corte
% abaixo utilizando a janela de Hamming:
% Fc1 = 3500 Hz; Fc2 = 5000 Hz; |M = 98 | 
% Fc1 = 3800 Hz; Fc2 = 5000 Hz; |M = 122|
% Fc1 = 4200 Hz; Fc2 = 5000 Hz; |M = 182|
% Fc1 = 4500 Hz; Fc2 = 5000 Hz; |M = 292|
% Qual a relação entre o valor de M e a faixa de passagem?
% R: o valor de M e a faixa de passagem são inversamente proporcionais, 
% pois quanto menor a faixa de
% passagem, mais amostras serão necessárias para formar o filtro;
% Exibir as respostas em frequência para comparação
%--------------------------------------------------------

Fs=44100;

FC1 = [3500 3800 4200 4500];
Fc2 = 5000;

for Fc1 = FC1
    
wc1 = (Fc1/(Fs/2))*pi;
wc2 = (Fc2/(Fs/2))*pi;

wc = (wc1 + wc2)/2;

wt =(wc2 - wc1);

M = ceil(6.6*pi/wt);
%-------------------------------------------------
%Resposta ao impulso de filtro passa baixas ideal
%-------------------------------------------------
alpha = (M-1)/2;
n = [0:1:(M-1)]; 
m = n - alpha + eps; % eixo das amostras
hd = sin(wc*m)./(pi*m); %construção do filtro ideal

figure
subplot(2,2,1)
plot(m,hd);
%-------------------------------------------------
b = hamming(M);
h = b.*hd'; %filtro após janelamento

subplot(2,2,2)
plot(m,h');
%-------------------------------------------------
a=1;
f=0:(Fs/2)-1;

[H,w]=freqz(h,a,f,Fs); %Função resposta em frequÊncia

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

% Comentário: O valor de M e a faixa de passagem são inversamente 
% proporcionais, pois quanto maior a faixa de
% passagem, menos amostras serão necessárias para formar o filtro;