!  =========================================================================
!  Generira nakljucno razporeditev atomov v ortogonalni simulacijski skatli;
!  bliznji kontakti izkljuceni
!  =========================================================================

program argon
  implicit none

  real*8, parameter  :: aa = 33.6d0      ! robovi skatle
  real*8, parameter  :: bb = 33.6d0
  real*8, parameter  :: cc = 33.6d0
  integer, parameter :: N  = 864         ! stevilo atomov
  real*8, parameter  :: Rc = 2.5d0       ! minimalna razdalja med atomoma 
  real*8, allocatable :: x(:),y(:),z(:)

  real*8 :: dx, dy, dz, d, dmin, xt, yt, zt
  integer :: j, k

  allocate(x(1:N), y(1:N), z(1:N))

  open(unit=11, file="top.raw")

  j = 1
  do while (j .le. N)

     ! dodaj 1. delec
     if (j == 1) then
        call random_number(xt)
        call random_number(yt)
        call random_number(zt)
        xt = aa*xt
        yt = bb*yt
        zt = cc*zt
        x(j) = xt
        y(j) = yt
        z(j) = zt
        j = j + 1
     end if

     ! dodaj N-1 delcev
     if (j > 1) then
        call random_number(xt)
        call random_number(yt)
        call random_number(zt)
        xt = aa*xt
        yt = bb*yt
        zt = cc*zt
        dmin = sqrt((aa/2.0d0)**2 + (bb/2.0d0)**2 + (cc/2.0d0)**2)

        do k = 1, j-1

           ! x
           dx = abs(x(k)-xt)
           if (dx > 0.5d0*aa) then
              dx = dx - aa
           end if

           ! y
           dy = abs(y(k)-yt)
           if (dy > 0.5d0*bb) then
              dy = dy - bb
           end if

           ! z
           dz = abs(z(k)-zt)
           if (dz > 0.5d0*cc) then
              dz = dz - cc
           end if

           d = sqrt(dx**2 + dy**2 + dz**2)

           if (d < dmin) then
              dmin = d
           end if
           
        end do

        if (dmin >= Rc) then
           if (mod(j,1000) == 0) then
              print *, j
           end if

           x(j) = xt
           y(j) = yt
           z(j) = zt
           j = j + 1
        end if
     end if

  end do

  ! shrani v datoteko
  do k = 1, N
     write(11,*) k, x(k), y(k), z(k)
  end do

  close(unit=11)
end program argon
