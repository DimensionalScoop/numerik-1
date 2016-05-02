1;
function y = f(x)
  y = 1 ./ (1+25*(x.^2));
endfunction

function [c] = myNewtonInterpol(x,f)
  n = length(x);
  y(:,1) = f; % first column equals f(x_i)
  % now let's build divided differences
  for j=2:n
    for i=j:n
      % fill a column for each fixed y
      y(i,j) = ( y(i, j-1) - y(i-1,j-1)) / (x(i) - (x(i-j+1)));
    end
  end
  c = diag(y);
endfunction


function [p] = NewtonPolynom(x, x_stuetz, c)
  if (  length(c) != length(x_stuetz)  )
    error ("input data has differing length")
  end
    
  n = length(c);
  p = 0;
  % Script page 25 - definition of N_i(x) (octave only lets us start at N(1) and not N(0) sadly
  N(1) = 1;
  % build N iteratively
  for i = 2:n
    N(i) = N(i-1)*(x-x_stuetz(i-1));
  end
  % now sum up all terms multiplied with corresponding c_i and return this value
  for i = 1:n
    p = p + N(i)*c(i);
  end
    
endfunction

function myNewtonInterpolTest()
  n = [7,12,17];

  %iterate over each n value
  for j = 1:length(n)
    for i = 0:n(j)
      %x_equidistant = (-1 : 2/n : 1)
      x_equidistant(i+1) = -1+2*i/n(j);
      x_tschebyscheff(i+1) = cos( (2*i+1)*pi / (2*n(j)+2) );
    end
    y_equidistant = f(x_equidistant);
    y_tschebyscheff = f(x_tschebyscheff);
    
    %suppress noisy "ans" outputs
    oldpager = PAGER('/dev/null');
    oldpso = page_screen_output(1);
    oldpoi = page_output_immediately(1);
    %calculate Newton coefficients:
    c_equidistant = myNewtonInterpol(x_equidistant, y_equidistant);
    c_tschebyscheff = myNewtonInterpol(x_tschebyscheff, y_tschebyscheff);
    %get back output
    PAGER(oldpager);
    page_screen_output(oldpso);
    page_output_immediately(oldpoi);   
  end
endfunction

function myNewtonInterpolTest()
  clear();
  mkdir("build");
  n = [7,12,17];
  %iterate over each n value
  for j = 1:length(n)
    for i = 0:n(j)
      %x_equidistant = (-1 : 2/n : 1)
      x_equidistant(i+1) = -1+2*i/n(j);
      x_tschebyscheff(i+1) = cos( (2*i+1)*pi / (2*n(j)+2) );
    end
    y_equidistant = f(x_equidistant);
    y_tschebyscheff = f(x_tschebyscheff);
    
    %suppress noisy "ans" outputs
    oldpager = PAGER('/dev/null');
    oldpso = page_screen_output(1);
    oldpoi = page_output_immediately(1);
    %calculate Newton coefficients:
    c_equidistant = myNewtonInterpol(x_equidistant, y_equidistant);
    c_tschebyscheff = myNewtonInterpol(x_tschebyscheff, y_tschebyscheff);
    %get back output
    PAGER(oldpager);
    page_screen_output(oldpso);
    page_output_immediately(oldpoi);
    % PLOTTING
    stepwidth = 2e-2;   % converted from the task
    x = -1:stepwidth:1;
    % I couldn't manage to pass a vector to NewtonPolynom(), I'm sorry
    for i = 1:length(x)
      y_interpol_equidistant(i) = NewtonPolynom(x(i), x_equidistant, c_equidistant);
      y_interpol_tschebyscheff(i) = NewtonPolynom(x(i), x_tschebyscheff, c_tschebyscheff);
    end
    clf();
    newplot ();
    hold on;
    plot(x, f(x), 'g-');
    plot(x_equidistant, y_equidistant, 'r*');
    plot(x_tschebyscheff, y_tschebyscheff, 'b*');
    plot(x, y_interpol_equidistant, 'r-');
    plot(x, y_interpol_tschebyscheff, 'b-');
    %make figures very (!) beautyful
    xlabel ("x");
    h = legend('f(x)', 'Equidistant nodes', 'Tschebyscheff nodes', 'Polynome equidistant', 'Polynome Tschebyscheff');
    legend(h, 'location', 'northeastoutside');
    set (h, 'fontsize', 13);
    %print figure
    filename = ["build/PA2-1-N" int2str(n(j)) ".pdf"];
    print (filename, "-dpdf","-landscape","-S800,400");
    %calculate max error
    maxerror_equidistant = max(abs(f(x) - y_interpol_equidistant));
    maxerror_tscheby = max(abs(f(x) - y_interpol_tschebyscheff));
    %print error
    printf (["n = " int2str(n(j)) "  max. error equivalent: "    mat2str(maxerror_equidistant) "\n"])
    printf (["n = " int2str(n(j)) "  max. error tschebyscheff: " mat2str(maxerror_tscheby) "\n"])    
  end
endfunction

myNewtonInterpolTest();