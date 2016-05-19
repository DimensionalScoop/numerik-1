function myQuadraturSum1DTest()
    a = -1;
    b = 1;
    N = 100;
    
    % Exaktes Ergebnis
    exact_result = 2/5*atan(5)
    
    % Anlegen der benötigten Arrays
    result_trapez = zeros(N,1);
    result_simpson = zeros(N,1);
    result_3_8 = zeros(N,1);
    
    % Gewichte und Stützstellen für die verschiedenen Verfahren
    w_tr = [0.5 , 0.5];
    p_tr = linspace(0,1,2);   % Stützstellen auf dem Einheitsintervall
    w_si = [1/6 , 2/3 , 1/6];
    p_si = linspace(0,1,3);
    w_3_8 = [1/8 , 3/8 , 3/8 , 1/8];
    p_3_8 = linspace(0,1,4);
    
    % Für jedes n aus [1,100] die aufsummierten Integrationsformeln
    % auswerten und abspeichern
    for n = 1:1:N
        result_trapez(n) = myQuadraturSum1D(@f, w_tr, p_tr, a, b, n);
        result_simpson(n) = myQuadraturSum1D(@f, w_si, p_si, a, b, n);
        result_3_8(n) = myQuadraturSum1D(@f, w_3_8, p_3_8, a, b, n);
    end
    
    %Plot
    figure
    semilogy(linspace(1,N,N), abs(result_trapez-exact_result)/exact_result);
    hold
    semilogy(linspace(1,N,N), abs(result_simpson-exact_result)/exact_result);
    semilogy(linspace(1,N,N), abs(result_3_8-exact_result)/exact_result);
    legend('Trapezregel','Simpsonregel', '3/8 Regel')
    xlabel('n')
    ylabel('rel. Fehler')
end

function y = f(x)
    y = 1/(1+25*x*x);
end
