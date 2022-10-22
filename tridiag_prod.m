% Tri-diagonal Matrix times Vector
% A function to compute the product between a tri-diagonal matrix (D U L) 
% and a vector x
% This is a function that was given in the Computational Finance module
% written by Francesco Cosentino.

function y = tridiag_prod (D,U,L,X)

  N = length(D);
  y = zeros(N,1);

  %Matrix times X

  for j=1:N

    if ( j == 1 )
      y(j) = D(j)*X(j) + U(j)*X(j+1);
    elseif ( j < N )
      y(j) = L(j-1)*X(j-1) + D(j)*X(j) + U(j)*X(j+1);
    else
      y(j) = L(j-1)*X(j-1) + D(j)*X(j);
    end

  end

end