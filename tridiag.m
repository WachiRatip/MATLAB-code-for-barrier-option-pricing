% Tri-diagonal Matrix Solver
% A function to find a solution x of linear system Ax=b
% when A is a tri-diagonal matrix (D U L)
% This is a function that was given in the Computational Finance module
% written by Francesco Cosentino.

function x = tridiag (D,U,L,B)

  n = length(B);
  x = zeros(n,1);

  %make A upper diagonal

  for j=2:n
      D(j) = D(j) - L(j)*U(j-1) / D(j-1);
      B(j) = B(j) - L(j)*B(j-1) / D(j-1);
  end

  %Back substitution

  x(n) = B(n) / D(n);

  for j=n-1:-1:1
      x(j) = (B(j) - U(j)*x(j+1)) / D(j);
  end

end
