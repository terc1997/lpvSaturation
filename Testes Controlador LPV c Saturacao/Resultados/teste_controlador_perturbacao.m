clear
clc
%%
load('larissa_tarsis_LPV_c_saturacao_perturbacao.mat')
%%
figure
plot(t,Level3CM)
title('Altura do Tanque 3 (h_{3})')
xlabel('Tempo(s)')
ylabel('Altura (cm)')
xlim([0 2620])
grid on
%%
figure
plot(t,Level4CM)
title('Altura do Tanque 4 (h_{4})')
xlabel('Tempo(s)')
ylabel('Altura (cm)')
xlim([0 2620])
grid on
%%
figure
plot(t(187:499),h3)
title('Altura do Tanque 3 após Controle Acionado (h_{3})')
xlabel('Tempo(s)')
ylabel('Altura (cm)')
grid on
xlim([1000 2620])
%%
figure
plot(t(187:499),h4)
title('Altura do Tanque 3 após Controle Acionado (h_{3})')
xlabel('Tempo(s)')
ylabel('Altura (cm)')
xlim([1000 2620])
grid on
%%
figure
plot(t(187:499),du)
title('Variação do Sinal de Controle sem Saturação')
xlabel('Tempo(s)')
ylabel('Altura (cm)')
xlim([1000 2620])
grid on
%%
figure
plot(t(187:499),u)
title('Sinal de Controle sem Saturação')
xlabel('Tempo(s)')
ylabel('Altura (cm)')
xlim([1000 2620])
grid on
%%
figure
plot(t(187:499),u_s)
title('Sinal de Controle com Saturação')
xlabel('Tempo(s)')
ylabel('Altura (cm)')
xlim([1000 2620])
grid on