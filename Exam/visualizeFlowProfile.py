import numpy as np
import matplotlib.pyplot as plt

a = 1.0
z = np.linspace(-a, a, 100)
u = a**2 - z**2
plt.plot(u, z)
plt.axis('Equal')
plt.xlabel('x', fontsize=20)
plt.ylabel('z', fontsize=20)
plt.title('Flow profile', fontsize=20)
plt.legend('u(z)', fontsize=20)
plt.show()
