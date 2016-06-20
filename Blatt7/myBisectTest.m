x00 = 0;
x0 = 0.75;

[x,e,v] = myBisect(@f,x00,x0);

iterations = 1:length(e);

semilogy(iterations, e);
xlabel('i');
ylabel('|e|');
grid on;

% c )
% Der Plot zeigt klar, dass der Fehler pro 20 Iterationsschritte um 6
% Zehnerpotenzen abnimmt. Dies entspricht genau der Erwartung aus der
% Theorie. Nebenbei bemerkt ist der Fehler unabhängig von der jeweiligen
% Funktion.