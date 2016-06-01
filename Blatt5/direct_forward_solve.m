function z = direct_forward_solve(L,b)
  n = length(b);
  z = zeros(length(b));
  for i=1:n
    sum = 0;
    for k=1:i-1
      sum = sum + L(i,k)*z(k);
    end
    z(i) = 1/L(i,i) * (b(i) - sum);
  end
end