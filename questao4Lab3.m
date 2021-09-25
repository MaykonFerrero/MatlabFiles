close all
clear

% 04 - Analise o espectro de frequência do arquivo de áudio
% Vivaldi-01.wav. Quais são as freqências predominantes? Porquê?
% a) Escolha uma outra música de sua preferência e analise
% o espectro de frequências. Compare os dois resultados

[x,FS]=audioread('Vivaldi-01.wav');

%------------------------------------------------
%analise de Fourier
%calcular a Transformada Discreta de Fourier
X=fft(x);
%------------------------------------------------
%como a fft retorna inicialmente os valores da 
%parte positiva do espectro e depois a parte negativa, 
%reorganizar para a ordem natural
X=fftshift(X);
%------------------------------------------------
%a fft do Matlab não tem seu resultado expresso em volts. 
%Para representar o resultado desta fft em volts é necessário 
%dividir o resultado da fft pelo número de amostras do vetor 
%que a fft retornou (que coincide com o número de amostras 
%do vetor de entrada da fft)
X=2*(X./length(X));

%-------------------------------------------------
%como o espectro é composto por números complexos, 
%calcular seu módulo
X_modulo=abs(X);

%-------------------------------------------------
%gerar um eixo de freqüências discreto
delta_freq= FS / length(X);

f=-FS/2:delta_freq:FS/2-delta_freq;
%f=0:delta_freq:FS-delta_freq;

figure
stem(f,X_modulo)
xlabel('freqüência (em Hz)')
ylabel('magnitude (em volts)')
grid
%------------------------------------------------------------