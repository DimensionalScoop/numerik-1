% Tested and executable in Octave 4.0.2

function I = myQuadraturSum1D(f,w,p,a,b,N)
    
    h = (b-a)/N;
    I = 0;
    
    for i=1:1:N
        % variables with trailing underscores are only used for one sub-interval
        a_ = a+(i-1)*h;
        b_ = a+i*h;
        
        I_ = 0;
        interval_ = b_ - a_;
        steps_ = length(p);
        
        for j=1:1:steps_
            x_i = a_+p(j)*interval_; % convert from unit interval to our interval
            I_ += f(x_i) * w(j);
        end
        I_ *= interval_;
        
        I+=I_;
    end
end