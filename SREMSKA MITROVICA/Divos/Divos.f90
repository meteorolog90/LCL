program Divos
implicit none


integer :: i
integer, parameter :: N = 44536
real, dimension(N) :: tzsr,tzmin,tzmax,padavine,leafWet,tsr,tmin,tmax,rvl,twsr
real, dimension(N) :: twmin,eto,mpvptmax,mpvptmin,ppvptsr,ppvptmin,ppvptmax,&
                      mpvptsr,battery,wetsr,rvlmin,rvlmax,RH
real, dimension(N) :: gama=0.786,alfa,beta,qqsr,cpmass=1.0035,tpt,tqq,br,&
                      l= 2264.705, rvmin,rvmax,wetave,wetmax,wetmin,water,water1,&
                      water2,water3,water4,water5,td
integer, dimension(N) :: god,mesec,dan,sat
      !tz - temperatura zemljista
      !rvl - relativna vlaznost
      !tw - tacka rose


open (unit = 14, file = "Divos.csv", status="old", action = "read")
open (unit = 15, file = "Boven.csv")
open (unit = 16, file = "Greska.csv")
open (unit = 17, file = "Podaci.csv")



  do i = 1, N

  read (14,*) god(i),mesec(i),dan(i),sat(i),padavine(i),battery(i),leafWet(i),water(i),&
  water1(i),water2(i),water3(i),water4(i),water5(i),tsr(i),tmin(i),tmax(i),rvl(i),&
  twsr(i),twmin(i),eto(i)


if (tsr(i)>0.and.tmin(i)>0.and.tmax(i)>0.) then
         alfa = 7.5
         beta =237.3
       endif

       if (tsr(i)<=0.and.tmin(i)<=0.and.tmax(i)<=0.) then
         alfa = 9.5
         beta = 265.5
       endif

if (rvl(i).eq.0.) then
  cycle
endif
if (rvl(i).eq.-999)then
  cycle
endif
if (twsr(i).EQ.-999)then
  cycle
endif


!proracun relativne vlaznosti RH

!RH(i)= 100*(exp(1.8096+(17.2694*twsr(i)/(237.3+twsr(i))))/exp(1.8096+(17.2694*tsr(i)/(237.3+tsr(i)))))
  !print *, RH(i)

!if (RH(i).gt.102) then
!  cycle
!endif
       !proracun max. pritiska vodene pare pri postojecoj temperaturi
       mpvptsr(i) = 10**(alfa(i)*tsr(i)/(tsr(i)+beta(i))+gama(i))
       !mpvptmin(i) = 10**(alfa(i)*tmin(i)/(tmin(i)+beta(i))+gama(i))
       !mpvptmax(i) = 10**(alfa(i)*tmax(i)/(tmax(i)+beta(i))+gama(i))

       !parcijalni pritisak vodene pare
       ppvptsr(i) = rvl(i)*mpvptsr(i)/100
       !ppvptmin(i) = rvl(i)*mpvptmin(i)/100
       !ppvptmax(i) = rvl(i)*mpvptmax(i)/100

       !specificna vlaznost (qqsr)
       qqsr(i)=0.662*(ppvptsr(i)/(1013.15-0.378*ppvptsr(i)))


       !Bowen ratios
       tpt(i) = (tsr(i+1)-tsr(i))/(24.*3600)
       tqq(i) = (qqsr(i+1)-qqsr(i))/(24.*3600)
       br(i) = (cpmass(i)*tpt(i))/(l(i)*tqq(i))

       !tacka rose
       !td(i) = beta(i)*(alog(mpvptsr(i))-0.786)/(alfa(i)+0.786-alog(mpvptsr(i)))

       print *, i,tsr(i)

!if (br(i).ge.-5.and.br(i).le.5.) then
 ! write (15,*) god(i),mesec(i),dan(i),sat(i), br(i)
!else 
!  write (16,*) god(i),mesec(i),dan(i),sat(i), br(i)
!endif
      
if (god(i).eq.2018)then
  write (17,*) god(i),mesec(i),dan(i),sat(i), tsr(i),rvl(i),twsr(i)
end if





!if (god(i).eq.2013.and.br(i).ge.-5.and.br(i).le.5.) then
!  write(15,*) br(i)
!end if
      

end do

end program Divos
