'''

    Pretvori generirano zacetno razporeditev atomov v format primeren za LAMMPS;
    predpostavlja: units = real

'''

# vhodni parametri
aa = 33.6
bb = 33.6
cc = 33.6
M  = 39.948

# preberi koordinate
o = open('top.raw', 'r')
crd = []

for line in o:
    atm = []
    b = line.split(' ')
    for elt in b:
        if (elt != ''):
            atm.append(elt)
    crd.append(atm)

# generiraj LAMMPS format
o = open('top.Ar', 'w')
nUnit = len(crd)
o.write('Nakljucna zacetna razporeditev atomov'+'\n')
o.write('\n')
o.write(str(nUnit) + ' ' + 'atoms' + '\n')
o.write('0 bonds' + '\n')
o.write('0 angles' + '\n')
o.write('0 dihedrals' + '\n')
o.write('0 impropers' + '\n')
o.write('\n')
o.write('1 atom types' + '\n')
o.write('\n')
o.write('0.0 ' + str(aa) + ' xlo xhi'+'\n')
o.write('0.0 ' + str(bb) + ' ylo yhi'+'\n')
o.write('0.0 ' + str(cc) + ' zlo zhi'+'\n')
o.write('\n')
o.write('Masses' + '\n')
o.write('\n')
o.write('  1 ' + str(M) + '\n')
o.write('\n')
o.write('Atoms' + '\n')
o.write('\n')

for at in crd:
    x = float(at[1])
    y = float(at[2])
    z = float(at[3])
    o.write('  ' + str(at[0]) + ' 1  ' + str(x) + ' ' + str(y) + ' ' + str(z) + '\n')

o.close()
