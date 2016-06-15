% Tested and executable in Octave 4.0.2

function LU = LU_decompose(A)
	% we assume that A is regular
	[n,n] = size(A);
    
    L = eye(n); % initialize with unit matrix
    R = zeros(n); % set size for R...
    R(1, :) = A(1, :); % ... and then initialize first row
    for j = 2:n
        L(j, 1) = 1 / R(1, 1) * A(j, 1) ; % normalize and fill first column of U
    end

    % using iterative algorithm as explained
    % in the lecture notes on p. 128
    for j=2:n
        for k=j:n
            R(j,k) = A(j,k) - L(j,1:(j-1))*R(1:(j-1),k);
        end
        for k=(j+1):n
            L(k,j) = 1 / R(j,j) * (A(k,j) - L(k,1:(j-1))*R(1:(j-1),j));
        end
    end
    
    LU = L + R - eye(n); % remove unit matrix and return reduced matrix
end