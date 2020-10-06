function [out]= mauriciosat1(A,B,x,l,s,w,y,lambda,rho)

invlambda=inv(lambda);

n=size(A{1},1); %Numero de linhas e colunas de A
m=size(B{1},2);
N=size(A,2); %Numero de modos (Matrizes As)
eps=1e-5;

A1=rolmipvar(A,'Ai',N,1);
B1=rolmipvar(B,'Bi',N,1);

J=factorial(N+y-1)/(factorial(y)*factorial(N-1));

X= rolmipvar(n,n,'Xi','full',N,x);

S = rolmipvar(n,n,'Si','symmetric',N,s);
if s~= 0
    S1=fork(S,'Sj',[1 2]);
else
    S1=S;
end

W=rolmipvar(m,n,'Wi','full',N,w);
T=rolmipvar(m,m,'T','diagonal',N,s);
L=rolmipvar(m,n,'Li','full',N,l);
Y=rolmipvar(m,n,'Y','full',N,y);
H=rolmipvar(n,n,'H','symmetric',N,0);
Z=rolmipvar(m,m,'full',N,y);
if x~=0
    Y1=fork(Y,'Yj',[1 2]);
    Z1=fork(Z,'Zj',[1 2]);
else
    Y1 = Y;
    Z1 = Z;
end

% LMI
LMIs = set([]);
LMI1=[X+X'-invlambda*S -W' X'*A1' -L'; -W T+T' -T'*B1' zeros(m,m);A1*X -B1*T S1-B1*Y1-Y1'*B1' -Y1'+B1*Z1;-L zeros(m,m) -Y1+Z1'*B1' Z1+Z1'];
LMIs = LMIs +(LMI1-eps*eye(length(LMI1))>= 0);
LMIs=LMIs+[[-rho^2*(eye(m)) L-W; L'-W' -X-X'+S]<=0];
LMIs = LMIs + (S-eps*eye(length(S))>= 0);
LMIs=LMIs+[[-H eye(n); eye(n) -S]<=0]; %acrescendo uma matriz H (quando o problema de oti é trace  H) 

%Cálculo do número de linhas 
linhas=0; % Número de linhas
for l=1:size(LMIs)
    linhas = linhas + size(double(LMIs(l)),1);
end
nl=(2*n+2*m)*((N+y)/(y+1))*J^2+m*(n+1)*J+3*n*J;
obj = trace(coefs(H)); % função objetivo 
options=sdpsettings('verbose',1,'warning',1,'solver','lmilab','showprogress',0); % Configuracao para solucao
out.sol=optimize(LMIs,obj,options);%RESOLUÇAO DAS LMIs
out.variaveis=size(getvariables(LMIs),2); %Numero de variaveis usadas
warning('off','YALMIP:strict'); %Desliga warning da matriz declarada definida ao invés de semidefinida
p=min(checkset(LMIs));
out.p=p;
out.feas=0;

if p>0  % p>0 TEM SOLUCAO. feas=1 (Teve solucao)
    
    P=double(S);
    L=double(L);
    X=double(X);
    H=double(H);
    W=double(W);
    out.P=P;
    out.L=L;
    out.X=X;
    out.H=H;
    out.W=W;
    out.feas=1;
    out.LMIs=LMIs;
    out.NL=linhas;
    out.nl=nl;
else
    S=double(S);
    out.S=S;
    out.feas=0;
    out.LMIs=LMIs;
    out.NL=linhas;
end