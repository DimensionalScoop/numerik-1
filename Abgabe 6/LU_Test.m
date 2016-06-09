% Tested and executable in Octave 4.0.2

function LU_Test()
    for n=10:5:25
        disp("n=")
        disp(n)
        
        i = 1:n;
        x_i = (n - i)/n;
        V = vander(x_i);
        
        b = ones(n,1);
        b(floor(n/2):n) = 2;
        
        LU = LU_decompose(V);
        % solving L*U*y=b in two steps:
        x = forward_solve(LU,b); % Lx=b
        y = backward_solve(LU,x); % Uy=x
        
        deviation = norm(V*y-b)
    end
end