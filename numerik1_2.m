% Getestet und lauffähig in Octave 4.0.1
1;

function res = polyn(x)
    res = (x-1).^7;
end

function res = horner(x)
    res = ((((((x - 7).*x + 21).*x - 35).*x + 35).*x - 21).*x + 7).*x -1;
end

range = single(0.8:5e-5:1.2);

plot(range, horner(range),'r-',range, polyn(range), 'c-') 

% Die polyn(x)-Methode ist gut konditioniert, da sie nur eine Addition durchführt
% (die schlecht konditioniert sein kann) und dann sieben mal multipliziert (was 
% gut konditioniert ist).
%
% Die horner(x)-Methode ist im Vergleich dazu schlechter konditioniert, da sie 
% sieben Additionen und sechs Multiplikationen durchführen muss. Insbesondere kommen
% in dem gewählten Intervall besonders viele Addition vor, bei denen zwei fast gleich
% große Zahlen voneinander abgezogen werden (besonders schlecht konditioniert).
% Rundungsfehler machen sich hier als besonders deutlich bemerkbar und sorgen für
% den unterwarteten Kurvenverlauf.