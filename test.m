%Clear memory and console output
clc
clear

%Set the number of grid points
N = 500;        % For the space interval [a,b]
M = 100;        % For the time interval [0,T]

%Paramerters for Barrier Option Pricing
S0 = 95;        % Stock Price	
K = 110;        % Strike Price
B = 4*K;        % Barrier level (use 4*K)
Smin = 0.001;   % Set minimum stock price
Smax = 4*K;     % Set maximum stock price
T = 1;          % Term (years)	
r = 5;          % Interest Rate (%)	
d = 0;          % Dividend Yield (%)	
sigma = 25;     % Volatility (%)

%Solve FDM for BS
[S, t, V] = BarrierCallOption_BS(Smin,Smax,T,N,M,r,d,sigma,K,B,true);

%Calculate Up-and-out Barrier option price when the Stock Price is S0
interp1(S,V(:,end),S0)