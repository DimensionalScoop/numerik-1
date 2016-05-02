1;  % fuck you octave
function [c] = myNewtonInterpol(x,f)
  n = length(x);
  y(:,1) = f; % first column equals f(x_i)
  % now let's build divided differences
  for j=2:n
    for i=j:n
      % fill a column for each fixed y
      y(i,j) = ( y(i, j-1) - y(i-1,j-1)) / (x(i) - (x(i-j+1)));
    end
  end
  c = diag(y);
endfunction
