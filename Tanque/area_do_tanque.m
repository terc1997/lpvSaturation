h = [0.1:0.01:0.7];
r = 31e-2;
sigma = 0.55;
mi = 0.40;
i_cos = (2.5*pi*(h - mi));
i_exp = -((h - mi).^2)/(2*sigma^2);
%�rea n�o linear
A_T3 = (3*r/5)*(2.7*r - (cos(i_cos)/(sigma*sqrt(2*pi))).*exp(i_exp));
%%
% limite = max(A_T3);
% linha_de_rev = limite + (23.3/2)*1e-2;
% A_T3 = A_T3;
%�rea aproximada, grau 5
A_T3_5s = (3*r/5)*(2.7*r - (1/(sigma*sqrt(2*pi)))*(1 - 0.5*i_cos.^2 + (1/24)*i_cos.^4 - (1/720)*i_cos.^6 + (1/(720*56))*i_cos.^8 ).*(1 - i_exp + 0.5*i_exp.^2 - (1/6)*i_exp.^3 + (1/24)*i_exp.^4 ));
figure
plot(h,A_T3);
hold on 
% plot(h,A_T3_5s);
title('Aproxima��o da �rea do Tanque');
legend('N�o Linear','N=5');
xlabel('Altura (m)')
ylabel('Curva ')
grid on
%% Novo Polinômio
p = [-19.8163   31.7060  -14.8780    1.7565    0.1777];
a_tiu = polyval(p,h);
plot(h,a_tiu,'*k')