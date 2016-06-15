1;

function [x,e,v]=mybisect(f,x00,x0)
  x(0) = 0.5*(f(x00) - f(x0));
  v(0) = f(x)
  a = x00
  b = x0
  if (sign(f(x00) != sign(f(x0))
    while (e < 10^12)
      if (sign(a) == sign(v(end))
      x = [x; 
    endwhile
  endif
endfunction

function s = sign(x)
  if (x<0)
    s = -1;
  else
    s = 1;
  endif
endfunction