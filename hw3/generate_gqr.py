#!/usr/bin/env python2
import os.path
import numpy as np
from numpy.polynomial.legendre import leggauss
from numpy.polynomial.hermite import hermgauss

lg_ns = map(lambda i: 2**i, range(3, 8))
for n in lg_ns:
    (lg_x, lg_w) = leggauss(n)
    fname = os.path.join('matlab', 'lg_weights_%d.csv' % n)
    np.savetxt(fname, np.column_stack((lg_x, lg_w)), delimiter=', ')

hg_ns = map(lambda i: 2**i, range(2, 6))
for n in hg_ns:
    (hg_x, hg_w) = hermgauss(n)
    fname = os.path.join('matlab', 'hg_weights_%d.csv' % n)
    np.savetxt(fname, np.column_stack((hg_x, hg_w)), delimiter=', ')
