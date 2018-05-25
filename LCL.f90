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



q = qq/1000.
TT = T
call ZCL(TT,q,XCL,Tcon)




end do
end program lcl


!  ###### subroutine to calculate the dew point #################
	SUBROUTINE TAUP(PTAU,EE)
	E=ALOG10(EE)
	TA=.7333*E*E*E+2.5*E*E+26.35*E+250.54
1     CONTINUE
	Q=373.16/TA
	EA=-7.90298*(Q-1)+5.02808*ALOG10(Q)-1.3816E-7*(10.**(11.344*
	&(1.-1./Q))-1.)+8.1328E-3*(10.**(-3.49149*(Q-1.))-1.)+3.0057149
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
