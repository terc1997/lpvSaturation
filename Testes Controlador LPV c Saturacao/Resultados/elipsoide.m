% Cáluculo da P
T = 5.2632;
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
P_{1} = inv(q{1});
P_{2} = inv(q{2});




% Volume do elipsoide em função lambda
R = @(t,p)[sind(t)*cosd(p) cosd(t)*cosd(p) cosd(t);...
    sind(t)*sind(p) cosd(t)*sind(p) -sind(t);...
    -sin(p)         cos(p)          0];
is_inside = @(x) all(cellfun(@(M) x'*M*x <= 1,P_));
% Passo das iterações
dr = 0.1;
dt = 30;
dp = dt;
% Procurando a borda
cr = 0;
x = [0;0;0];
v = [1;0;0];
while is_inside(x)
    cr = cr + dr;
    x= cr*v;
end
cr = cr - dr;
% Percorrer em torno da borda
ps = zeros(360/dt, 3);
ps(1,:) = [cr 0 0];

for t=dt:dt:360
    for p=dp:dp:360
        v = R(dt,dp)*v;
        x = cr * v;
        if is_inside(x)
            while is_inside(x)
                cr = cr + dr;
                x = cr * v;
            end
            cr = cr - dr;
        else
            while ~is_inside(x)
                cr = cr - dr;
                x = cr * v;
            end
        end
    end
    ps(round(t/dt+1),:,:) = [cr t p];
end

xs = cell2mat(cellfun(@(k) (k(1)*R(k(2),k(3))*[1;0;0])', num2cell(ps, 3), 'UniformOutput', false));