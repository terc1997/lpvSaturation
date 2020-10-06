clear
clc

%% Determinação dos inicios e finais de vetores
% Verifica a posicao de inicio do vetor a ser aplicado 
load('tarsis_seguimento_referencia_25_certo.mat')
total = length(Level3CM);
partial = length(x_i);
delay = total - partial + 1;
space_time = [t(delay) t(end)];
% Conversão do Sinal de Controle de Operação em Referência
sp_q = uop*16.4 + 357.3;
sp_h3 = ((sp_q - 309.9)/87.07).^2;
sp_h4 = (sp_q - 431.2)/33.51 + sp_h3;
figure

plot(t(delay:end),sp_h3*1e-2,'LineWidth',2);
hold on
plot(t(delay:end),h3f,':','LineWidth',2);
load('tarsis_seguimento_referencia_15_certo.mat')
% Verifica a posicao de inicio do vetor a ser aplicado 
total = length(Level3CM);
partial = length(x_i);
delay = total - partial + 1;
space_time = [t(delay) t(end)];
plot(t(delay:end),h3f);
eixos = gca;
eixos.FontSize = 14;

xlabel('Tempo(s)')
ylabel('Altura(m)')
grid on
title('Altura de TQ-01')
legend({'Referência','25%','15%'},'Position',[0.15 0.8 0.1 0.1])
xlim([300.4 3525])
 X = [0.45 0.5];
 Y = [0.47 0.4];
 annotation('arrow',X,Y);
% add a zoom figure

axes('position',[0.55 0.18 0.3 0.3]);
load('tarsis_seguimento_referencia_25_certo.mat')
total = length(Level3CM);
partial = length(x_i);
delay = total - partial + 1;
space_time = [t(delay) t(end)];
% Conversão do Sinal de Controle de Operação em Referência
sp_q = uop*16.4 + 357.3;
sp_h3 = ((sp_q - 309.9)/87.07).^2;

plot(t(delay:end),sp_h3*1e-2,'LineWidth',2);
hold on
plot(t(delay:end),h3f,':','LineWidth',2);
load('tarsis_seguimento_referencia_15_certo.mat')
% Verifica a posicao de inicio do vetor a ser aplicado 
total = length(Level3CM);
partial = length(x_i);
delay = total - partial + 1;
space_time = [t(delay) t(end)];
plot(t(delay:end),h3f);
grid on
axis tight
xlim([1450 1800])


%%
figure

load('tarsis_seguimento_referencia_25_certo.mat')
total = length(Level3CM);
partial = length(x_i);
delay = total - partial + 1;
space_time = [t(delay) t(end)];
subplot(3,1,1)
title('K_{P1}')
yyaxis left
plot(t(delay:end),K1)
hold on
load('tarsis_seguimento_referencia_15_certo.mat')
total = length(Level3CM);
partial = length(x_i);
delay = total - partial + 1;
space_time = [t(delay) t(end)];
yyaxis right
plot(t(delay:end),K1,'-.','LineWidth',2)
legend('25%','15%')
xlim([300.4 3796])
eixos = gca;
eixos.FontSize = 14;
grid on

load('tarsis_seguimento_referencia_25_certo.mat')
total = length(Level3CM);
partial = length(x_i);
delay = total - partial + 1;
space_time = [t(delay) t(end)];
subplot(3,1,2)
title('K_{P2}')
yyaxis left
plot(t(delay:end),K2)
hold on
load('tarsis_seguimento_referencia_15_certo.mat')
total = length(Level3CM);
partial = length(x_i);
delay = total - partial + 1;
space_time = [t(delay) t(end)];
yyaxis right
plot(t(delay:end),K2,'-.','LineWidth',2)
legend('25%','15%')
xlim([300.4 3796])
eixos = gca;
eixos.FontSize = 14;
grid on

load('tarsis_seguimento_referencia_25_certo.mat')
total = length(Level3CM);
partial = length(x_i);
delay = total - partial + 1;
space_time = [t(delay) t(end)];
subplot(3,1,3)
title('K_{I}')
yyaxis left
plot(t(delay:end),Ka)
hold on
load('tarsis_seguimento_referencia_15_certo.mat')
total = length(Level3CM);
partial = length(x_i);
delay = total - partial + 1;
space_time = [t(delay) t(end)];
yyaxis right
plot(t(delay:end),Ka,'-.','LineWidth',2)
legend('25%','15%')
xlim([300.4 3796])
eixos = gca;
eixos.FontSize = 14;
grid on
%%
figure
subplot(2,1,1)
load('tarsis_seguimento_referencia_25_certo.mat')
total = length(Level3CM);
partial = length(x_i);
delay = total - partial + 1;
space_time = [t(delay) t(end)];
% create the limits of the signal control
s_lim = 50*ones(1,partial);
i_lim = zeros(1,partial);
% Conversão do Sinal de Controle de Operação em Referência
sp_q = uop*16.4 + 357.3;
sp_h3 = ((sp_q - 309.9)/87.07).^2;
sp_h4 = (sp_q - 431.2)/33.51 + sp_h3;
plot(t(delay:end),u);
hold on
plot(t(delay:end),s_lim,'--r')
plot(t(delay:end),i_lim,'--r')
title('Sinal de Controle 25%')
xlabel('Tempo(s)')
ylabel('Amplitude(%)')
eixos = gca;
eixos.FontSize = 14;
grid on
xlim([300.4 3796])
ylim([-10 60])

subplot(2,1,2)
load('tarsis_seguimento_referencia_15_certo.mat')
% Verifica a posicao de inicio do vetor a ser aplicado 
total = length(Level3CM);
partial = length(x_i);
delay = total - partial + 1;
space_time = [t(delay) t(end)];
% create the limits of the signal control
s_lim = 40*ones(1,partial);
i_lim = 10*ones(1,partial);
plot(t(delay:end),u);
hold on
plot(t(delay:end),s_lim,'--r')
plot(t(delay:end),i_lim,'--r')
xlabel('Tempo(s)')
ylabel('Amplitude(%)')
eixos = gca;
eixos.FontSize = 14;
grid on
title('Sinal de Controle 15%')
xlim([300.4 3796])
ylim([-10 60])


%% Teste de perturbação
% Determinação dos inicios e finais de vetores
% Verifica a posicao de inicio do vetor a ser aplicado 
load('tarsis_seguimento_referencia_25_certo.mat')
total = length(Level3CM);
partial = length(x_i);
delay = total - partial + 1;
space_time = [t(delay) t(end)];
% Conversão do Sinal de Controle de Operação em Referência
sp_q = uop*16.4 + 357.3;
sp_h3 = ((sp_q - 309.9)/87.07).^2;
sp_h4 = (sp_q - 431.2)/33.51 + sp_h3;
figure

plot(t(delay:end),sp_h3*1e-2,'LineWidth',2);
hold on
plot(t(delay:end),h3f,':','LineWidth',2);
load('tarsis_seguimento_referencia_15_certo.mat')
% Verifica a posicao de inicio do vetor a ser aplicado 
total = length(Level3CM);
partial = length(x_i);
delay = total - partial + 1;
space_time = [t(delay) t(end)];
plot(t(delay:end),h3f);
eixos = gca;
eixos.FontSize = 14;
xlabel('Tempo(s)')
ylabel('Altura(m)')
grid on
title('Altura of TQ-01')
legend({'Referência','25%','15%'},'Position',[0.15 0.8 0.1 0.1])
xlim([2820 5000])
 X = [0.45 0.5];
 Y = [0.45 0.52];
 annotation('arrow',X,Y);
% add a zoom figure

axes('position',[0.55 0.55 0.3 0.3],'Box','on');
load('tarsis_seguimento_referencia_25_certo.mat')
total = length(Level3CM);
partial = length(x_i);
delay = total - partial + 1;
space_time = [t(delay) t(end)];
% Conversão do Sinal de Controle de Operação em Referência
sp_q = uop*16.4 + 357.3;
sp_h3 = ((sp_q - 309.9)/87.07).^2;

plot(t(delay:end),sp_h3*1e-2,'LineWidth',2);
hold on
plot(t(delay:end),h3f,':','LineWidth',2);
load('tarsis_seguimento_referencia_15_certo.mat')
% Verifica a posicao de inicio do vetor a ser aplicado 
total = length(Level3CM);
partial = length(x_i);
delay = total - partial + 1;
space_time = [t(delay) t(end)];
plot(t(delay:end),h3f);
grid on
axis tight
xlim([3560 3823])


%%
figure

load('tarsis_seguimento_referencia_25_certo.mat')
total = length(Level3CM);
partial = length(x_i);
delay = total - partial + 1;
space_time = [t(delay) t(end)];
subplot(3,1,1)
title('K_{P1}')
yyaxis left
plot(t(delay:end),K1)
hold on
load('tarsis_seguimento_referencia_15_certo.mat')
total = length(Level3CM);
partial = length(x_i);
delay = total - partial + 1;
space_time = [t(delay) t(end)];
yyaxis right
plot(t(delay:end),K1,'-.','LineWidth',2)
legend('25%','15%')
xlim([2820 5000])
eixos = gca;
eixos.FontSize = 14;
grid on

load('tarsis_seguimento_referencia_25_certo.mat')
total = length(Level3CM);
partial = length(x_i);
delay = total - partial + 1;
space_time = [t(delay) t(end)];
subplot(3,1,2)
title('K_{P2}')
yyaxis left
plot(t(delay:end),K2)
hold on
load('tarsis_seguimento_referencia_15_certo.mat')
total = length(Level3CM);
partial = length(x_i);
delay = total - partial + 1;
space_time = [t(delay) t(end)];
yyaxis right
plot(t(delay:end),K2,'-.','LineWidth',2)
legend('25%','15%')
xlim([2820 5000])
eixos = gca;
eixos.FontSize = 14;
grid on

load('tarsis_seguimento_referencia_25_certo.mat')
total = length(Level3CM);
partial = length(x_i);
delay = total - partial + 1;
space_time = [t(delay) t(end)];
subplot(3,1,3)
title('K_{I}')
yyaxis left
plot(t(delay:end),Ka)
hold on
load('tarsis_seguimento_referencia_15_certo.mat')
total = length(Level3CM);
partial = length(x_i);
delay = total - partial + 1;
space_time = [t(delay) t(end)];
yyaxis right
plot(t(delay:end),Ka,'-.','LineWidth',2)
legend('25%','15%')
xlim([2820 5000])
eixos = gca;
eixos.FontSize = 14;
grid on
%%
figure
subplot(2,1,1)
load('tarsis_seguimento_referencia_25_certo.mat')
total = length(Level3CM);
partial = length(x_i);
delay = total - partial + 1;
space_time = [t(delay) t(end)];
% create the limits of the signal control
s_lim = 50*ones(1,partial);
i_lim = zeros(1,partial);
% Conversão do Sinal de Controle de Operação em Referência
sp_q = uop*16.4 + 357.3;
sp_h3 = ((sp_q - 309.9)/87.07).^2;
sp_h4 = (sp_q - 431.2)/33.51 + sp_h3;
plot(t(delay:end),u);
hold on
plot(t(delay:end),s_lim,'--r')
plot(t(delay:end),i_lim,'--r')
title('Sinal de Controle 25%')
xlabel('Tempo(s)')
ylabel('Amplitude(%)')
eixos = gca;
eixos.FontSize = 14;
grid on
xlim([2820 5000])
ylim([-10 60])
subplot(2,1,2)
load('tarsis_seguimento_referencia_15_certo.mat')
% Verifica a posicao de inicio do vetor a ser aplicado 
total = length(Level3CM);
partial = length(x_i);
delay = total - partial + 1;
space_time = [t(delay) t(end)];
% create the limits of the signal control
s_lim = 40*ones(1,partial);
i_lim = 10*ones(1,partial);
plot(t(delay:end),u);
hold on
plot(t(delay:end),s_lim,'--r')
plot(t(delay:end),i_lim,'--r')
xlabel('Tempo(s)')
ylabel('Amplitude(%)')
eixos = gca;
eixos.FontSize = 14;
grid on
title('Sigal de Controle 15%')
xlim([2820 5000])
ylim([-10 60])

