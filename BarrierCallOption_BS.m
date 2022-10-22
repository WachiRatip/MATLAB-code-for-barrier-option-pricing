% A function to calculate the price of a barrier call option price
% using the Crank-Nicolson finite difference method
% BarrierCallOption_BS(Smin,Smax,T,N,M,r,d,sigma,K,B)
%
% Inputs: Smin  -Minimum stock price
%       : Smax  -Maximum stock price
%       : T     -Term (years)
%       : N     -Number of grid points for the space interval [a,b]
%       : M     -Number of grid points for the time interval [0,T]
%       : r     -Interest Rate (%)	
%       : d     -Dividend Yield (%)
%       : sigma -Volatility (%)
%       : K     -Strike Price
%       : B     -Barrier level 
%       : plt   -Boolen if True the plot the prices of the option at time 0 
%                against the stock spot prices and the surface plot for
%                the option prices corresponding to the FDM grid in S and t  
%                will be displayed. Otherwise, it is not.
%
% Outputs: S    -The stock spot price S(t) corresponding to 
%                 Smin <= S(t) <= Smax, when 0<=t<=T
%        : t    -The time interval [0,T]
%        : V    -The option prices calculated from BS via FDM.

function [S, t, V] = BarrierCallOption_BS(Smin,Smax,T,N,M,r,d,sigma,K,B,plt)
%%Rearrange parameters; change from % to decimal
r = r/100;
d = d/100;
sigma = sigma/100;
sigma2 = sigma*sigma; % sigma^2

%%Grid points construction
%Space interval (ln(Smin)<=x<=ln(Smax))
a = log(Smin);  % a in [a,b]
b = log(Smax);  % b in [a,b]
dx = (b-a)/N;
x = a+dx:dx:b-dx;
%Time interval (0<=tau<=sigma2*T/2)
Ttau = (sigma2*T/2);
dtau = Ttau/M;
tau = 0:dtau:Ttau;

%%Constant rho for FDM
rho = dtau/(dx*dx);

%%Compute alpha & beta parameters for v(x,tau)
alpha = (sigma2-2*r+2*d)/(2*sigma2);
beta = -((sigma2+2*r-2*d)*(sigma2+2*r-2*d)/(2*sigma2)/(2*sigma2)) - (2*d/sigma2);

%%Solve the heat equation
%Solution matrix to store value of U(x,t) at all grid points
UC = zeros(N-1,M+1);
%Initial condition
if max(exp(x))<B
    UC(:,1) = exp(-alpha*x).*max( exp(x)-K, 0.0);
else
    UC(:,1) = 0.0;
end
%it has zero boundary conditions
%V(Smin, t) = 0    -->    u(x=a,tau) = 0
%V(B, t) = 0       -->    u(x=b,tau) = 0

%Solve PDE via Crank Nicolson scheme
UC = CrankNicolsonFDM(rho,UC,N,M);

%%Back from u(x, tau) to V(S, t)
V = zeros(N-1, M+1);
for l=1:M+1
    V(:,l) = exp(alpha*x+beta*tau(l))'.*UC(:,l);
end

%%the stock spot prices and time (S,t)
S = exp(x);
t = T-tau/sigma2*2;

if plt
    %%Plot the price of the option at time 0 against the stock spot price
    figure(1)
    plot(S,V(:,end))
    xlabel('S')
    ylabel('V(S,0)')
    
    %%Surface plot the option prices with FDM grid in S and t
    [X,Y] = meshgrid(t,S);
    figure(2)
    surf(X,Y,V)
    xlabel('t')
    ylabel('S(t)')
    zlabel('V(S,t)')
end

end