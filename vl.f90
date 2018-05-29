      PROGRAM vl
      
      IMPLICIT NONE
      REAL, dimension(367):: doy,tzsr,tzmin,tzmax,p,vll,tsr,tmin,tmax,&
                             rv,tsrk,ps,lcl
      REAL, dimension(367):: tdsr,tdmin,spvpsr,spvpmin,spvpmax,pvpsr,&
                             pvpmin,pvpmax,svsr,svmax,ssvsr,ssvmin,&
                             ptsr,tpt,tsv,bpr,rv1,rv2
      REAL, dimension(367):: alfa,beta,gama=0.786,p0=1000.,R=8.3143,&
                             cpmol=29.07,cpmass=1.0035,slti=2264.705
      INTEGER:: i,j,k
      CHARACTER(len=2), dimension(2):: loc
      DATA loc /"SK", "VV"/
      CHARACTER(len=1) n
      
      DO k=1,2
      DO j=2,6
       
       write (n,'(i1)') j        

       open (1, file=""//loc(k)//"201"//n//"in.dat")
       open (2, file=""//loc(k)//"201"//n//"out.dat")
       open (3, file=""//loc(k)//"201"//n//"bpr.dat")
       open (7, file=""//loc(k)//"201"//n//"bpr1.dat")
       open (9, file=""//loc(k)//"201"//n//"lcl.dat")

       DO i=1,367
        
        read (1,*) doy(i),tzsr(i),tzmin(i),tzmax(i),p(i),vll(i),&
                   tsr(i),tmin(i),tmax(i),rv(i),tsrk(i),ps(i)
        read (9,*) lcl(i)

        IF (tsr(i)>=0..and.tmin(i)>=0..and.tmax(i)>=0.) then
         alfa=7.5
         beta=237.5
        ENDIF

        IF (tsr(i)<0..and.tmin(i)<0..and.tmax(i)<0.) then
         alfa=9.5
         beta=265.5
        ENDIF

        spvpsr(i)=10**(alfa(i)*tsr(i)/(beta(i)+tsr(i))+gama(i))
        pvpsr(i)=rv(i)*spvpsr(i)/100.
        tdsr(i)=beta(i)*(ALOG10(pvpsr(i))-gama(i))/(alfa(i)+gama(i)-&
                ALOG10(pvpsr(i)))
        spvpmin(i)=10**(alfa(i)*tmin(i)/(beta(i)+tmin(i))+gama(i))
        pvpmin(i)=rv(i)*spvpmin(i)/100.
        tdmin(i)=beta(i)*(ALOG10(pvpmin(i))-gama(i))/(alfa(i)+gama(i)-&
                 ALOG10(pvpmin(i)))
        spvpmax(i)=10**(alfa(i)*tmax(i)/(beta(i)+tmax(i))+gama(i))
        pvpmax(i)=rv(i)*spvpmax(i)/100.
        svsr(i)=0.622*(pvpsr(i)/(ps(i)-0.378*pvpsr(i)))
        svmax(i)=0.622*(pvpmax(i)/(ps(i)-0.378*pvpmax(i)))
        ssvsr(i)=0.622*(spvpsr(i)/(ps(i)-0.378*spvpsr(i)))
        ssvmin(i)=0.622*(spvpmin(i)/(ps(i)-0.378*spvpmin(i)))
        ptsr(i)=tsrk(i)*(p0(i)/ps(i))**(R(i)/cpmol(i))
        rv1(i)=(ps(i)/(spvpmax(i)*(0.622/svsr(i)+0.378)))*100.
        rv2(i)=(ps(i)/(spvpmax(i)*(0.622/ssvmin(i)+0.378)))*100.
        
       ENDDO

       DO i=1,366

        tpt(i)=(ptsr(i+1)-ptsr(i))/(24.*3600.)
        tsv(i)=(svsr(i+1)-svsr(i))/(24.*3600.)
        bpr(i)=(cpmass(i)*tpt(i))/(slti(i)*tsv(i))

       ENDDO

       DO i=1,367

        write (2,*) i,tdsr(i),tdmin(i),spvpsr(i),spvpmin(i),spvpmax(i),&
                    pvpsr(i),pvpmin(i),pvpmax(i),svsr(i),svmax(i),&
                    ssvsr(i), ssvmin(i),ptsr(i),tpt(i),tsv(i),bpr(i),&
                    rv1(i),rv2(i),lcl(i)
     
       ENDDO
       
       DO i=1,366

        write (3,*) bpr(i),i

       ENDDO

       DO i=1,366
        
        IF (bpr(i).ge.-5..and.bpr(i).le.5.) then
         write (7,*) i, bpr(i)
        ENDIF

       ENDDO
     
       close(1)
       close(2)
       close(3)
       close(7)
       close(9)
       
      ENDDO
      ENDDO

      DO j=4,6
     
       write (n, '(i1)') j

       open (4, file="IR201"//n//"in.dat")
       open (5, file="IR201"//n//"out.dat")
       open (6, file="IR201"//n//"bpr.dat")
       open (8, file="IR201"//n//"bpr1.dat")
       open (10, file="IR201"//n//"lcl.dat")

       DO i=1,367

        read (4,*) doy(i),tzsr(i),tzmin(i),tzmax(i),p(i),vll(i),&
                   tsr(i),tmin(i),tmax(i),rv(i),tsrk(i),ps(i)
        read (10,*) lcl(i)

        IF (tsr(i)>=0..and.tmin(i)>=0..and.tmax(i)>=0.) then
         alfa=7.5
         beta=237.5
        ENDIF

        IF (tsr(i)<0..and.tmin(i)<0..and.tmax(i)<0.) then
         alfa=9.5
         beta=265.5
        ENDIF

        spvpsr(i)=10**(alfa(i)*tsr(i)/(beta(i)+tsr(i))+gama(i))
        pvpsr(i)=rv(i)*spvpsr(i)/100.
        tdsr(i)=beta(i)*(ALOG10(pvpsr(i))-gama(i))/(alfa(i)+gama(i)-&
                ALOG10(pvpsr(i)))
        spvpmin(i)=10**(alfa(i)*tmin(i)/(beta(i)+tmin(i))+gama(i))
        pvpmin(i)=rv(i)*spvpmin(i)/100.
        tdmin(i)=beta(i)*(ALOG10(pvpmin(i))-gama(i))/(alfa(i)+gama(i)-&
                 ALOG10(pvpmin(i)))
        spvpmax(i)=10**(alfa(i)*tmax(i)/(beta(i)+tmax(i))+gama(i))
        pvpmax(i)=rv(i)*spvpmax(i)/100.
        svsr(i)=0.622*(pvpsr(i)/(ps(i)-0.378*pvpsr(i)))
        svmax(i)=0.622*(pvpmax(i)/(ps(i)-0.378*pvpmax(i)))
        ssvsr(i)=0.622*(spvpsr(i)/(ps(i)-0.378*spvpsr(i)))
        ssvmin(i)=0.622*(spvpmin(i)/(ps(i)-0.378*spvpmin(i)))
        ptsr(i)=tsrk(i)*(p0(i)/ps(i))**(R(i)/cpmol(i))
        rv1(i)=(ps(i)/(spvpmax(i)*(0.622/svsr(i)+0.378)))*100.
        rv2(i)=(ps(i)/(spvpmax(i)*(0.622/ssvmin(i)+0.378)))*100.

       ENDDO

       DO i=1,366

        tpt(i)=(ptsr(i+1)-ptsr(i))/(24.*3600.)
        tsv(i)=(svsr(i+1)-svsr(i))/(24.*3600.)
        bpr(i)=(cpmass(i)*tpt(i))/(slti(i)*tsv(i))

       ENDDO

       DO i=1,367

        write (5,*) i,tdsr(i),tdmin(i),spvpsr(i),spvpmin(i),spvpmax(i),&
                    pvpsr(i),pvpmin(i),pvpmax(i),svsr(i),svmax(i),&
                    ssvsr(i), ssvmin(i),ptsr(i),tpt(i),tsv(i),bpr(i),&
                    rv1(i),rv2(i),lcl(i)

       ENDDO

       DO i=1,366

        write (6,*) bpr(i),i

       ENDDO

       DO i=1,366

        IF (bpr(i).ge.-5..and.bpr(i).le.5.) then
         write (8,*) i, bpr(i)
        ENDIF

       ENDDO

       close(4)
       close(5)
       close(6)
       close(8)
       close(10)

      ENDDO

      END PROGRAM vl
