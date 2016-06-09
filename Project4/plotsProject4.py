import numpy as np
import matplotlib.pyplot as plt
from math import *

r = np.linspace(0.9, 3, 500)
U = 4*((1.0/r)**12 - (1.0/r)**6)
plt.plot(r, U)
plt.xlabel('r', fontsize=20)
plt.ylabel('U', fontsize=20)
plt.title(r'Lennard-Jones potential for $\sigma = \epsilon = 1$', fontsize=20)
plt.show()
