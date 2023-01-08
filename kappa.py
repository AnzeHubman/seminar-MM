import numpy as np

T = input('T = ')

temp    = float(T)
V       = 33.6*33.6*33.6*1.0e-30
dt      = 4.0e-15
kb      = 1.3806504e-23

prefactor = dt/(V*kb*temp**2)

data1 = np.loadtxt('hacf-'+str(T)+'K-3')

t = data1[:,0]
h = data1[:,1]

t_new = t*0.004
h_new = h[:]#/h[0]

data2 = np.loadtxt('log.lammps-'+T+'K-3',usecols=(1))

prefactor = dt/(V*kb*temp**2)

g = open('hacf-primer', 'w')
q = open('kappa-'+str(T)+'K-3', 'w')

for i in range(500000):
    g.write(str(t_new[i]) + ' ' + str(h_new[i]) + '\n')

g.close()

for i in range(5000):
    S = 0.0
    for j in range(i):
        S += h[j]

    q.write(str(i*4/1000) + ' ' + str(prefactor*S) + '\n')
    
