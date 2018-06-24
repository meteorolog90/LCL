program lcl
implicit none


integer :: i,j
real, parameter :: ps = 1013.15
integer, parameter :: N = 45623
real, dimension(N) :: tzsr,tzmin,tzmax,padavine,tsr,tmin,tmax,rvl,twsr,twmin,mpvptsr,&
                      mpvptmax,mpvptmin,ppvptsr,ppvptmin,ppvptmax,br
real, dimension(N) :: gama=0.786,alfa,beta,zlcl,zk,k,Tlcl,lclB,zo=0.5,Gs=0.0065
real, dimension(N) :: HLCL,qqsr,qq,tqq,l= 2264.705,tpt,cpmass=1.0035
integer, dimension(N) :: Battery,LeafWet,Wate1,Wate2,Wate3,&
                         Wate4,Wate5,Wate6,god,mesec,dan,sat
real :: trta,qrta,xrta,tcon
!mpvp - max.pritisak vodene pare
!rvsr - relativna vlaznost
!tsr,tmin,tmax - srednja,min,max temperatrua
!ppvp - parcijalni pritisak vodene pare


!10    FORMAT (f6.1,f6.1,f6.1,f6.1)

open (unit = 10, file = "Senta.csv", status="old")
open (unit = 17, file = "Podaci.csv")
open (unit = 12, file = "LCL.csv")
open (unit = 13, file = "padavine.csv")
open (unit = 19, file = "Greska.csv")





do i = 1, N
read (10,*) god(i),mesec(i),dan(i),sat(i),tzsr(i),tzmin(i),tzmax(i),padavine(i),Battery(i),&
            LeafWet(i),Wate1(i),Wate2(i),Wate3(i),Wate4(i),Wate5(i),Wate6(i),tsr(i),tmin(i),tmax(i),&
            rvl(i),twsr(i),twmin(i)




!epsy metod
!zlcl(i) = 125*ABS(tsr(i)-Dew_aver(i))
!zk(i) = 4000*((100-rvsr(i))/(100+rvsr(i)))

!BARNES METOD

!k(i) = 0.001296*Dew_aver(i) + 0.1963
!Tlcl(i) = Dew_aver(i)-k(i)*(tsr(i)-Dew_aver(i))

!lclB(i) = zo(i)+ABS(tsr(i)-Tlcl(i))/Gs(i)

!Lanrence(2005)

!HLCL(i) = zo(i)+ (20+(tsr(i)/5))*100*(1-(rvsr(i)/100))


!write (12, FMT="(3(F10.2,5x))")  lclB(i)
!write (13, FMT="(3(F10.2,5x))") zlcl(i)
! 3: tri kolone, F10.2: 10 cifarni broj sa 2 broja iza zareza, 5x razmak između kolona


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
  if  (rvl(i).EQ.-999.and.twsr(i).EQ.-999.and.tsr(i).EQ.-999.)then
	cycle
  endif

!proracun max. pritiska vodene pare pri postojecoj temperaturi
mpvptsr(i) = 10**(alfa(i)*tsr(i)/(tsr(i)+beta(i))+gama(i))
!mpvptmin(i) = 10**(alfa(i)*tmin(i)/(tmin(i)+beta(i))+gama(i))
!mpvptmax(i) = 10**(alfa(i)*tmax(i)/(tmax(i)+beta(i))+gama(i))


!parcijalni pritiska vodene pare
ppvptsr(i) = rvl(i)*mpvptsr(i)/100
!ppvptmin(i) = rvl(i)*mpvptmin(i)/100
!ppvptmax(i) = rvl(i)*mpvptmax(i)/100


!specificna vlaznost
qqsr(i)=0.662*(ppvptsr(i)/(1013.15-0.378*ppvptsr(i)))

!Bowen ratios
tpt(i) = (tsr(i+1)-tsr(i))/(24.*3600)
tqq(i) = (qqsr(i+1)-qqsr(i))/(24.*3600)
br(i) = (cpmass(i)*tpt(i))/(l(i)*tqq(i))

!qq= ppvptsr(i)/ps(i)

qrta = qqsr(i)
Trta=tsr(i)


if (br(i).ge.-5.and.br(i).le.5.) then
	write(17,*) br(i)
  else
  write (19,*) i,god(i),mesec(i),dan(i),sat(i),br(i)
  end if

call ZCL(Trta,qrta,Xrta,Tcon)


if (god(i).eq.2018.) then 
	write (12,*) Xrta
	write (13,*) padavine(i)
	!write (11,*) god(i),mesec(i),dan(i),sat(i),Xrta,padavine(i)
  else 
	continue

print *, i,god(i),mesec(i),dan(i),sat(i), xrta
  end if

if (god(i).eq.2018)then
 write (18,*) god(i),mesec(i),dan(i),sat(i), tsr(i),rvl(i),twsr(i),Xrta,padavine(i),br(i)
end if     
		
end do
end program lcl


!  ###### subroutine to calculate the dew point #################
	SUBROUTINE TAUP(PTAU,EE)
 !real, dimensio(N) :: TA,E,Q,EA,T,PTAU




	E=ALOG10(EE)
	TA=.7333*E*E*E+2.5*E*E+26.35*E+250.54
1     CONTINUE
	Q=373.16/TA
	EA=-7.90298*(Q-1)+5.02808*ALOG10(Q)-1.3816E-7*(10.**(11.344*(1.-1./Q))-1.)+8.1328E-3*(10.**(-3.49149*(Q-1.))-1.)+3.0057149
	T=(1.1*(E*E+EA*EA)+2.5*(E+EA)+26.35)*(E-EA)+TA
	IF (ABS(T-TA).LT..001) GOTO 2
	TA=T
        GOTO 1
2     PTAU=T
	RETURN
	END
!  ##############################################################
!  ###### subroutine to get the lifting condensation level ######
! T in C or K; Q in ??, XCL in m, TK in C?
	SUBROUTINE ZCL(T,Q,XCL,TK)
!       ICT=0
	P=860.
	TN=273.16
	IF (T.GT.100.) TN=0.
	TT=T
	T=TT+TN
!       write(6,*)t,tt
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
1     PUK=T**3.5/FAK
!       ICT=ICT+1
	CALL TAUP(PTAU,PUK)
	T=PTAU
	IF (ABS(T-TA).LT..001) GOTO 2
	TA=T
!       IF(T.LT.0.OR.ICT.GT.100) GO TO 3
	GOTO 1
!C2      WRITE(7,*) T,THETAB,P
!       PK=1000.*(T/THETAB)**3.5
2     TK=T
	HK=100.464*(TB-T)
        XCL=HK
!C3      XCL=-9999.
	RETURN
	END
