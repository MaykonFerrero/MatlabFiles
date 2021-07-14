clear;
s = tf ('s');

G1 = 1/(s*(s+7));
H =1;
Gc = 471.7*(s+10)/(s+25.5649);
G = G1*Gc;

F=feedback(G,H);

t1=1.14;
w1=0.15;
G2 = 1/(s^2 +2*t1*w1*s);
H1 =1;



step (F);
title('Resposta do sistema ao Degrau Unitário');
xlabel('T');
ylabel('Amplitude');
grid on;
hold;

step (feedback(G2,H1));
step (F);
title('Comparação da Resposta do sistema ao Degrau Unitário com e sem o compensador');
xlabel('T');
ylabel('Amplitude');
grid on;
hold;





