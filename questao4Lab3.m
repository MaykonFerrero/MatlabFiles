close all
clear

% 04 - Analise o espectro de frequ�ncia do arquivo de �udio
% Vivaldi-01.wav. Quais s�o as freq�ncias predominantes? Porqu�?
% a) Escolha uma outra m�sica de sua prefer�ncia e analise
% o espectro de frequ�ncias. Compare os dois resultados

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
%a fft do Matlab n�o tem seu resultado expresso em volts. 
%Para representar o resultado desta fft em volts � necess�rio 
%dividir o resultado da fft pelo n�mero de amostras do vetor 
%que a fft retornou (que coincide com o n�mero de amostras 
%do vetor de entrada da fft)
X=2*(X./length(X));

%-------------------------------------------------
%como o espectro � composto por n�meros complexos, 
%calcular seu m�dulo
X_modulo=abs(X);

%-------------------------------------------------
%gerar um eixo de freq��ncias discreto
delta_freq= FS / length(X);

f=-FS/2:delta_freq:FS/2-delta_freq;
%f=0:delta_freq:FS-delta_freq;

figure
stem(f,X_modulo)
xlabel('freq��ncia (em Hz)')
ylabel('magnitude (em volts)')
grid
%------------------------------------------------------------