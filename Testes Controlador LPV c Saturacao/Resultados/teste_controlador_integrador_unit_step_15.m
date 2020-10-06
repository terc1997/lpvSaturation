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
plot(t(42:560),h3*1e-2);
hold on
plot(t(42:560),h3f);
plot(t(42:560),sp_h3*1e-2);
xlabel('Tempo(s)')
ylabel('Altura(cm)')
xlim([211.7 2938])
grid on
title('Altura do Tanque 3')
legend('Real','Filtrado','Referência')
%%
figure
plot(t(42:560),h4*1e-2);
hold on
plot(t(42:560),h4f);
plot(t(42:560),sp_h4*1e-2);
xlabel('Tempo(s)')
ylabel('Altura(cm)')
xlim([211.7 2938])
grid on
title('Altura do Tanque 4')
legend('Real','Filtrado','Referência')
%%
figure
subplot(3,1,1)
plot(t(42:560),K1)
title('Ganho do Estado 1')
ylabel('Amplitude')
xlabel('Tempo(s)')
grid on
xlim([211.7 2938])
subplot(3,1,2)
plot(t(42:560),K2)
title('Ganho do Estado 2')
ylabel('Amplitude')
xlabel('Tempo(s)')
grid on
xlim([211.7 2938])
subplot(3,1,3)
plot(t(42:560),Ka)
title('Ganho do Integrador')
ylabel('Amplitude')
xlabel('Tempo(s)')
grid on
xlim([211.7 2938])
%%
figure
subplot(3,1,1)
plot(t(42:560),du)
title('Variação do Sinal de Controle')
ylabel('Amplitude (%)')
xlabel('Tempo(s)')
grid on
xlim([211.7 2938])
subplot(3,1,2)
plot(t(42:560),u_i)
title('Sinal de Controle do Integrador')
ylabel('Amplitude (%)')
xlabel('Tempo(s)')
grid on
xlim([211.7 2938])
subplot(3,1,3)
plot(t(42:560),u_s)
hold on
plot(t(42:560),u)
title('Sinal de Controle')
ylabel('Amplitude (%)')
xlabel('Tempo(s)')
legend('Saturado','Real')
grid on
xlim([211.7 2938])
%%
figure
plot(t(42:560),erro)
title('Erro')
ylabel('Amplitude (%)')
xlabel('Tempo(s)')
xlim([211.7 2938])
grid on
%%
figure
plot(t(42:560),x_i)
title('Estado do Integrador')
ylabel('Amplitude (%)')
xlabel('Tempo(s)')
xlim([211.7 2938])
grid on