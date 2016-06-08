function V = Vandermonde(v)
    n = length(v);
    V = zeros(n,n);
    for i=n:-1:1
        if (i == n)
            V(1:n, i) = ones(n,1);
        else
            V(1:n, i) = v'.*V(1:n, i+1);
        end
    end
end