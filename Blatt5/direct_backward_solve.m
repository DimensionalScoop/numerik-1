function x = direct_backward_solve(U,z)
  n = length(z);
  x = zeros(length(z));
  for i=n:-1:1
    sum = 0;
    for k=i+1:n
      sum = sum + U(i,k)*x(k);
    end
    x(i) = 1/U(i,i) * (z(i) - sum);
  end
end