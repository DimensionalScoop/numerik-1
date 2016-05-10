% Tested and executable with Octave 4.0.1
1;

function c = myQuadratur1D(f,w,p)
    c = 0;
    for i = 1:1:length(p) 
        c += w(i)*feval(f,p(i));
    endfor
    c *= (p(length(p)) - p(1));
endfunction

function myQuadratur1DTest()
    a = 0.5;
    b = 1;
    disp("Expected Value: ")
    1
    disp("Calculated with n=1 (Trapezoidal rule): ")
    w = [0.5 , 0.5];
    p = linspace(a,b,2);
    myQuadratur1D(@f, w, p)
    
    disp("Calculated with n=2 (Simpson rule): ")
    w = [1/6 , 2/3 , 1/6];
    p = linspace(a,b,3);
    myQuadratur1D(@f, w, p)
    
    disp("Calculated with n=3 (3/8 rule): ")
    w = [1/8 , 3/8 , 3/8 , 1/8];
    p = linspace(a,b,4);
    myQuadratur1D(@f, w, p)
endfunction

function y = f(x)
    y = 1/x**2;
endfunction

myQuadratur1DTest()