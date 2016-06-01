1;

function x = direct_backward_solve(U,z)
  n = length(z);
  x = zeros(length(z));
  sum = 0;
  for i=n:-1:1
    for k=i+1:n
      sum += U(i,k)*x(k);
    endfor
    x(i) = 1/U(i,i) * (z(i) - sum);
  endfor
endfunction

function z = direct_forward_solve(L,b)
  n = length(b);
  x = zeros(length(b));
  sum = 0;
  for i=1:n
    for k=1:i-1
      sum += L(i,k)*x(k);
    endfor
    x(i) = 1/L(i,i) * (b(i) - sum);
  endfor
endfunction

test = [1,3,2;0,4,4;0,0,2];
z = [0,1,2];
test_L = [1,0,0;2,2,0;1,3,2];
bla = direct_backward_solve(test,z);
bla2 = direct_forward_solve(test,z)