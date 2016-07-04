import numpy as np
import matplotlib.pyplot as plt

n, x, e, v = np.genfromtxt("Output.txt", unpack=True)

plt.plot(n, e, 'r-', label='Fehler')
plt.title(r'Fehler beim Newtonverfahren')
plt.yscale('log')
plt.xlabel(r'Iterationsschritte')
plt.ylabel(r'absoluter Fehler')

plt.grid()
plt.savefig('PA8.1.pdf')
