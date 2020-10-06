clear
clc
%%
load('tarsis_seguimento_referencia_25_2.mat')
%%
% Conversão do Sinal de Controle de Operação em Referência
sp_q = uop*16.4 + 357.3;
sp_h3 = ((sp_q - 309.9)/87.07).^2;
sp_h4 = (sp_q - 431.2)/33.51 + sp_h3;
%%
figure
plot(t(39:1063),h3*1e-2);
hold on
plot(t(39:1063),h3f);
plot(t(39:1063),sp_h3*1e-2);
xlabel('Tempo(s)')
ylabel('Altura(cm)')
xlim([195.7 5585])
grid on
title('Altura do Tanque 3')
legend('Real','Filtrado','Referência')
%%
figure
plot(t(39:1063),h4*1e-2);
hold on
plot(t(39:1063),h4f);
plot(t(39:1063),sp_h4*1e-2);
xlabel('Tempo(s)')
ylabel('Altura(cm)')
xlim([195.7 5585])
grid on
title('Altura do Tanque 4')
legend('Real','Filtrado','Referência')
%%
figure
subplot(3,1,1)
plot(t(39:1063),K1)
title('Ganho do Estado 1')
ylabel('Amplitude')
xlabel('Tempo(s)')
grid on
xlim([195.7 5585])
subplot(3,1,2)
plot(t(39:1063),K2)
title('Ganho do Estado 2')
ylabel('Amplitude')
xlabel('Tempo(s)')
grid on
xlim([195.7 5585])
subplot(3,1,3)
plot(t(39:1063),Ka)
title('Ganho do Integrador')
ylabel('Amplitude')
xlabel('Tempo(s)')
grid on
xlim([195.7 5585])
%%
figure
subplot(3,1,1)
plot(t(39:1063),du)
title('Variação do Sinal de Controle')
ylabel('Amplitude (%)')
xlabel('Tempo(s)')
grid on
xlim([195.7 5585])
subplot(3,1,2)
plot(t(39:1063),u_i)
title('Sinal de Controle do Integrador')
ylabel('Amplitude (%)')
xlabel('Tempo(s)')
grid on
xlim([195.7 5585])
subplot(3,1,3)
plot(t(39:1063),u_s)
hold on
plot(t(39:1063),u)
title('Sinal de Controle')
ylabel('Amplitude (%)')
xlabel('Tempo(s)')
legend('Saturado','Real')
grid on
xlim([195.7 5585])
%%
figure
plot(t(39:1063),erro)
title('Erro')
ylabel('Amplitude (%)')
xlabel('Tempo(s)')
xlim([195.7 5585])
grid on
%%
figure
plot(t(39:1063),x_i)
title('Estado do Integrador')
ylabel('Amplitude (%)')
xlabel('Tempo(s)')
xlim([195.7 5585])
grid on
%%
figure
T = 5.2632;
x = sdpvar(3,1);
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

N=size(Ad,2);
lambda = 0.95;
rho = 25;

[out]= mauriciosat1(Aa,Ba,1,1,1,1,1,lambda,rho);

q=coefs(out.P);
P1=inv(q{1});
P2=inv(q{2});
% Configurando o solver

% x_ = [(h4(1:621)*1e-2 - sp_h4(1:621)*1e-2);(h3(1:621)*1e-2 - sp_h3(1:621)*1e-2);x_i(1:621)];
% plot_dir3(x_(1,:)',x_(2,:)',x_(3,:)','r')
% hold on
x_ = [(h4f - sp_h4*1e-2);(h3f - sp_h3*1e-2);x_i];
plot_dir3(x_(1,:)',x_(2,:)',x_(3,:)','g')
hold on
plot(x'*P1*x <= 1 & x'*P2*x <= 1)

title('Trajetória dos Estados, Saturação de 25%')
xlabel('h_{4}')
ylabel('h_{3}')
zlabel('x_{i}')