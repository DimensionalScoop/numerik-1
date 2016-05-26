% Tested and executable in Octave 4.0.2
1;

function y=runge(x)
    y = 1/(1+25*x.^2);
end

a = -1;
b = 1;
N = 1:1:100;

w_trapez    = [1/2 1/2];
w_simpson   = [1/6 4/6 1/6];
w_milne    = [7/90 16/45 2/15 16/45 7/90];

p_trapez    = [0 1];
p_simpson   = [0 1/2 1];
p_milne    = [0 1/4 2/4 3/4 1];

exact = 2/5 * atan(5)

for n = N
    I_trapez(n)  = abs(myQuadraturSum1D(@runge,w_trapez,p_trapez,a,b,n)  -exact);
    I_simpson(n) = abs(myQuadraturSum1D(@runge,w_simpson,p_simpson,a,b,n)-exact);
    I_milne(n)  = abs(myQuadraturSum1D(@runge,w_milne,p_milne,a,b,n)  -exact);
endfor

semilogy(N, I_trapez, N, I_simpson, N, I_milne)
legend("Trapez","Simpson","Milne")