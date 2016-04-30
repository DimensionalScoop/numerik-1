1;

function res = polyn(x)
    res = (x-1).^7;
end

function res = horner(x)
    res = ((((((x - 7).*x + 21).*x - 35).*x + 35).*x - 21).*x + 7).*x -1;
end

range = single(0.8:5e-5:1.2);

plot(range, horner(range),'r-',range, polyn(range), 'c-') 