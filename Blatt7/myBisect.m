function [x,e,v]=myBisect(f,x00,x0)
  x = [];
  v = [];
  e = [];
  e(1) = 1;
  a = x00;
  b = x0;
  % den Fall abfangen dass eine Nullstelle am Intervallrand liegt
  if (f(b) == 0)
    x(1) = b;
    e(1) = 0;
    v(1) = f(x(1));
    return;
  end
  if (f(a) == 0)
    x(1) = a;
    e(1) = 1;
    v(1) = f(x(1));
    return;
  end
  
  % Prüfen ob überhaupt eine Nullstelle in dem Intervall zu erwarten ist
  % natürlich kann es sein, dass innerhalb des Intervalls auch mehrere Nullstellen liegen, so dass die Funktionswerte an den Rändern
  % auch gleiches Vorzeichen haben können, aber diesen Fall schließen wir hier obligatorisch aus
  if (sign(f(x00)) ~= sign(f(x0)) )
    i = 1;
    while e(end) >= 10^(-12)
      x(i) = 0.5*(b + a);
      v(i) = f(x(end));
      if (i == 1)
          e(i) = b-a;
      else
          e(i) = abs(x(end) - x(end-1));
      end
      if (sign(a) ~= sign(v(end)) )
        b = x(end);
      else
        a = x(end);
      end
      i = i + 1;
      e(end)
    end
  end
end

function s = sign(x)
  if (x<0)
    s = -1;
  else
    s = 1;
  end
end