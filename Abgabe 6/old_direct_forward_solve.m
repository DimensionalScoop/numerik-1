function z = old_direct_forward_solve(L,b)
	[n,n] = size(L);
	z = zeros(n,1);
	for i=1:n
		z(i) = (b(i) - sum(L(i,1:i-1)'.*z(1:i-1)))/L(i,i); 
	end
end

