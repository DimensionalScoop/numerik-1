z = [5,1,2];

test_bw = [1,3,2;0,4,4;0,0,2];
bla = direct_backward_solve(test_bw,z);
test_fw = [1,0,0;2,2,0;1,3,2];
bla2 = direct_forward_solve(test_fw,z);

test_vandermonde = Vandermonde(z);
reference_vander = vander(z);

fprintf('Fehler Vandermonde: ') 
test_vandermonde-reference_vander