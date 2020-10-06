% Parâmetros da simulação
clear
clc
T = 5.2632; % tempo de amostragem
% Perturbacao
load('larissa_tarsis_LPV_saturacao_perturbacao_degrau_unitario_2.mat')
perturbacao.time = t(1:158);
perturbacao.signals.values = Level1CM(1:158)'/100;
perturbacao.signals.dimensions = 1;

% Quantidade de steps da simulação
qtd = 3;
% Altura inicial da simulação
h0 = 0.28;

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
d = 1;
%%
for i=1:2 %variação do lambda de contratividade
    % Cálculo do controlador e da P
    [out]= mauriciosat1(Aa,Ba,1,1,1,1,1,0.764,25); 
    
    q=coefs(out.P);
    P1=inv(q{1});
    P2=inv(q{2});
    
    Vl=coefs(out.L);
    Vx=coefs(out.X);
    
    K1_lmi=Vl{1}/Vx{1};
    K2_lmi=Vl{2}/Vx{2};
    K1 = K1_lmi(1:2);
    K2 = K2_lmi(1:2);
    Ka = [K1_lmi(3) K2_lmi(3)];
    for j=1:2 %variação do degrau
        s_step = 0.01/j; %variação do step
        % pontos de operação do sistema
        for s=1:qtd
            sp_h3 = (h0*100) + (s_step*100)*(s-1);
            sp_q = sqrt(sp_h3)*87.07+309.9;
            sp_u = (sp_q-357.3)/16.4;
            
            sp_h4 = (sp_q - 431.2)/33.51 + sp_h3;
            sp_h3 = sp_h3*1e-2;
            sp_h4 = sp_h4*1e-2;
            
            sp.u(s) = sp_u;
            sp.h3(s) = sp_h3;
            sp.h4(s) = sp_h4;
        end
        sim('controlador_integrador_LPV_workspace') %roda a simulação no simulink e coleta os dados
        hold off
        figure(d)
        plot(x'*P1*x<=1 & x'*P2*x<=1)
        hold on
        plot_dir3(dh3_s.signals.values(93:570),dh4_s.signals.values(93:570),x_is.signals.values(93:570),'g')
    end
    d = d + 1;
end