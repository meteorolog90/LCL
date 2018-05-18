      program Senta
      implicit none


      integer :: i
      integer, parameter :: N = 45623
      real, dimension(N) :: Soil_aver, Soil_min, Soil_max, Padavine,&
                            tsr,tmin,tmax,rvsr,Dew_aver, Dew_min,eto,mpvptsr,&
                            mpvptmax,mpvptmin,ppvptsr,ppvptmin,ppvptmax
      real, dimension(N) :: gama=0.786,alfa,beta

      integer, dimension(N) :: Battery, Leaf_Wetness, Water1, Water2, Water3, &
                               Water4, Water5, Water6

     !mpvp - max.pritisak vodene pare
     !rvsr - relativna vlaznost
     !tsr,tmin,tmax - srednja,min,max temperatrua
     !ppvp - parcijalni pritisak vodene pare


10    FORMAT (f6.2,f6.2,f6.2)

      open (unit = 10, file = "Senta.csv", status="old", action = "read")
      open (unit = 11, file = "rezultat.csv")


      do i = 1, N

      read (10,*) Soil_aver(i),Soil_min(i),Soil_max(i),Padavine(i),Battery(i),&
                  Leaf_Wetness(i),Water1(i),Water2(i),Water3(i),Water4(i),&
                  Water5(i),Water6(i),tsr(i),tmin(i),tmax(i),&
                  rvsr(i),Dew_aver(i),Dew_min(i)!eto(i)

      if (tsr(i)>0.and.tmin(i)>0.and.tmax(i)>0.) then
        alfa = 7.5
        beta =237.3
      endif

      if (tsr(i)<=0.and.tmin(i)<=0.and.tmax(i)<=0.) then
        alfa = 9.5
        beta = 265.5
      endif

      !proracun max. pritiska vodene pare pri postojecoj temperaturi
      mpvptsr(i) = 10**(alfa(i)*tsr(i)/(tsr(i)+beta(i))+gama(i))
      mpvptmin(i) = 10**(alfa(i)*tmin(i)/(tmin(i)+beta(i))+gama(i))
      mpvptmax(i) = 10**(alfa(i)*tmax(i)/(tmax(i)+beta(i))+gama(i))

      !parcijalni pritisak vodene pare
      ppvptsr(i) = rvsr(i)*mpvptsr(i)/100
      ppvptmin(i) = rvsr(i)*mpvptmin(i)/100
      ppvptmax(i) = rvsr(i)*mpvptmax(i)/100

      !proracun tacke rose
       

      write (11,10) ppvptsr(i)



      end do
      end program Senta
