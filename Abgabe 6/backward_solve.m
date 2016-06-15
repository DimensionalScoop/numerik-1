function x = backward_solve(LU,z)
	[n,n] = size(LU);
	x = zeros(n,1);
	for i=n:-1:1
		x(i) = (z(i) - sum(LU(i,i+1:n)'.*x(i+1:n)))/LU(i,i); 
	end
end
