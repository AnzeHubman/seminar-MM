  !
  !    Compute heat-flux autocorrelation function
  !


program prevodnost
  implicit none

  integer, parameter :: N = 1000000
  integer, parameter :: tau_max = 500000
  real,    parameter :: scale = 6.97426e-16 !6.94785e-16

  integer :: i, dummy1, tau, t
  real    :: dummy2, Sx, Sy, Sz, c, ax
  real, allocatable :: Jx(:), Jy(:), Jz(:)

  allocate(Jx(1:N))
  allocate(Jy(1:N))
  allocate(Jz(1:N))

  ! preberi
  open(unit=11, file="log.lammps-260K-3")
  open(unit=12, file="hacf-260K-3")

  ax = 0.0
  do i = 1, N
     read(11,*) dummy1, dummy2, Jx(i), Jy(i), Jz(i)
     ax = ax + Jx(i)
  end do
  print *, 'Datoteka prebrana.'
  
  
  ! doloci avtokorelacijsko funkcijo
  do tau = 1, tau_max
     print *, tau
     Sx = 0.0
     Sy = 0.0
     Sz = 0.0
     c  = 0.0

     do t = 0, N-tau
        Sx = Sx + Jx(t)*Jx(t+tau)*scale*scale
        Sy = Sy + Jy(t)*Jy(t+tau)*scale*scale
        Sz = Sz + Jz(t)*Jz(t+tau)*scale*scale
        c  = c + 1.0
     end do

     Sx = Sx/c
     Sy = Sy/c
     Sz = Sz/c

     write(12,*) (tau-1), (1.0/3.0)*(Sx + Sy + Sz)
  end do

  close(unit=11)
  close(unit=12)
  deallocate(Jx)
  deallocate(Jy)
  deallocate(Jz)

end program prevodnost
