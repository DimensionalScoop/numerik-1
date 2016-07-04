#include <iostream>
#include <vector>
#include <cmath>
#include <fstream>

using namespace std;

typedef double (*CallbackType)(double);
typedef vector<double> vec;

static double function(double x){
	return (pow(cos(2*x), 2.0) - pow(x, 2.0));
}

static double derivate_function(double x){
	return (-2*(x+sin(4*x)));
}

void write(vec &x, vec &e, vec &v){
	ofstream file;
	file.open("Output.txt");

	unsigned int n = x.size();
	for(unsigned int i = 0; i < n; i++){
		file << (i+1) << "\t" << x[i] << "\t" << e[i] << "\t" << v[i] << "\n";
	}

	file.close();
	std::cout << "done" << std::endl;
}

void myNewton(CallbackType function, CallbackType derivate, double x0,
		      vec &x, vec &e, vec &v){
	//max 50 iterations
	unsigned int n = 50;
	double eps = 10e-12;
	double err = 1.0;

	//Speedup
	//reserve verhindert das Elemente in der vecstruktur umgespeichert werden m�ssen
	x.reserve(n);
	e.reserve(n);
	v.reserve(n);

	// Iteration.
	for(unsigned int i = 0; i < n; i++){
		if(err < eps){
			break;
		}

		if(i == 0){
			x.push_back(x0 - (function(x0))/(derivate(x0)));
			e.push_back(abs(x[i] - x0));
			v.push_back(function(x[i]));
			err = abs(x[i] - x0);
		}else{
			x.push_back(x[i-1] - (function(x[i-1]))/(derivate(x[i-1])));
			e.push_back(abs(x[i] - x[i-1]));
			v.push_back(function(x[i]));
			err = abs(x[i] - x[i-1]);
		}
	}
}


int main() {
	vec *x = new vec();
	vec *e = new vec();
	vec *v = new vec();

	double x0 = 0.75;

	myNewton(function, derivate_function, x0, *x, *e, *v);
	write(*x, *e, *v);
}


/*
 * c)
 * Der Fehlerverlauf ist quadratisch in dem halblogarithmischen Diagramm, wie auch zu erwarten.
 */
