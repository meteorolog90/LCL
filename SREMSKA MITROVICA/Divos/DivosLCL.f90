program DivosLCL
implicit none


integer :: i
integer, parameter :: N = 44536
real, dimension(N) :: tzsr,tzmin,tzmax,padavine,leafWet,tsr,tmin,tmax,rvl,twsr
real, dimension(N) :: twmin,eto,mpvptmax,mpvptmin,ppvptsr,ppvptmin,ppvptmax,&
              mpvptsr,battery,wetsr,rvlmin,rvlmax,RH
real, dimension(N) :: gama=0.786,alfa,beta,qqsr,cpmass=1.0035,tpt,tqq,br,&
                      l= 2264.705, rvmin,rvmax,wetave,wetmax,wetmin,water,water1,&
                      water2,water3,water4,water5,td
real :: trta,qrta,xrta,tcon
integer, dimension(N) :: god,mesec,dan,sat
      !tz - temperatura zemljista
      !rvl - relativna vlaznost
      !tw - tacka rose
open (unit = 14, file = "Divos.csv", status="old", action = "read")
open (unit = 15, file = "LCL.csv")
open (unit = 16, file = "Padavine.csv")
open (unit = 18, file = "Podaci.csv")


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


if (rvl(i).eq.-999) then
  cycle
endif

if (rvl(i).eq.0.) then
  cycle
endif

if (twsr(i).EQ.-999)then
  cycle
endif


!RH(i)= 100*(exp(1.8096+(17.2694*twsr(i)/(237.3+twsr(i))))/exp(1.8096+(17.2694*tsr(i)/(237.3+tsr(i)))))
!if (RH(i).gt.102) then
!  cycle
!endif

!proracun max. pritiska vodene pare pri postojecoj temperaturi
mpvptsr(i) = 10**(alfa(i)*tsr(i)/(tsr(i)+beta(i))+gama(i))
!parcijalni pritisak vodene pare
ppvptsr(i) = rvl(i)*mpvptsr(i)/100
!specificna vlaznost (qqsr)
qqsr(i)=0.662*(ppvptsr(i)/(1013.15-0.378*ppvptsr(i)))

tpt(i) = (tsr(i+1)-tsr(i))/(24.*3600)
tqq(i) = (qqsr(i+1)-qqsr(i))/(24.*3600)
br(i) = (cpmass(i)*tpt(i))/(l(i)*tqq(i))


qrta = qqsr(i)
Trta=tsr(i)
print *, rvl(i),twsr(i)
call ZCL(Trta,qrta,Xrta,Tcon)


if (god(i).eq.2018.) then 
write (15,*) Xrta
write (16,*) padavine(i)
                
else 
continue
                
end if
if (god(i).eq.2018)then
  write (18,*) god(i),mesec(i),dan(i),sat(i), tsr(i),rvl(i),twsr(i),Xrta,padavine(i),br(i)
end if  


end do
end program DivosLCL


!  ###### subroutine to calculate the dew point #################
SUBROUTINE TAUP(PTAU,EE)
E=ALOG10(EE)
TA=.7333*E*E*E+2.5*E*E+26.35*E+250.54
1     CONTINUE
Q=373.16/TA
EA=-7.90298*(Q-1)+5.02808*ALOG10(Q)-1.3816E-7*(10.**(11.344*(1.-1./Q))-1.)+8.1328E-3*(10.**(-3.49149*(Q-1.))-1.)+3.0057149
T=(1.1*(E*E+EA*EA)+2.5*(E+EA)+26.35)*(E-EA)+TA
 IF (ABS(T-TA).LT..001) GOTO 2
	TA=T
 GOTO 1
 2 PTAU=T
 	RETURN
 	END
 !##############################################################
 !###### subroutine to get the lifting condensation level ######
 ! T in C or K; Q in ??, XCL in m, TK in C?
 	SUBROUTINE ZCL(T,Q,XCL,TK)
 ! ICT=0
 	P=860.
 	TN=273.16
 	IF (T.GT.100.) TN=0.
 	TT=T
 	T=TT+TN
 ! write(6,*)t,tt
 	AKAP=.28571
 	TB=T
 	EB=P*Q/(.622+Q)
 	FAK=T**3.5/EB
 	CALL TAUP(PTAU,EB)
 	TAU=PTAU
 ! THETAB=TT*(1000./P)**AKAP
 THETAB=T*(1000./P)**AKAP
 	T=T-1.224*(T-TAU)
 	TA=T
 1 PUK=T**3.5/FAK
 ! ICT=ICT+1
 	CALL TAUP(PTAU,PUK)
 	T=PTAU
 	IF (ABS(T-TA).LT..001) GOTO 2
 	TA=T
 ! IF(T.LT.0.OR.ICT.GT.100) GO TO 3
 	GOTO 1
 !C2WRITE(7,*) T,THETAB,P
 ! PK=1000.*(T/THETAB)**3.5
 2 TK=T
 	HK=100.464*(TB-T)
 XCL=HK
 !C3XCL=-9999.
 	RETURN
 	END
