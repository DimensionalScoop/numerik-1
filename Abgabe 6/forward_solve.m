function z = forward_solve(LU,b)
	[n,n] = size(LU);
	z = zeros(n,1);
	for i=1:n
		z(i) = (b(i) - sum(LU(i,1:i-1)'.*z(1:i-1)));
	end
end

