clear
clc
%%
load('larissa_tarsis-LPV_c_saturacao_degrais.mat')
%%
figure
plot(t,Level3CM)
title('Altura do Tanque 3 (h_{3})')
xlabel('Tempo(s)')
ylabel('Altura (cm)')
xlim([0 3204])
grid on
%%
figure
plot(t,Level4CM)
title('Altura do Tanque 4 (h_{4})')
xlabel('Tempo(s)')
ylabel('Altura (cm)')
xlim([0 3204])
grid on
%%
figure
plot(t,Pump1PC)
title('Sinal de Controle na bomba')
xlabel('Tempo(s)')
ylabel('Altura (cm)')
xlim([0 3204])
grid on
%%
figure
plot(t(179:610),h3)
title('Altura do Tanque 3 após Controle Acionado (h_{3})')
xlabel('Tempo(s)')
ylabel('Altura (cm)')
xlim([1000 3204])
grid on
%%
figure
plot(t(179:610),h4)
title('Altura do Tanque 3 após Controle Acionado (h_{3})')
xlabel('Tempo(s)')
ylabel('Altura (cm)')
xlim([1000 3204])
grid on
%%
figure
plot(t(179:610),du)
title('Variação do Sinal de Controle sem Saturação')
xlabel('Tempo(s)')
ylabel('Altura (cm)')
xlim([1000 3204])
grid on
%%
figure
plot(t(179:610),du_s)
title('Variação do Sinal de Controle com Saturação')
xlabel('Tempo(s)')
ylabel('Altura (cm)')
xlim([1000 3204])
grid on