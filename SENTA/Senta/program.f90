      program Senta
      implicit none


      integer :: i
      integer, parameter :: N = 45623
      real, dimension(N) :: tzsr,tzmin,tzmax,padavine,tsr,tmin,tmax,rvsr,twsr,twmin,mpvptsr,&
                            mpvptmax,mpvptmin,ppvptsr,ppvptmin,ppvptmax
      real, dimension(N) :: gama=0.786,alfa,beta,qqsr,cpmass=1.0035,tpt,tqq,br,&
                            l= 2264.705

      integer, dimension(N) :: Battery,LeafWet,Wate1,Wate2,Wate3,&
                               Wate4,Wate5,Wate6,god,mesec,dan,sat

     !mpvp - max.pritisak vodene pare
     !rvsr - relativna vlaznost
     !tsr,tmin,tmax - srednja,min,max temperatrua
     !ppvp - parcijalni pritisak vodene pare


10    FORMAT (f6.2,f6.2,f6.2)

      open (unit = 10, file = "Senta.csv", status="old", action = "read")
      open (unit = 11, file = "Boven.csv")
      open (unit = 12, file = "Boven2018.csv")
    



      do i = 1, N

      read (10,*) god(i),mesec(i),dan(i),sat(i),tzsr(i),tzmin(i),tzmax(i),padavine(i),Battery(i),&
        LeafWet(i),Wate1(i),Wate2(i),Wate3(i),Wate4(i),Wate5(i),Wate6(i),tsr(i),tmin(i),tmax(i),&
        rvsr(i),twsr(i),twmin(i)

      if (tsr(i)>0.and.tmin(i)>0.and.tmax(i)>0.) then
        alfa = 7.5
        beta =237.3
      endif

      if (tsr(i)<=0.and.tmin(i)<=0.and.tmax(i)<=0.) then
        alfa = 9.5
        beta = 265.5
      endif


if (rvsr(i).eq.0.) then
	cycle
  endif
  if  (rvsr(i).EQ.-999.and.twsr(i).EQ.-999.and.tsr(i).EQ.-999.)then
	cycle
  endif

      !proracun max. pritiska vodene pare pri postojecoj temperaturi
      mpvptsr(i) = 10**(alfa(i)*tsr(i)/(tsr(i)+beta(i))+gama(i))
     ! mpvptmin(i) = 10**(alfa(i)*tmin(i)/(tmin(i)+beta(i))+gama(i))
     ! mpvptmax(i) = 10**(alfa(i)*tmax(i)/(tmax(i)+beta(i))+gama(i))

      !parcijalni pritisak vodene pare
      ppvptsr(i) = rvsr(i)*mpvptsr(i)/100
     ! ppvptmin(i) = rvsr(i)*mpvptmin(i)/100
     ! ppvptmax(i) = rvsr(i)*mpvptmax(i)/100

      !specificna vlaznost (qqsr)
      qqsr(i)=0.662*(ppvptsr(i)/(1000-0.378*ppvptsr(i)))


      !Bowen ratios
      tpt(i) = (tsr(i+1)-tsr(i))/(24.*3600)
      tqq(i) = (qqsr(i+1)-qqsr(i))/(24.*3600)
      br(i) = (cpmass(i)*tpt(i))/(l(i)*tqq(i))

      

if (god(i).eq.2018.and.br(i).ge.-5.and.br(i).le.5) then 
  write (12,*) god(i),mesec(i),dan(i),sat(i),br(i)
  write (11,*) br(i)
else
  continue
end if
     ! write (11,FMT="(3(f10.2,5x))")  br(i)
      !write (11,*) i,god(i),mesec(i),dan(i),sat(i), br(i)

print *, i

      end do
      end program Senta
