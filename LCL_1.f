	program LCL_1

	integer day
	real TT,qq
	character*2 locl(2)
c	character*2 locl(1)
	character*4 gn(5),g
  	character*13 flnm1
  	character*17 flnm2

       data locl/'SK', 'VV'/
c        data locl/'IR'/

	do i=1,2
c	do i=1,1

	do j=2012,2016

	write (g,'(i4)') j
	gn(j)=g

	flnm1=locl(i)//gn(j)//'T_q.dat'
	flnm2=locl(i)//gn(j)//'T_q_LCL.dat'

	open (555,file=flnm1)
	open (6,file=flnm2)

c  ##############################################################
	 
 1	read(555,'(i5, 2f10.2)') day,T,qq

c	print *,'prosao2',day

	if (T.eq.-999.or.qq.eq.-999.)then
	XCL=0.
      goto 2
	else
	endif

	q=qq/1000.
	TT=T
	call zcl(TT,q,XCL,Tcon)
cbr	print*,' T,q,LCL,Tcon',day,T,qq,XCL,Tcon
c	print*,' T,q,LCL,Tcon',day,T,qq,XCL
2	write (6,'(i5, 3f10.2)')	day,T,qq,XCL

c	print *,day
	if(day.lt.367)then
	goto 1
	else
	endif
		print *,'prosao1'

	enddo

	enddo


	end
c  ###### subroutine to calculate the dew point #################
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
c  ##############################################################
c  ###### subroutine to get the lifting condensation level ######
c T in C or K; Q in ??, XCL in m, TK in C?
	SUBROUTINE ZCL(T,Q,XCL,TK)
C       ICT=0
	P=860.
	TN=273.16
	IF (T.GT.100.) TN=0.
	TT=T
	T=TT+TN
C       write(6,*)t,tt       
	AKAP=.28571
	TB=T
	EB=P*Q/(.622+Q)
	FAK=T**3.5/EB
	CALL TAUP(PTAU,EB)
	TAU=PTAU
C THETAB=TT*(1000./P)**AKAP
        THETAB=T*(1000./P)**AKAP
	T=T-1.224*(T-TAU)
	TA=T
1     PUK=T**3.5/FAK
C       ICT=ICT+1
	CALL TAUP(PTAU,PUK)
	T=PTAU
	IF (ABS(T-TA).LT..001) GOTO 2
	TA=T
C       IF(T.LT.0.OR.ICT.GT.100) GO TO 3
	GOTO 1
C2      WRITE(7,*) T,THETAB,P
C       PK=1000.*(T/THETAB)**3.5
2     TK=T
	HK=100.464*(TB-T)
        XCL=HK
C3      XCL=-9999.
	RETURN
	END


