1;
function d = relative_defect(A,x,b);
% octave's norm function does what we want: euclidian norm
  d = norm(A*x-b);
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

function [x, numit] = my_sor(A,b,x0,eps,maxit,omega)
  % Matrix calculations
  R = triu(A,1);
  L = tril(A,-1);
  D = diag(diag(A));
  inv_D_and_omega_L = inverse(D+omega*L);
  c = omega * inv_D_and_omega_L * b;
  H_w = inv_D_and_omega_L * ((1-omega) * D - omega * R);
  
  % Initialization
  rel_def_in = relative_defect(A,x0,b);
  err = rel_def_in + 1; % arbitrary default error greater than first one.
  numit = 0;
  x = x0;

  % Iteration
  while ((numit < maxit) && (err > eps*rel_def_in))
    x = H_w*x + c;
    err = relative_defect(A,x,b);
    numit = numit + 1;
  endwhile
endfunction


function [A,b] = my_test_system(n)
  b = ones(n*n,1);
  % fill up A's diagonal with many T's
  A = 4*eye(n*n) + diag(-ones(n*n-1,1),1) + diag(-ones(n*n-1,1),-1);
  % now fill up with I's
  A = A + diag(-ones(n*n-n,1),n) + diag(-ones(n*n-n,1),-n);
endfunction

n_max = 60;
iterations_gs = zeros(n_max-9,1);
iterations_jac = zeros(n_max-9,1);
iterations_sor = zeros(n_max-9,1);

for n=10:n_max
  [A,b] = my_test_system(n);
  [x,iterations_jac(n-9)] = my_jacobi(A,b,b,1e-6,1e8);
  [x, iterations_gs(n-9)] = my_gauss_seidel(A,b,b,1e-6,1e8);
  omega = 2/(sin(pi/n)+1);
  [x, iterations_sor(n-9)] = my_sor(A,b,b,1e-6,1e8, omega);
  printf([int2str(n) '\n']);
  fflush(stdout);
endfor

n = linspace(10,n_max,n_max-9)';
plot(n,iterations_jac, 'r-', n, iterations_gs, 'b-', n, iterations_sor, 'g-');
legend('Jacobi','Gauß-Seidel','SOR');
xlabel('n');
ylabel('# iterations');
title('Plot of iterative procedures calculating A*x=b');
print('PA10.pdf);
