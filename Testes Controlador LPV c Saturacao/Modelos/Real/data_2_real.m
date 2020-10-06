% dados para carregar o controlador_integrador_LPV_real.slx
clear
clc
%% Carrega o teste que deseja rodar
load('tarsis_seguimento_referencia_25_3.mat')
% Verifica a posicao de inicio do vetor a ser aplicado 
total = length(Level3CM);
partial = length(x_i);
delay = total - partial + 1;
%% Determinando o rho do sistema
rho = max(u_s);
%% Carrega os parâmetros. 
% O cálculo do integrador é feito com os valores filtrados, portanto estes serão utilizados
% Tempo de amostragem
T = 5.2632;
% Altura do tanque 3
h3_data.time = t(delay:end);
h3_data.signals.values = h3f';
h3_data.signals.dimensions = 1;
% Altura do tanque 4
h4_data.time = t(delay:end);
h4_data.signals.values = h4f';
h4_data.signals.dimensions = 1;
% Erro
erro_data.time = t(delay:end);
erro_data.signals.values = erro';
erro_data.signals.dimensions = 1;

% Pontos de Operação
% Conversão do Sinal de Controle de Operação em Referência
sp_q = uop*16.4 + 357.3;
sp_h3 = ((sp_q - 309.9)/87.07).^2;
sp_h4 = (sp_q - 431.2)/33.51 + sp_h3;

% Sinal de Controle de operação
uop_data.time = t(delay:end);
uop_data.signals.values = uop';
uop_data.signals.dimensions = 1;
% Altura tanque 4 de operação
sph4_data.time = t(delay:end);
sph4_data.signals.values = sp_h4';
sph4_data.signals.dimensions = 1;
% Altura tanque 4 de operação
sph3_data.time = t(delay:end);
sph3_data.signals.values = sp_h3';
sph3_data.signals.dimensions = 1;

timeout = t(end);
%% Teste apenas do sinal de controle
% Sinal de Controle da Realimentação de Estados
du_data.time = t(delay:end);
du_data.signals.values = du';
du_data.signals.dimensions = 1;
% Sinal de Controle do Integrador
ui_data.time = t(delay:end);
ui_data.signals.values = u_i';
ui_data.signals.dimensions = 1;
%% Calculando os ganhos do sistema
% Espaço de estados
A{1}=[-0.0111 0.0111; 0.0155 -0.0193]; % Matriz de Estados 1
A{2}=[-0.0111 0.0111; 0.0238 -0.0282]; % Matriz de Estados 2

B{1}=[1.0e-04 *0.5432; 0];
B{2}=B{1};

C=[0 1];
D=0;

% Discretização com ZOH
[Ad{1},Bd{1},Cd{1},Dd{1}]=c2dm(A{1},B{1},C,D,T,'zoh');
[Ad{2},Bd{2},Cd{2},Dd{2}]=c2dm(A{2},B{2},C,D,T,'zoh');
% Dimensão das matrizes
n=size(Ad{1},1);
m=size(Bd{1},2);
% Espaço de Estados Aumentados
Aa{1}=[Ad{1} zeros(n,m); -Cd{1}*Ad{1} 1];
Aa{2}=[Ad{2} zeros(n,m); -Cd{2}*Ad{2} 1];
Ba{1}=[Bd{1}; -Cd{1}*Bd{1}];
Ba{2}=[Bd{2}; -Cd{2}*Bd{2}];

lambda = 0.95;

[out]= mauriciosat1(Aa,Ba,1,1,1,1,1,lambda,rho);

q=coefs(out.P);
P1=inv(q{1});
P2=inv(q{2});

Vl=coefs(out.L);
Vx=coefs(out.X);

K1_lmi=Vl{1}/Vx{1};
K2_lmi=Vl{2}/Vx{2};
K1_ = K1_lmi(1:2);
K2_ = K2_lmi(1:2);
Ka_ = [K1_lmi(3) K2_lmi(3)];