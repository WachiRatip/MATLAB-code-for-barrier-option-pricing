% The Crank-Nicolson FDM solver for the Heat Equation with zero boundary
% conditions
% This is a function that was given in the Computational Finance module
% written by Francesco Cosentino.

function UC = CrankNicolsonFDM(rho,UC,N,M)

%Matrix elements for Implict (I+Ai)
%diagonal elements
Di = (2+2*rho)*ones(N-1,1);
%upper diagonal elements
Ui = -rho*ones(N-1,1);
%lower diagonal elements
Li = -rho*ones(N-1,1);

%Matrix elements for Explict (I+Ae)
%diagonal elements
De = (2-2*rho)*ones(N-1,1);
%upper diagonal elements
Ue = rho*ones(N-1,1);
%lower diagonal elements
Le = rho*ones(N-1,1);

for k=1:M
    
    %Step 1 - Multiply Uk by I+Ae
    w = tridiag_prod (De,Ue,Le,UC(:,k));
    
    %Step 2 - Solve Tridiagonal System of Equations
    UC(:,k+1) = tridiag (Di,Ui,Li,w);
    
end
end