!PROBLEM JER NEMAMO PODATKE


program Kanjiza
implicit none


integer :: i
integer, parameter :: N = 45653
real, dimension(N) :: tzsr,tzmin,tzmax,padavine,leafWet,tsr,tmin,tmax,rvl,twsr
real, dimension(N) :: twmin,eto,mpvptmax,mpvptmin,ppvptsr,ppvptmin,ppvptmax,&
                      mpvptsr,battery,wetsr,rvlmin,rvlmax,RH,rvsr,tdr
real :: trta,qrta,xrta,tcon
real, dimension(N) :: gama=0.786,alfa,beta,qqsr,cpmass=1.0035,tpt,tqq,br,&
                            l= 2264.705, rvmin,rvmax,wetave,wetmax,wetmin
integer, dimension(N) :: god,mesec,dan,sat
      !tz - temperatura zemljista
      !rvl - relativna vlaznost
      !tw - tacka rose


open (unit = 14, file = "Kanjiza.csv", status="old", action = "read")
open (unit = 15, file = "LCL.csv")
open (unit = 16, file = "Padavine.csv")
open (unit = 17, file = "Bowen.csv")
open (unit = 18, file = "Podaci.csv")

do i = 1, N
read (14,*) god(i),mesec(i),dan(i),sat(i),tzsr(i),tzmin(i),tzmax(i),wetsr(i),wetmin(i),wetmax(i),&
   padavine(i),battery(i),leafWet(i),tsr(i),tmin(i),tmax(i),rvl(i),rvlmin(i),&
   rvlmax(i),twsr(i),twmin(i)

if (tsr(i)>0.and.tmin(i)>0.and.tmax(i)>0.) then
  alfa = 7.5
  beta =237.3
endif

if (tsr(i)<=0.and.tmin(i)<=0.and.tmax(i)<=0.) then
  alfa = 9.5
  beta = 265.5
endif

!relativna vlaznost
RH(i)= 100*(exp(1.8096+(17.2694*twsr(i)/(237.3+twsr(i))))/exp(1.8096+(17.2694*tsr(i)/(237.3+tsr(i)))))

if (rvl(i).eq.-999) then
 rvl(i)=RH(i)
!else 
!	CONTINUE
endif
 
if (twsr(i).EQ.-999)then
 cycle
endif
 
if (padavine(i).eq.-999)then
 cycle
endif

!AKO IZBACUJE GRESKU no implicite tipe, onda promenjljiva nije definisana
!!AKO IZBACUJE GRESKU incompatible ranks , onda promenjljiva pogresno definisana definisana



   !proracun max. pritiska vodene pare pri postojecoj temperaturi
   mpvptsr(i) = 10**(alfa(i)*tsr(i)/(tsr(i)+beta(i))+gama(i))
   !mpvptmin(i) = 10**(alfa(i)*tmin(i)/(tmin(i)+beta(i))+gama(i))
   !mpvptmax(i) = 10**(alfa(i)*tmax(i)/(tmax(i)+beta(i))+gama(i))


   !parcijalni pritiska vodene pare
   ppvptsr(i) = RH(i)*mpvptsr(i)/100
  ! ppvptmin(i) = rvsr(i)*mpvptmin(i)/100
   !ppvptmax(i) = rvsr(i)*mpvptmax(i)/100


   !specificna vlaznost
   qqsr(i)=0.662*(ppvptsr(i)/(1013.15-0.378*ppvptsr(i)))

   
!Bowen ratios
   tpt(i) = (tsr(i+1)-tsr(i))/(24.*3600)
   tqq(i) = (qqsr(i+1)-qqsr(i))/(24.*3600)
   br(i) = (cpmass(i)*tpt(i))/(l(i)*tqq(i))
   
   print *, i

   
if (god(i).eq.2018.and.br(i).ge.-5.and.br(i).le.5.) then
 write(17,*) br(i)
end if
  
  qrta = qqsr(i)
  Trta=tsr(i)
  
print *, i
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
end program Kanjiza


!  ###### subroutine to calculate the dew point #################
	SUBROUTINE TAUP(PTAU,EE)
 
	E=ALOG10(EE)
	TA=.7333*E*E*E+2.5*E*E+26.35*E+250.54
1  CONTINUE
	Q=373.16/TA
	EA=-7.90298*(Q-1)+5.02808*ALOG10(Q)-1.3816E-7*(10.**(11.344*(1.-1./Q))-1.)+8.1328E-3*(10.**(-3.49149*(Q-1.))-1.)+3.0057149
	T=(1.1*(E*E+EA*EA)+2.5*(E+EA)+26.35)*(E-EA)+TA
	IF (ABS(T-TA).LT..001) GOTO 2
	TA=T
  GOTO 1
2  PTAU=T
	RETURN
	END
!  ##############################################################
!  ###### subroutine to get the lifting condensation level ######
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
1  PUK=T**3.5/FAK
! ICT=ICT+1
	CALL TAUP(PTAU,PUK)
	T=PTAU
	IF (ABS(T-TA).LT..001) GOTO 2
	TA=T
! IF(T.LT.0.OR.ICT.GT.100) GO TO 3
	GOTO 1
!C2WRITE(7,*) T,THETAB,P
! PK=1000.*(T/THETAB)**3.5
2  TK=T
	HK=100.464*(TB-T)
  XCL=HK
!C3XCL=-9999.
	RETURN
	END
