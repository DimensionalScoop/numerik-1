function [v] = myQuadraturSum1D(f,w,p,a,b,N)
% MYQUADRATURSUM1D calculates the sum of N intervals using a closed 
% Newton-Stokes formula with weights w, grid points p (normalized to the
% one interval), function f. This will return the integral of f from a to
% b.
    h = (b-a)/N;
    v = 0;
    for j = 1:1:N
        p_ = a + (j-1)*h + p*h;    % construct adapted grid points
        v = v + myQuadratur1D(f,w,p_);  % sum up each step
    end
end

function c = myQuadratur1D(f,w,p)
% MYQUADRATUR1D calculates the closed Newton-Stokes formula with function
% f, grid points p and weights w
    c = 0;
    for i = 1:1:length(p) 
        c = c + w(i)*feval(f,p(i));
    end
    c = c*(p(length(p)) - p(1));
end