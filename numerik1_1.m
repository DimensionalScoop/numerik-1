% Getestet und lauffähig in Octave 4.0.1

format long

function ret = a(x,n)
  vals = [];
  for k = 0:n
    vals(k+1) = x^k/factorial(k);
  end
  ret = sum(vals);
end

function ret = b(x,n)
  ret = 1/a(-x,n);
end

function ret = c(x,n)
  ret = b(x/11,n)^11;
end


x = -5.5;
a_res=[];
b_res=[];
c_res=[];

display("Methode a:")
for n = 3:3:30
  a_res(n/3) = a(x,n);
end

display("Methode b:")
for n = 3:3:30
  b_res(n/3) = b(x,n);
end

display("Methode c:")
for n = 3:3:30
  c_res(n/3) = c(x,n);
end

a_res
b_res
c_res

display("Vergleich: ")
0.0040867714

plot(a_res, 'r-', b_res, 'b-', c_res, 'c-');

% Nach 30 Durchläufen erreicht a die Genauigkeit der Vorgabe. b konvergiert schneller,
% c am schnellsten gegen diesen Wert.
% a schwankt bei wenigen Schritten sehr stark und konvergiert nicht monoton, da 
% zu beginn die Exponentialfunktion viel größere Werte liefert als die Fakultät.
% b konvergiert monoton, da der der Exponent nicht mehr negativ ist.
% c erreicht schon bei wenigen Schritten eine große Genauigkeit, da hier ein Teil
% der Berechnung 'ausgelagert' wird: Das Exponentieren mit einem natürlichen 
% Exponenten ist gut konditioniert, die richtige Größenordnung des Ergebnisses wird
% schneller erreicht.