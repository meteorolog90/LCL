program lcl
implicit none


integer :: i,j
integer, parameter :: N = 45623
real, dimension(N) :: Soil_aver,Soil_min,Soil_max,Padavine,&
                      tsr,tmin,tmax,rvsr,Dew_aver,Dew_min,eto,mpvptsr,&
                      mpvptmax,mpvptmin,ppvptsr,ppvptmin,ppvptmax
real, dimension(N) :: gama=0.786,alfa,beta,zlcl,zk,k,Tlcl,lclB,zo=0.5,Gs=0.0065
real, dimension(N) :: HLCL

integer, dimension(N) :: Battery, Leaf_Wetness, Water1, Water2, Water3, &
                         Water4, Water5, Water6

!mpvp - max.pritisak vodene pare
!rvsr - relativna vlaznost
!tsr,tmin,tmax - srednja,min,max temperatrua
!ppvp - parcijalni pritisak vodene pare


10    FORMAT (f6.1,f6.1,f6.1,f6.1)

open (unit = 10, file = "Senta.csv", status="old")
open (unit = 11, file = "lcl.csv")


do i = 1, N

read (10,*) Soil_aver(i),Soil_min(i),Soil_max(i),Padavine(i),Battery(i),&
            Leaf_Wetness(i),Water1(i),Water2(i),Water3(i),Water4(i),&
            Water5(i),Water6(i),tsr(i),tmin(i),tmax(i),&
            rvsr(i),Dew_aver(i),Dew_min(i)!eto(i)




!epsy metod
zlcl(i) = 125*ABS(tsr(i)-Dew_aver(i))
zk(i) = 4000*((100-rvsr(i))/(100+rvsr(i)))

!BARNES METOD

k(i) = 0.001296*Dew_aver(i) + 0.1963
Tlcl(i) = Dew_aver(i)-k(i)*(tsr(i)-Dew_aver(i))

lclB(i) = zo(i)+ABS(tsr(i)-Tlcl(i))/Gs(i)

!Lanrence(2005)

HLCL(i) = zo(i)+ (20+(tsr(i)/5))*100*(1-(rvsr(i)/100))

write (11, FMT="(3(F10.2,5x))") HLCL(i), zlcl(i), lclB(i)
! 3: tri kolone, F10.2: 10 cifarni broj sa 2 broja iza zareza, 5x razmak između kolona


end do
end program lcl
