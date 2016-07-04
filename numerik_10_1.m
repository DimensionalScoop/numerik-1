1;
function d = relative_defect(A,x,b);
% octave's norm function does what we want: euclidian norm
  d = norm(A*x+b);
endfunction

function [x, numit] = my_jacobi(A,b,x0,eps,maxit)
  % Matrix calculations
  R = triu(A,1);
  L = tril(A,-1);
  D = diag(diag(A));
  inv_D = inverse(D);
  c = inv_D * b;
  J = -inv_D*(L+R);
  
  % Initialization
  rel_def_in = relative_defect(A,x0,b);
  err = rel_def_in + 1; % arbitrary default error greater than first one.
  numit = 0;
  x = x0;

  % Iteration
  while ((numit < maxit) && (err > eps*rel_def_in))
    x = J*x + c;
    err = relative_defect(A,x,b);
    numit = numit + 1;
  endwhile
endfunction

function [x, numit] = my_gauss_seidel(A,b,x0,eps,maxit)
  % Matrix calculations
  R = triu(A,1);
  L = tril(A,-1);
  D = diag(diag(A));
  inv_D_and_L = inverse(D+L);
  c = inv_D_and_L * b;
  H_1 = -inv_D_and_L*R;
  eigs(H_1)
  
  % Initialization
  rel_def_in = relative_defect(A,x0,b);
  err = rel_def_in + 1; % arbitrary default error greater than first one.
  numit = 0;
  x = x0;

  % Iteration
  while ((numit < maxit) && (err > eps*rel_def_in))
    x = H_1*x + c;
    err = relative_defect(A,x,b);
    numit = numit + 1;
  endwhile
endfunction

function [x, numit] = test_jacobi(A,b,x0,eps,maxit)
  x = x0;
  x_old=x0;
  numit = 0;
  rel_def_in = relative_defect(A,x0,b);
  err = rel_def_in + 1; % arbitrary default error greater than first one.
  k = 0;
  n = length(A);
  while ((numit < maxit) && (err > eps*rel_def_in))
    for i=1:n
      sigma = 0;
      for j=1:n
        if (i!=j)
          sigma = sigma + A(i,j)*x_old(j);
        endif
      endfor
      x(i) = (b(i)-sigma)/A(i,i);
    endfor
    err = relative_defect(A,x,b);
    k = k+1;
    x_old = x
  endwhile
endfunction

b=[1;2;3;4];
x0 = [0;0;0;0];
A=[2,0,3,4;3,4,1,2;1,4,2,3;1,2,3,4];
my_gauss_seidel(A,b,x0,1e-4,1e1)