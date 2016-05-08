% Tested and executable with Octave 4.0.1
1;

function c = myQuadratur1D(f,w,p)
    c = 0;
    for i = 1:1:length(p)-1
        a = p(i);
        b = p(i+1);
        weight = (w(i)+w(i+1))/2;
        
        c += (b-a)*(f(a)+f(b))/2 * weight;
    endfor
    c /= sum(weight);
endfunction

function myQuadratur1DTest()
    disp("Expected Value:")
    1
    disp("Calculated:")
    
    steps = 1000
    myQuadratur1D(@f, ones(steps+1,1),0.5:0.5/steps:1)
endfunction

function y = f(x)
    y = 1/x**2;
endfunction