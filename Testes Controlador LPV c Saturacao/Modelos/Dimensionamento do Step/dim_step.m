% Parâmetros da simulação
T = 5.2632; % tempo de amostragem
% Perturbacao
load('larissa_tarsis_LPV_saturacao_perturbacao_degrau_unitario_2.mat')
perturbacao.time = t(148:158) + 5000;
perturbacao.signals.values = ((2.35e-2)^2)*(pi/4)*sqrt(2*9.80655*Level1CM(148:158)'/100);
perturbacao.signals.dimensions = 1;


% Altura inicial da simulação
h0 = input('Digite a altura inicial do teste: ');
% Quantidade de vezes que ocorrerá uma variação de step
qtd = 3;
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

N=size(Ad,2);

% Variável sdpvar
x = sdpvar(3,1);
%%
lambda = 0.95;
rho = 25;
g = 4;
[out]= mauriciosat1(Aa,Ba,g,g,g,g,g,lambda,rho);

% q=coefs(out.P);
% P1=inv(q{1});
% P2=inv(q{2});

Vl=coefs(out.L);
Vx=coefs(out.X);

J=factorial(N+g-1)/(factorial(g)*factorial(N-1));

for i=1:J
    P{i}=inv(q{i});
    K{i}=Vl{i}/Vx{i};
end

% figure
% plot(x'*P1*x <= 1 & x'*P2*x <= 1)
% pause(10);
%%
% Cálculo do controlador e da P
s_step = 0.02; %variação do step
% pontos de operação do sistema
for s=1:3
    sp_h3 = 28 + (s_step*100)*(s-1);
    sp_q = sqrt(sp_h3)*87.07+309.9;
    sp_u = (sp_q-357.3)/16.4;
    
    sp_h4 = (sp_q - 431.2)/33.51 + sp_h3;
    sp_h3 = sp_h3*1e-2;
    sp_h4 = sp_h4*1e-2;
    
    sp.u(s) = sp_u;
    sp.h3(s) = sp_h3;
    sp.h4(s) = sp_h4;
end
%%
% Simulação do sistema com os parâmetros determinados
sim('controlador_LPV_v2') %roda a simulação no simulink e coleta os dados
%%
% Plotagem da trajetória dos estados

hold on
maximum = max(x_is.signals.values);
pos = find(x_is.signals.values == maximum) + 1;
plot_dir3(dh4_s.signals.values(pos:end),dh3_s.signals.values(pos:end),x_is.signals.values(pos:end),'k')
title(['Lambda = ',num2str(lambda),' Step = ',num2str(s_step)]);
pause(10);
xlabel('dh_{4}')
ylabel('dh_{3}')
xlabel('x_{i}')
