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
T = 5.2632;
%%
a1 = [];
for i=28:1:70
    % Pontos de operação:
    sp_h3 = i;
    sp_q = sqrt(sp_h3)*87.07+309.9;
    sp_u = (sp_q-357.3)/16.4;
    sp_h4 = (sp_q - 431.2)/33.51 + sp_h3;

    sp_h3 = sp_h3*1e-2;
    sp_h4 = sp_h4*1e-2;

    % % Matrizes de Estado
    A = double(subs(jacobian([f1;f2],[h4 h3]),[h4 h3 u],[sp_h4 sp_h3 sp_u]));
    B= double(subs(jacobian([f1;f2],u),u,sp_u));
    C = [0 1];
    D = 0;
    [Ad,Bd,Cd,Dd] = c2dm(A,B,C,D,T,'zoh');
    a1 = [a1; Ad(1,1) Ad(1,2) Ad(2,1) Ad(2,2)];
end
%%
figure
subplot(2,1,1);
plot(28:1:70,a1(:,3))
hold on
line([28 48],[a1(1,3) a1(48-27,3)],'Color','red')
plot([28 48],[a1(1,3) a1(48-27,3)],'k*')
grid on
xlabel('Pontos de Operação')
ylabel('Amplitude')
title('Variação de Ad(2,1)')
xlim([28 70]) 
legend('Variação dos Termos','Aproximação')
subplot(2,1,2);
plot(28:1:70,a1(:,4))
hold on
line([28 48],[a1(1,4) a1(48-27,4)],'Color','red')
plot([28 48],[a1(1,4) a1(48-27,4)],'*k')
grid on
xlabel('Pontos de Operação')
ylabel('Amplitude')
title('Variação de Ad(2,2)')
legend('Variação dos Termos','Aproximação')
xlim([28 70])
% 
% minimo = min(a1(:,3));
% maximo = max(a1(:,3));
% hold on
% plot([28 k],[minimo maximo])


%%
minimo = min(a1(:,4));
maximo = max(a1(:,4));
k = find(a1(:,4) == minimo)+27;
hold on
% plot([28 k],[maximo minimo])
% xlim([28 48])


alfa1 = fit([28 48]',[a1(1,3) a1(48-27,3)]','poly1');
alfa2 = fit([28 48]',[a1(1,4) a1(48-27,4)]','poly1');
