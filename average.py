import numpy as np


T = [160,180,200,220,240,260]

for i in range(len(T)):

    data_1 = np.loadtxt('kappa-'+str(T[i])+'K-1')
    data_2 = np.loadtxt('kappa-'+str(T[i])+'K-2')
    data_3 = np.loadtxt('kappa-'+str(T[i])+'K-3')

    time    = data_1[:,0].tolist()
    kappa_1 = data_1[:,1].tolist()
    kappa_2 = data_2[:,1].tolist()
    kappa_3 = data_3[:,1].tolist()

    f = open('kappa-'+str(T[i]), 'w')

    for j in range(len(time)):

        average_kappa = (kappa_1[j] + kappa_2[j] + kappa_3[j])/3.0
        sigma_1       = abs(average_kappa - kappa_1[j])
        sigma_2       = abs(average_kappa - kappa_2[j])
        sigma_3       = abs(average_kappa - kappa_3[j])
        sigma         = max([sigma_1, sigma_2, sigma_3])

        f.write(str(time[j]) + ' ' + str(average_kappa) + ' ' + str(sigma) + '\n')

    f.close()
