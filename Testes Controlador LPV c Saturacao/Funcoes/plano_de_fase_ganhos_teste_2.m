clear
clc
%%
load('larissa_tarsis_LPV_saturacao_perturbacao_degrau_unitario_2.mat')
%%
figure
plot(K1,K2)
grid on
title('Plano de fase dos ganhos da realimentação de estados (K1 por K2)');
xlabel('K1')
ylabel('K2')
%%
figure
plot(K1,Ka)
grid on
title('Plano de fase dos ganhos da realimentação de estados (K1 por Ka)');
xlabel('K1')
ylabel('Ka')
%%
figure
plot(K2,Ka)
grid on
title('Plano de fase dos ganhos da realimentação de estados (K2 por Ka)');
xlabel('K2')
ylabel('Ka')
%%
figure
plot3(K1,K2,Ka)
title('Plano de fase dos ganhos integral e de realimentação de estados')
xlabel('K1')
ylabel('K2')
zlabel('Ka')
grid on