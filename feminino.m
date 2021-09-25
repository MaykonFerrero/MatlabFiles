close all
clear
[x,FS]=audioread('feminino.wav');
h1 = [-0.0517 0.25 0.6035 0.25 -0.0517];
h2 = [-0.0517 -0.25 0.6035 -0.25 -0.0517];
%y1 = passa baixa
y1 = conv(x,h1);
%y1 = y1(1:(length(y1)-(length(h1)-1)));
%y2 = passa alto
y2 = conv(x,h2);
%y2= y2(1:(length(y2)-(length(h2)-1)));

subplot(1,3,1); 
stem(x);
grid
xlabel('número de amostras'); 
title('audio de entrada'); 
ylabel('audio');

subplot(1,3,2); 
stem(y1);
grid
xlabel('número de amostras'); 
title('filtro passa baixo'); 
ylabel('audio');

subplot(1,3,3); 
stem(y2);
grid
xlabel('número de amostras'); 
title('filtro passa alto'); 
ylabel('audio');

sound(y1,FS);
pause(10);
sound(y2,FS);

%subplot(1,3,3); 
%plot((n,y2);
%grid
%xlabel('número de amostras'); 
%title('filtro passa alto'); 
%ylabel('audio');












% 
% 
% 
% close all
% clear
% FS = 8000;
% 
% n = 1:length(x);
% y1 = conv(x,h1)
% w = [-FS:1:FS]*pi/(FS/2);
% %X = (a1*exp(-j*0*w) + a2*exp(-j*1*w) + b*exp(-j*2*w) + a2*exp(-j*3*w) + a1*exp(-j*4*w));
% %X = exp(-j*2*w)*(a1*exp(j*2*w) + a2*exp(j*w) + b + a2*exp(-j*w) + a1*exp(-j*2*w));
% %X = 2a1*cos(2w) + 2a2*cos(2w) + b;
% %(a) |X| = 1 para w = 0; |X| = 0,707 para w = 0.5*pi; |X| = 0 para w = pi;
% 
% %1 = 2a1 + 2a2 + b
% %0,707 = -2a1 + 0 + b
% %0 = 2a1 - 2a2 + b
% 
% A = [2 2 1;-2 0 1; 2 -2 1];
% B = [1; 0.707; 0];
% R = A\B;
% 
% a1 = R(1);
% a2 = R(2);
% b = R(3);
% h1 = [a1 a2 b a2 a1];
% X = (a1*exp(-j*0*w) + a2*exp(-j*1*w) + b*exp(-j*2*w) + a2*exp(-j*3*w) + a1*exp(-j*4*w));
% 
% magX = abs(X); 
% angX = angle(X);
% 
% figure
% 
% subplot(1,2,1); 
% plot((w/pi),magX);
% grid
% xlabel('frequency in pi units'); 
% title('Magnitude Part'); 
% ylabel('Magnitude');
% 
% subplot(1,2,2); 
% plot((w/pi),angX);
% grid
% xlabel('frequency in pi units'); 
% title('Angle Part'); 
% % ylabel('Radians');
