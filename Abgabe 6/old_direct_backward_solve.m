function x = old_direct_backward_solve(U,z)
	[n,n] = size(U);
	x = zeros(n,1);
	for i=n:-1:1
		x(i) = (z(i) - sum(U(i,i+1:n)'.*x(i+1:n)))/U(i,i); 
	end
end
