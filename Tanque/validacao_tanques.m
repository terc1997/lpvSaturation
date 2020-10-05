clear
clc
%%
% Equações e variáveis:
syms u h3 h4 t h1(t) q0

% % Constantes do Sistemas:
syms z d
r = 31e-2;
sigma = 0.55;
mi = 0.40;
i_cos = (2.5*pi*(h3 - mi));
i_exp = -((h3 - mi)^2)/(2*sigma^2);
funcao_aprox = (3*r/5)*(2.7*r - (1/(sigma*sqrt(2*pi)))*(1 - 0.5*i_cos^2 + (1/24)*i_cos^4 - (1/720)*i_cos^6 + (1/(720*56))*i_cos^8 )*(1 - i_exp + 0.5*i_exp^2 - (1/6)*i_exp^3 + (1/24)*i_exp^4 ));
volume = int(funcao_aprox,0,h3);
area_simb = volume / h3;
A1 = (pi*(31)^2)*1e-4;

% % Vazão de Entrada:
qi = piecewise(u<20,0,u>=20,(16.4*u + 357.3)*1e-6);

% % Vazão Comunicante:
q12 = 33.51e-4*(h4 - h3) + 43.12e-5;

% % Vazão de Saída:
qout = (87.07e-5*sqrt(h3) + 30.99e-5);

% Dinâmica dos Tanques:
f1 = vpa((qi-q12)/A1,3);
f2 = vpa((q12 - qout)/area_simb,3);
format short
%%
%Simulação 1

% Pontos de operação:
sp_h3 = 28;
sp_q = sqrt(sp_h3)*87.07+309.9;
sp_u = (sp_q-357.3)/16.4;
sp_h4 = (sp_q - 431.2)/33.51 + sp_h3;

sp_h3 = sp_h3*1e-2;
sp_h4 = sp_h4*1e-2;

% % Matrizes de Estado
A{1}= double(subs(jacobian([f1;f2],[h4 h3]),[h4 h3 u],[sp_h4 sp_h3 sp_u]));
B{1}= double(subs(jacobian([f1;f2],u),u,sp_u));
C = [0 1];
D = 0;
tanque = ss(A{1},B{1},C,D);
load('tarsis_T34_modelo_28.mat');
figure
uo = zeros(1,length(0:0.1:11500));
uo(length(0:0.1:3500):length(0:0.1:7500)) = -2;
uo(length(0:0.1:7500):length(0:0.1:11500)) = 2;
[ys,~,~] = lsim(tanque,uo,0:0.1:11500);
ys = (ys + sp_h3);
plot(t,(Level3CM+1)/100);
hold on
plot(0:0.1:11500,ys,'-r','LineWidth',2);
%('Validação para o h_{3}^{*} = 28 cm')
xlabel('Tempo(s)')
ylabel('Altura(m)')
xlim([3000 11500])
grid on
%%
% Simulação 2

% Pontos de operação:
sp_h3 = 38;
sp_q = sqrt(sp_h3)*87.07+309.9;
sp_u = (sp_q-357.3)/16.4;
sp_h4 = (sp_q - 431.2)/33.51 + sp_h3;

sp_h3 = sp_h3*1e-2;
sp_h4 = sp_h4*1e-2;

% Matrizes de Estado
A{2} = double(subs(jacobian([f1;f2],[h4 h3]),[h4 h3 u],[sp_h4 sp_h3 sp_u]));
B{2} = double(subs(jacobian([f1;f2],u),u,sp_u));
C = [0 1];
D = 0;
tanque = ss(A{2},B{2},C,D);

load('tarsis_T34_modelo_38.mat');
figure
uo = zeros(1,length(0:0.1:11500));
uo(length(0:0.1:3500):length(0:0.1:8000)) = -2;
uo(length(0:0.1:8000):length(0:0.1:12000)) = 2;
[ys,~,~] = lsim(tanque,uo,0:0.1:12000);
ys = (ys + sp_h3);
plot(t,Level3CM/100);
hold on
plot(0:0.1:12000,ys,'-r','LineWidth',2);
%('Validação para o h_{3}^{*} = 38 cm')
xlabel('Tempo(s)')
ylabel('Altura(m)')
xlim([3000 11500])
grid on
%%
% Simulação 3
% Pontos de operação:
sp_h3 = 48;
sp_q = sqrt(sp_h3)*87.07+309.9;
sp_u = (sp_q-357.3)/16.4;
sp_h4 = (sp_q - 431.2)/33.51 + sp_h3;

sp_h3 = sp_h3*1e-2;
sp_h4 = sp_h4*1e-2;

% Matrizes de Estado
A{3} = double(subs(jacobian([f1;f2],[h4 h3]),[h4 h3 u],[sp_h4 sp_h3 sp_u]));
B{3} = double(subs(jacobian([f1;f2],u),u,sp_u));
C = [0 1];
D = 0;
tanque = ss(A{3},B{3},C,D);

load('tarsis_T34_modelo_48.mat');
figure
uo = zeros(1,length(0:0.1:8500));
uo(length(0:0.1:3500):length(0:0.1:6500)) = -2;
uo(length(0:0.1:6500):length(0:0.1:8500)) = 2;
[ys,~,~] = lsim(tanque,uo,0:0.1:8500);
ys = (ys + sp_h3);
plot(t,(Level3CM+0.5)/100);
hold on
plot(0:0.1:8500,ys,'-r','LineWidth',2);
%('Validação para o h_{3}^{*} = 48 cm')
xlabel('Tempo(s)')
ylabel('Altura(m)')
xlim([3000 8300])
grid on