clear
clc
%%
load('larissa_tarsis_LPV_saturacao_perturbacao_degrau_unitario_15.mat')
%%
% Conversão do Sinal de Controle de Operação em Referência
sp_q = uop*16.4 + 357.3;
sp_h3 = ((sp_q - 309.9)/87.07).^2;
sp_h4 = (sp_q - 431.2)/33.51 + sp_h3;
%%
figure
hold on
plot(t(42:560),h3f);
plot(t(42:560),sp_h3*1e-2);
xlabel('Tempo(s)')
ylabel('Altura(cm)')
xlim([211.7 2938])
grid on
title('Altura do Tanque 3')
% % 
load('larissa_tarsis_LPV_saturacao_perturbacao_degrau_unitario_2.mat')
plot(t(42:544),h3f);
legend('Filtrado - 15%','Referência','Filtrado - 25%')