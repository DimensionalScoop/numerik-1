1;

function y = f(x)
    y = sin(pi/2*x).^2-x.^2;
endfunction

x = [-3/2 -1/2 1/2 3/2];
y = f(x)

% Aufgabe 2.2
function y = phi(x)
    y = 1/3*(x-1).*(x-3)-3*1/2*(x.*(x-3))+2*1/6*x.*(x-1);
endfunction

x = [0 1 3 2];
y = phi(x)