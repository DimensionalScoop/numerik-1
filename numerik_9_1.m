% Tested and executable in Octave 4.0.2
1;

function g = g(x)
  g = 1/6 + x*(x*(1/3+x*1/6));
endfunction

function f = f(x)
  f = 1/6 + x*(-1+x*(1/3+x*1/6));
endfunction

x_new = 0;
x_old = 0;
iterations = 0;
err=1;
while (err>1e-3)
  x_new = g(x_old);
    printf('x%i = %f \n', iterations+1, x_new);
  err = abs(x_new - x_old);
  printf('|x_%i - x_%i| = %f \n', iterations+1, iterations, err);
  x_old = x_new;
  iterations = iterations+1;
endwhile
printf('\nf(x_%i) = %f', iterations, f(x_new));