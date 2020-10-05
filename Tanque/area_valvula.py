import numpy as np
def valve_opening(turns):
    coeffs = [0.0000, -0.0009, 0.1197, 0.2623]
    return sorted([0, 1, np.polyval(coeffs, turns)])[1]
a = valve_opening(0.0)
print(a)
