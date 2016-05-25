1;

function I = myQuadraturSum1D(f,w,p,a,b,N)
    
    h = (b-a)/N;
    I = 0;
    
    for i=1:1:N
        # variables with trailing underscores are only used for one sub-interval
        a_ = a+(i-1)*h;
        b_ = a+i*h;
        
        I_ = 0;
        interval_ = b_ - a_;
        steps_ = length(p);
        
        for j=1:1:steps_
            x_i = a_+p(j)*interval_; #convert from unit interval to our interval
            I_ += f(x_i) * w(j);
        end
        I_ *= interval_;
        
        I+=I_;
    end
    
end



function y=runge(x)
    y = 1/(1+25*x.^2);
end

a = -1;
b = 1;
N = 1:1:100;

w_trapez    = [1/2 1/2];
w_simpson   = [1/6 4/6 1/6];
w_milner    = [7/90 16/45 2/15 16/45 7/90];

p_trapez    = [0 1];
p_simpson   = [0 1/2 1];
p_milner    = [0 1/4 2/4 3/4 1];

exact = 2/5 * atan(5)

for n = N
    I_trapez(n)  = abs(myQuadraturSum1D(@runge,w_trapez,p_trapez,a,b,n)  -exact);
    I_simpson(n) = abs(myQuadraturSum1D(@runge,w_simpson,p_simpson,a,b,n)-exact);
    I_milner(n)  = abs(myQuadraturSum1D(@runge,w_milner,p_milner,a,b,n)  -exact);
endfor

semilogy(N, I_trapez, N, I_simpson, N, I_milner)
legend("Trapez","Simpson","Milner")