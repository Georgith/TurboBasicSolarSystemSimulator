'NEATENED ON 01-12-1994 19:35:15                              01-12-1994 19:35:15

                                        ' ADD DUST AND PROBES  OBJECTS THAT HAVE NO GRAVITATIONAL EFFCTS ON OTHERS
                                        'SET PRINTER TO SAN SERIF,15 CPI,HIGH SPEED MODE, 8 LINES PER INCH (VS 6 NORMAL)
                                        'LPRINT CHR$(27);CHR$(107);CHR$(1);CHR$(27);CHR$(103);_
                                        '      CHR$(27);CHR$(120);CHR$(0);CHR$(27);CHR$(48)
                                        'SET 10 CPI ,CONDENSED MODE  GIVES MAX CPI 196
                                        'LPRINT   CHR$(27);CHR$(80);CHR$(27);CHR$(15)
'strig on 'needed to read joystick

          RANDOMIZE MTIMER '1
          SEED=RND
          SEED2=RND                              'RANDOMIZE RND
          DEFDBL O
          CALL VCARDSET
'<--

call joystick ' has cal read and cal2 all at bottom
'joyread for current position

          CALL ORBITS
'<--
EEND:
          END





          SUB ORBITS


                                        'ON ERROR GOTO ERRORFIX
                                        'VARIABLE DECLARATIONS
              SHARED IV,DIMENSION,SEED,SEED2,OTOBJS,MAXMASS,OMDISTANCE
              SHARED MAXTRAILS,COUNT,HWDS,COORD%(),SCALED,WDISTANCE,OOBJECTS(),V
shared jx,jy,jr,jt,hat,jxc,jyc,jrc,jtc,jb1,jb2,jb3,jb4

              SCALED=1 '0=LINES W/O HEADS ONLY,1 E GLOBES,2 ERASE LINE 4 E G&L
              CTYPE%=2  '0=LOG,1=LOG ZOOM,2=/SUN1,3=/SUN ZOOM,4=/MAXMASS,5=/MAXMASS ZOOM  GLOBES
              SLANT%=0
              SLANTFACTOR=.3
              SF=1
              V=3'MINIMUM CIRCLE SIZE FOR PLANET RENDERINGS
              G=6.67*E-8
              TIME=-1
              LIMIT=35
' ARE NUMBERS OF OBJECTS RANDOM WITHIN PARAMETERS ?
              RNDNUM=1

              FIXEDOBJS=2'3
              MAXMASS=1E9/SF
              OMTSUNS=1
              OMTPLANETS=7
              OMTMOONS=4
              OMTCOMETS=5
              OMTSHIPS=6
              OMTDUST=10
              OMTPROBES=14
              FC%=1' VIEW FRAME COLOR
              BC%=1' SCREEN BACKGROUND COLOR
              SC%=0'SKY COLOR
              HWDS=1
              VWDS=2
              MAXTRAILS=20

              CLRS=1 ' CLR THE SCRN EACH PERIOD
              XS=.05
                                        ' ALL VARIABLES BEGIN WITH O
              OOFF$=""
              OMDISTANCE=5E5/SF
              WDISTANCE=6*OMDISTANCE
              PATTERN$=CHR$(&B00110011)+CHR$(&B11001100)
              CLS
              WINDOW (-WDISTANCE,WDISTANCE)-(WDISTANCE,-WDISTANCE)
                                        'PAINT (0,0),PATTERN$
              LL%=1+PMAP(-WDISTANCE,0)+1
              RR%=PMAP(WDISTANCE,0)-1
              TT%=PMAP(WDISTANCE,1)+1
              BB%=PMAP(-WDISTANCE,1)-1
              VIEW (LL%,TT%)-(RR%,BB%),BC%,FC%
              SWIDTH%=RR%-LL%
              SHGHT%=BB%-TT%
              DIM COORD%(HWDS,4)
                                        'BLACK OES HERE
DIM LASTPT(1:10,10:12)
              DIM STATIC OINFO(1:8)
              DIM DYNAMIC OOBJECTS(1:10,0:20)
              DIM DYNAMIC TRAILS(1:1,1:3,1:200)
              GOTO 1000
    '<--
ERRORFIX:
              RESUME 1000
              HWDS=1
              1000'
LOADOBJECTS:
                                        'HWDS=1
                                        'VWDS=2
                                        'WDS=HWDS*VWDS
                                        '           XS=.05
              WW%=INT((SWIDTH%-(SWIDTH%*XS))/(HWDS))
              WH%=INT((SHGHT%-(SHGHT%*XS))/(HWDS))
              BW%=SWIDTH%*XS/(HWDS+1)
              TBW%=SHGHT%*XS/(HWDS+1)
              ERASE COORD%
              DIM COORD%(HWDS,4)
              FOR WNDO%=1 TO HWDS
                  COORD%(WNDO%,1)=LL%+(WNDO%*BW%)+(WW%*(WNDO%-1))
                  COORD%(WNDO%,2)=LL%+(WNDO%*BW%)+(WW%*(WNDO%))
                  COORD%(WNDO%,3)=TT%+(1*TBW%)          '+(WH%*(WNDO%-1))
                  COORD%(WNDO%,4)=TT%+(1*TBW%)+(WH%)    '*(WNDO%))
              NEXT WNDO%
                                        'HGHT=BB-TT
              FOR WNDO=1 TO HWDS 'CLEAR ALL WINDOWS
                  VIEW (COORD%(WNDO,1),COORD%(WNDO,3))-(COORD%(WNDO,2),COORD%(WNDO,4)),,1
                  WINDOW (-WDISTANCE,WDISTANCE)-(WDISTANCE,-WDISTANCE)
                  CLS
              NEXT WNDO
              RANDOMIZE SEED
              SEED= RND
              ERASE OOBJECTS
                                        'ERASE OINFO
              ERASE TRAILS
ERASE LASTPT
              IF RNDNUM=1 THEN
                  OTSUNS=INT(RND(1)*(OMTSUNS+.9))
                  OTPLANETS=INT(RND(1)*(OMTPLANETS+.9))
                  OTMOONS=INT(RND(1)*(OMTMOONS+.9))
                  OTCOMETS=INT(RND(1)*(OMTCOMETS+.9))
                  OTSHIPS=INT(RND(1)*(OMTSHIPS+.9))
                  OTDUST=INT(RND(1)*(OMTDUST+.9))
                  OTPROBES=INT(RND(1)*(OMTPROBES+.9))
              ELSE
                  OTSUNS=OMTSUNS
                  OTPLANETS=OMTPLANETS
                  OTMOONS=OMTMOONS
                  OTCOMETS=OMTCOMETS
                  OTSHIPS=OMTSHIPS
                  OTDUST=OMTDUST
                  OTPROBES=OMTPROBES
              END IF
              OTOBJS=OTSUNS+OTPLANETS+OTMOONS+OTCOMETS+OTSHIPS+OTDUST+OTPROBES
              IF OTOBJS<=FIXEDOBJS THEN
                  OTSUNS=FIXEDOBJS+1
                  OTOBJS=OTSUNS+OTPLANETS+OTMOONS+OTCOMETS+OTSHIPS+OTDUST+OTPROBES
              END IF
              DIM DYNAMIC OOBJECTS(1:OTOBJS,0:20)
              DIM TRAILS (1:OTOBJS,1:3,0:MAXTRAILS)
DIM LASTPT(1:OTOBJS,10:12)
              OTGRAVOBJS=OTSUNS+OTPLANETS+OTMOONS+OTCOMETS+OTSHIPS
              OINFO(1)=MAXMASS
              OINFO(2)=OTSUNS
              OINFO(3)=OTPLANETS
              OINFO(4)=OTMOONS
              OINFO(5)=OTCOMETS
              OINFO(6)=OTSHIPS
              OINFO(7)=OTDUST
              OINFO(8)=OTPROBES
                                        'X-Y-Z,VX-VY-VZ,AX-AY-AZ,MASS,CIRCLESIZE
              CLS
              COUNT=0
              SKIP=0
              OOFF$=""
              OBJNUMLOINFODEX=1
              FOR C=1 TO OTOBJS
                  FOR FACT=0 TO 20
                      OOBJECTS(C,FACT)=0
                  NEXT FACT
              NEXT C
'INITIAL VELOCITY AND 2 OR 3 DIMENSIONS
              IV=O'1'INT(1.9*RND) '0 OR 1 INITIAL VELOCITIES YES OR NO
              DIMENSION=3'2+INT(RND*1.9) 'EITHER 2 OR 3 DIMENSIONAL FILL
RANDOMIZE SEED2
SEED2=RND
              FOR LOINFODEX=2 TO 8
                  FOR OLOADDEX=1 TO OINFO(LOINFODEX)
                      SELECT CASE LOINFODEX
                      CASE 1
                      CASE 2 'SUNS
                          OMASS=(1E4*(RND*10)) *OINFO(1)
                          ODISTANCE=5
                      CASE 3 'PLANETS
                          OMASS=(1E1*(RND*1E1)) *OINFO(1)
                          ODISTANCE=2.5
                      CASE 4 'MOONS
                          OMASS=(1E1*(RND*.5E1)) *OINFO(1)
                          ODISTANCE=2.6
                      CASE 5 'COMETS
                          OMASS=((RND*1)) *OINFO(1)
                          ODISTANCE=3
                      CASE 6 'SHIPS
                          OMASS=((RND*1)) *OINFO(1)
                          ODISTANCE=3.5
                      CASE 7 'DUST
                          OMASS=(1E-10*(RND*1E2)) *OINFO(1)
                          ODISTANCE=3
                      CASE 8 'PROBES
                          OMASS=(1E-10*(RND*1E2)) *OINFO(1)
                          ODISTANCE=3
                      END SELECT
                      FOR OX=1 TO DIMENSION
                          OOBJECTS(OBJNUMLOINFODEX,OX)=(-ODISTANCE+(RND*2*ODISTANCE)) *OMDISTANCE
                          OOBJECTS(OBJNUMLOINFODEX,OX+9)=OOBJECTS(OBJNUMLOINFODEX,OX)

LASTPT(OBJNUMLOINFODEX,OX+9)=OOBJECTS(OBJNUMLOINFODEX,OX)
'INITIAL VELOCITY HERE
                              IF IV=1 AND OX=1 THEN OOBJECTS(OBJNUMLOINFODEX,OX+3)=-OMDISTANCE*ODISTANCE/4+(2*RND*OMDISTANCE*ODISTANCE/4)
                          OOBJECTS(OBJNUMLOINFODEX,OX+12)=OOBJECTS(OBJNUMLOINFODEX,OX+3)
                      NEXT OX

                      IF SLANT%=1 AND DIMENSION=2 THEN
                          OX=1
                          OOBJECTS(OBJNUMLOINFODEX,3)=SLANTFACTOR*OOBJECTS(OBJNUMLOINFODEX,2)
                          OOBJECTS(OBJNUMLOINFODEX,12)=OOBJECTS(OBJNUMLOINFODEX,3)
LASTPT(OBJNUMLOINFODEX,12)=OOBJECTS(OBJNUMLOINFODEX,12)
                              IF IV=1 THEN OOBJECTS(OBJNUMLOINFODEX,6)=SLANTFACTOR*OOBJECTS(OBJNUMLOINFODEX,5)
                          OOBJECTS(OBJNUMLOINFODEX,15)=OOBJECTS(OBJNUMLOINFODEX,6)
                      END IF
                      OOBJECTS(OBJNUMLOINFODEX,0)=OMASS
                      OBJNUMLOINFODEX=OBJNUMLOINFODEX+1
                  NEXT OLOADDEX
              NEXT LOINFODEX
              OOBJECTS(1,1)=0
              OOBJECTS(1,2)=0
              OOBJECTS(1,3)=0
              OOBJECTS(1,10)=0
              OOBJECTS(1,11)=0
              OOBJECTS(1,12)=0
LASTPT(1,10)=0
LASTPT(1,11)=0
LASTPT(1,12)=0

              CALL CIRCSIZE (CTYPE%)
    '<--
              CALL REPRINT
    '<--
ENDLOADING:
                                        '****************************
INTERACTION:
              ELAPSEDTIME!=MTIMER
              LOCATE 2,2
              PRINT USING"IT TOOK ######## MICROSECONDS ";ELAPSEDTIME!
              MTIMER
              FOR C= 1 TO OTOBJS
                      IF INSTAT THEN GOSUB KEYTEST
        '<--
                  LOCATE 23,6
                  PRINT " YR ";COUNT;"  OBJ ";C;" OF ";OTOBJS;"       ";
                  IF C<=OTGRAVOBJS THEN
                      FOR A= C+1 TO OTGRAVOBJS  '**********OTOBJS
                          GOTO TESTS
                '<--
                          FOR AXIS= 1 TO 3
                              IF ABS(OOBJECTS(C,AXIS))>3*WDISTANCE THEN
                                      IF OOBJECTS(C,19)=0 THEN OOFF$=OOFF$+" "+STR$(C)
                                  OOBJECTS(C,19)=1
                              ELSE
                                  OOBJECTS(C,19)=0
                                        'GOTO SKIPA
                              END IF
                              IF ABS(OOBJECTS(A,AXIS))>3*WDISTANCE THEN
                                      IF OOBJECTS(A,19)=0 THEN OOFF$=OOFF$+" "+STR$(A)
                                  OOBJECTS(A,19)=1
                              ELSE
                                  OOBJECTS(A,19)=0
                                        'GOTO SKIPA
                              END IF
                          NEXT AXIS
TESTS:
                              IF C= OTGRAVOBJS THEN PRINT " GOT HERE"'GOTO NONGRAV   '*****NEXTSTAGE
                          ODX=OOBJECTS(A,1)-OOBJECTS(C,1)
                          ODY=OOBJECTS(A,2)-OOBJECTS(C,2)
                          ODZ=OOBJECTS(A,3)-OOBJECTS(C,3)

'GRAVITY FORMULA HERE
                          ' ODX2=ODX*ODX
                         ' ODY2=ODY*ODY
                         ' ODZ2=ODZ*ODZ
DXYZ2=ODX*ODX+ODY*ODY+ODZ*ODZ
DXYZ=SQR(DXYZ2)
                          RX=ODX/DXYZ 'SQR(ODY2+ODZ2)
                          RY=ODY/DXYZ 'SQR(ODX2+ODZ2)
                          RZ=ODZ/DXYZ 'SQR(ODY2+ODX2)


			AC=G*OOBJECTS(A,0)/DXYZ2'(ODX2+ODY2+ODZ2)
                          OOBJECTS(C,7)=AC*RX+OOBJECTS(C,7)
                          OOBJECTS(C,8)=AC*RY+OOBJECTS(C,8)
                          OOBJECTS(C,9)=AC*RZ+OOBJECTS(C,9)
                                        '
                                        'PLANET A NOW
			AA=-G*OOBJECTS(C,0)/DXYZ2'(ODX2+ODY2+ODZ2)
                          OOBJECTS(A,7)=AA*-RX+OOBJECTS(A,7)
                          OOBJECTS(A,8)=AA*-RY+OOBJECTS(A,8)
                          OOBJECTS(A,9)=AA*-RZ+OOBJECTS(A,9)
SKIPA:
                      NEXT A
                  ELSEIF C>OTGRAVOBJS THEN
                      FOR A= 1 TO OTGRAVOBJS
                                        '**********OTOBJS
                          GOTO TESTSS
                '<--
                          FOR AXIS= 1 TO 3
                              IF ABS(OOBJECTS(C,AXIS))>3*WDISTANCE THEN
                                      IF OOBJECTS(C,19)=0 THEN OOFF$=OOFF$+" "+STR$(C)
                                  OOBJECTS(C,19)=1
                                        'GOTO SKIPA
                              END IF
                          NEXT AXIS
TESTSS:
                              IF C= OTGRAVOBJS THEN PRINT " GOT HERE"'GOTO NONGRAV   '*****NEXTSTAGE
                          ODX=OOBJECTS(A,1)-OOBJECTS(C,1)
                          ODY=OOBJECTS(A,2)-OOBJECTS(C,2)
                          ODZ=OOBJECTS(A,3)-OOBJECTS(C,3)
                         ' ODX2=ODX*ODX
                         ' ODY2=ODY*ODY
                         ' ODZ2=ODZ*ODZ
DXYZ2=ODX*ODX+ODY*ODY+ODZ*ODZ
DXYZ=SQR(DXYZ2)
                          RX=ODX/DXYZ  'SQR(ODY2+ODZ2)
                          RY=ODY/DXYZ  'SQR(ODX2+ODZ2)
                          RZ=ODZ/DXYZ  'SQR(ODY2+ODX2)
                          AC=G*OOBJECTS(A,0)/DXYZ2   '(ODX2+ODY2+ODZ2)
                          OOBJECTS(C,7)=AC*RX+OOBJECTS(C,7)
                          OOBJECTS(C,8)=AC*RY+OOBJECTS(C,8)
                          OOBJECTS(C,9)=AC*RZ+OOBJECTS(C,9)
                      NEXT A
                  END IF
                                        'ALL ACCELERATIONS ACCUMULATED FOR CURRENT OBJECT
                                        'COMPUTE CURRENT COORDINATES
                  IF C>FIXEDOBJS THEN
                      IF TIME=1 THEN
                          OOBJECTS(C,1)=OOBJECTS(C,7)/2+OOBJECTS(C,13)+OOBJECTS(C,10)
                          OOBJECTS(C,2)=OOBJECTS(C,8)/2+OOBJECTS(C,14)+OOBJECTS(C,11)
                          OOBJECTS(C,3)=OOBJECTS(C,9)/2+OOBJECTS(C,15)+OOBJECTS(C,12)
                          OOBJECTS(C,4)=OOBJECTS(C,7)+OOBJECTS(C,13)
                          OOBJECTS(C,5)=OOBJECTS(C,8)+OOBJECTS(C,14)
                          OOBJECTS(C,6)=OOBJECTS(C,9)+OOBJECTS(C,15)
                      ELSE
                          OOBJECTS(C,1)=OOBJECTS(C,7)*.5*TIME^2+OOBJECTS(C,13)*TIME+OOBJECTS(C,10)
                          OOBJECTS(C,2)=OOBJECTS(C,8)*.5*TIME^2+OOBJECTS(C,14)*TIME+OOBJECTS(C,11)
                          OOBJECTS(C,3)=OOBJECTS(C,9)*.5*TIME^2+OOBJECTS(C,15)*TIME+OOBJECTS(C,12)
                          OOBJECTS(C,4)=OOBJECTS(C,7)*TIME+OOBJECTS(C,13)
                          OOBJECTS(C,5)=OOBJECTS(C,8)*TIME+OOBJECTS(C,14)
                          OOBJECTS(C,6)=OOBJECTS(C,9)*TIME+OOBJECTS(C,15)
                      END IF
IF DIRECTION=-1 THEN
IF TIME=1 THEN
                          OOBJECTS(C,1)=OOBJECTS(C,7)/2+OOBJECTS(C,13)+OOBJECTS(C,10)
                          OOBJECTS(C,2)=OOBJECTS(C,8)/2+OOBJECTS(C,14)+OOBJECTS(C,11)
                          OOBJECTS(C,3)=OOBJECTS(C,9)/2+OOBJECTS(C,15)+OOBJECTS(C,12)
                          OOBJECTS(C,4)=OOBJECTS(C,7)+OOBJECTS(C,13)
                          OOBJECTS(C,5)=OOBJECTS(C,8)+OOBJECTS(C,14)
                          OOBJECTS(C,6)=OOBJECTS(C,9)+OOBJECTS(C,15)
                      ELSE
                          OOBJECTS(C,1)=OOBJECTS(C,7)*.5*TIME^2+OOBJECTS(C,13)*TIME+OOBJECTS(C,10)
                          OOBJECTS(C,2)=OOBJECTS(C,8)*.5*TIME^2+OOBJECTS(C,14)*TIME+OOBJECTS(C,11)
                          OOBJECTS(C,3)=OOBJECTS(C,9)*.5*TIME^2+OOBJECTS(C,15)*TIME+OOBJECTS(C,12)
                          OOBJECTS(C,4)=OOBJECTS(C,7)*TIME+OOBJECTS(C,13)
                          OOBJECTS(C,5)=OOBJECTS(C,8)*TIME+OOBJECTS(C,14)
                          OOBJECTS(C,6)=OOBJECTS(C,9)*TIME+OOBJECTS(C,15)
                      END IF
END IF
                  ELSE
                      OOBJECTS(C,1)=OOBJECTS(C,10)
                      OOBJECTS(C,2)=OOBJECTS(C,11)
                      OOBJECTS(C,3)=OOBJECTS(C,12)
                  END IF
                  CPLOT=-1
                                        'IF CLRS AND C=1 THEN CLS
V1:
                      IF OOBJECTS(C,19)=1 THEN GOTO CPLOTSKIP
        '<--
                  ON ERROR GOTO SKIPPER
                  TRACKOBJ=1
                  XOFFSET=OOBJECTS(TRACKOBJ,1)
                  YOFFSET=OOBJECTS(TRACKOBJ,2)
                  ZOFFSET=OOBJECTS(TRACKOBJ,3)
                  IF HWDS >0 THEN
                      WNDO=1
                      VIEW (COORD%(WNDO,1),COORD%(WNDO,3))-(COORD%(WNDO,2),COORD%(WNDO,4)),,1
                      WINDOW (-WDISTANCE,WDISTANCE)-(WDISTANCE,-WDISTANCE)
IF SCALED=2 OR SCALED=3 THEN     LINE(LASTPT(C,10),LASTPT(C,11))-(OOBJECTS(C,10),OOBJECTS(C,11)),0
                      LINE(OOBJECTS(C,1),OOBJECTS(C,2))-(OOBJECTS(C,10),OOBJECTS(C,11)),1',,&HBBBB
                      LINE (WDISTANCE,0)-(-WDISTANCE,0)
                      LINE (0,WDISTANCE)-(0,-WDISTANCE)
                                        'LINESKIP:
                      IF SCALED>0 THEN
                              IF SCALED=1 OR SCALED=3 THEN    CIRCLE (OOBJECTS(C,10),OOBJECTS(C,11)),OOBJECTS(C,20),0
                          CIRCLE (OOBJECTS(C,1),OOBJECTS(C,2)),OOBJECTS(C,20)
                      END IF
                                        'IF CLRS AND C=1 THEN CLS
                  END IF
                  IF HWDS >1 THEN
V2:
                                        'IF OOBJECTS(C,19)=1 THEN GOTO CPLOTSKIP
                      WNDO=2
                      VIEW (COORD%(WNDO,1),COORD%(WNDO,3))-(COORD%(WNDO,2),COORD%(WNDO,4)),,1
                      WINDOW (-WDISTANCE,WDISTANCE)-(WDISTANCE,-WDISTANCE)
IF SCALED=2 OR SCALED=3 THEN    LINE(LASTPT(C,10),LASTPT(C,12))-(OOBJECTS(C,10),OOBJECTS(C,12)),0
                      LINE(OOBJECTS(C,1),OOBJECTS(C,3))-(OOBJECTS(C,10),OOBJECTS(C,12)),1',,&HBBBB
                      LINE (WDISTANCE,0)-(-WDISTANCE,0)
                      LINE (0,WDISTANCE)-(0,-WDISTANCE)
                                        'LINESKIP:
                      IF SCALED>0 THEN
                              IF SCALED=1 OR SCALED=3 THEN    CIRCLE (OOBJECTS(C,10),OOBJECTS(C,12)),OOBJECTS(C,20),0
                          CIRCLE (OOBJECTS(C,1),OOBJECTS(C,3)),OOBJECTS(C,20)
                      END IF
                                        'IF CLRS AND C=1 THEN CLS
                  END IF
                  IF HWDS >2 THEN
V3:
                                        'IF OOBJECTS(C,19)=1 THEN GOTO CPLOTSKIP
                      WNDO=3
                      VIEW (COORD%(WNDO,1),COORD%(WNDO,3))-(COORD%(WNDO,2),COORD%(WNDO,4)),,1
                      WINDOW (-WDISTANCE,WDISTANCE)-(WDISTANCE,-WDISTANCE)
IF SCALED=2 OR SCALED=3 THEN    LINE(LASTPT(C,10),LASTPT(C,12))-(OOBJECTS(C,10),OOBJECTS(C,12)),0
                      LINE(OOBJECTS(C,1),OOBJECTS(C,3))-(OOBJECTS(C,10),OOBJECTS(C,12)),1',,&HBBBB
                      LINE (WDISTANCE,0)-(-WDISTANCE,0)
                      LINE (0,WDISTANCE)-(0,-WDISTANCE)
LINESKIP:
                      IF SCALED>0 THEN
                              IF SCALED=1 OR SCALED=3 THEN    CIRCLE (OOBJECTS(C,10),OOBJECTS(C,12)),OOBJECTS(C,20),0
                          CIRCLE (OOBJECTS(C,1),OOBJECTS(C,3)),OOBJECTS(C,20)
                      END IF
                  END IF
                                        'LOCATE 3,1
                                        'PRINT C;" A = ";SQR(OOBJECTS(C,7)^2+OOBJECTS(C,8)^2+OOBJECTS(C,9)^2);"  "
                                        'LOCATE 4,1
                                        'PRINT C;" AX = ";OOBJECTS(C,7);"  "
                                        'LOCATE 5,1
                                        'PRINT C;" AY = ";OOBJECTS(C,8);"  "
                                        'LOCATE 6,1
                                        'PRINT C;" AZ = ";OOBJECTS(C,9);"  "
                                        'WHILE NOT INSTAT
                                        'WEND
                                        'S$=UCASE$(INKEY$)
CPLOTSKIP:
              NEXT C
NEXTSTAGE:
CLINESKIP:
REARRANGE:
              FOR C=1 TO OTOBJS
LASTPT(C,10)=OOBJECTS(C,10)
LASTPT(C,11)=OOBJECTS(C,11)
LASTPT(C,12)=OOBJECTS(C,12)
                  OOBJECTS(C,10)=OOBJECTS(C,1)
                  OOBJECTS(C,11)=OOBJECTS(C,2)
                  OOBJECTS(C,12)=OOBJECTS(C,3)
                  OOBJECTS(C,13)=OOBJECTS(C,4)
                  OOBJECTS(C,14)=OOBJECTS(C,5)
                  OOBJECTS(C,15)=OOBJECTS(C,6)
                  OOBJECTS(C,16)=OOBJECTS(C,7)
                  OOBJECTS(C,17)=OOBJECTS(C,8)
                  OOBJECTS(C,18)=OOBJECTS(C,9)
                  OOBJECTS(C,7)=0
                  OOBJECTS(C,8)=0
                  OOBJECTS(C,9)=0
              NEXT C
              GOTO RESUMEIT
    '<--
KEYTEST:
              S$=UCASE$(INKEY$)
              SELECT CASE LEFT$(S$,1)
              CASE "Q"
                  SCREEN
              END 'GOTO ORBITEND
          CASE "P"
              WHILE NOT INSTAT
              WEND
              S$=UCASE$(INKEY$)
          CASE "R"
              GOTO LOADOBJECTS
    '<--
          CASE "C"
              SKIP=1
          CASE "H"
              CLS
              LOCATE 1,0
              FOR P=1 TO 16
                  PRINT "                                                                     "
              NEXT P
              LOCATE 2,1
              ? " USE THESE KEYS WHILE THE SIMULATION IS RUNNING"
              ? " "
              ? " PRESS  1,2 OR 3   TO CHANGE NUMBER OF VIEW WINDOWS "
              ? " PRESS    R  TO START NEW SIMULATION"
              ? " PRESS    Z   TO ZOOM IN "
              ? " PRESS    X  TO EXPAND VIEWS (ZOOM OUT)"
              ? " PRESS    C  TO LET THE CURRENT SIMULATION RUN CONTINUOUSLY"
              ? " PRESS    P  TO PAUSE SIMULATION - THEN ANY KEY TO RESTART IT"
              ? " PRESS    H  FOR THIS HELP MENU "
              ? " "
              ? " "
              ? "   ** PRESS  ANY  KEY  TO  CONTINUE ** "
              WHILE NOT INSTAT
              WEND
              D$=INKEY$
              WW%=INT((SWIDTH%-(SWIDTH%*XS))/(HWDS))
              WH%=INT((SHGHT%-(SHGHT%*XS))/(HWDS))
              BW%=SWIDTH%*XS/(HWDS+1)
              TBW%=SHGHT%*XS/(HWDS+1)
              ERASE COORD%
              DIM COORD%(HWDS,4)
              FOR WNDO%=1 TO HWDS
                  COORD%(WNDO%,1)=LL%+(WNDO%*BW%)+(WW%*(WNDO%-1))
                  COORD%(WNDO%,2)=LL%+(WNDO%*BW%)+(WW%*(WNDO%))
                  COORD%(WNDO%,3)=TT%+(1*TBW%)          '+(WH%*(WNDO%-1))
                  COORD%(WNDO%,4)=TT%+(1*TBW%)+(WH%)    '*(WNDO%))
              NEXT WNDO%
              VIEW (LL%,TT%)-(RR%,BB%),BC%,FC%
              FOR WNDO=1 TO HWDS
                  VIEW (COORD%(WNDO,1),COORD%(WNDO,3))-(COORD%(WNDO,2),COORD%(WNDO,4)),,1
                  WINDOW (-WDISTANCE,WDISTANCE)-(WDISTANCE,-WDISTANCE)
                  CLS
              NEXT WNDO
          CASE "X"
              VIEW (LL%,TT%)-(RR%,BB%),BC%,FC%
              WDISTANCE=WDISTANCE*2
              FOR WNDO=1 TO HWDS
                  VIEW (COORD%(WNDO,1),COORD%(WNDO,3))-(COORD%(WNDO,2),COORD%(WNDO,4)),,1
                  CLS
              NEXT WNDO
              CALL CIRCSIZE (CTYPE%)
    '<--
              FOR T=1 TO OTOBJS
                  OOBJECTS(T,19)=0
              NEXT T
              OOFF$="" 'OFFSCREEN PLANET PRINT OUT
              CLS
          CASE "Z"
              VIEW (LL%,TT%)-(RR%,BB%),BC%,FC%
              WDISTANCE=WDISTANCE/2
              FOR WNDO=1 TO HWDS
                  VIEW (COORD%(WNDO,1),COORD%(WNDO,3))-(COORD%(WNDO,2),COORD%(WNDO,4)),,1
                  CLS
              NEXT WNDO
              CALL CIRCSIZE (CTYPE%)
    '<--
              FOR T=1 TO OTOBJS
                  OOBJECTS(T,19)=0
              NEXT T
              OOFF$=""
              CLS
          CASE "1","2","3"
              HWDS=VAL(S$)
              WW%=INT((SWIDTH%-(SWIDTH%*XS))/(HWDS))
              WH%=INT((SHGHT%-(SHGHT%*XS))/(HWDS))
              BW%=SWIDTH%*XS/(HWDS+1)
              TBW%=SHGHT%*XS/(HWDS+1)
              ERASE COORD%
              DIM COORD%(HWDS,4)
              FOR WNDO%=1 TO HWDS
                  COORD%(WNDO%,1)=LL%+(WNDO%*BW%)+(WW%*(WNDO%-1))
                  COORD%(WNDO%,2)=LL%+(WNDO%*BW%)+(WW%*(WNDO%))
                  COORD%(WNDO%,3)=TT%+(1*TBW%)          '+(WH%*(WNDO%-1))
                  COORD%(WNDO%,4)=TT%+(1*TBW%)+(WH%)    '*(WNDO%))
              NEXT WNDO%
              VIEW (LL%,TT%)-(RR%,BB%),BC%,FC%
              FOR WNDO=1 TO HWDS
                  VIEW (COORD%(WNDO,1),COORD%(WNDO,3))-(COORD%(WNDO,2),COORD%(WNDO,4)),,1
                  WINDOW (-WDISTANCE,WDISTANCE)-(WDISTANCE,-WDISTANCE)
                  CLS
              NEXT WNDO
          END SELECT
          CALL REPRINT
'<--
          RETURN
'<--
SKIPPER:
          RESUME NEXT
RESUMEIT:
          COUNT=COUNT+1
          IF COUNT >LIMIT AND SKIP<>1 THEN
              GOTO  LOADOBJECTS
    '<--
          ELSE
              GOTO INTERACTION
    '<--
          END IF
ORBITEND:
          END SUB  'orbits
          SUB REPRINT
              SHARED IV,DIMENSION
              LOCATE 22,7
              IF IV=1 THEN
                  PRINT " ACTIVE INITIAL VELOCITIES. ";
              ELSE
                  PRINT " INITIAL VELOCITIES ZERO. ";
              END IF
              PRINT " "DIMENSION;" DIMENSIONAL POSITIONING.          "
          END SUB
          SUB VCARDSET 'VCARDSET.BAS HOLDS THIS PROC
                                        ' SETS CARD TO HIGHEST VIDEO MODE THAT DOES'NT GENERATE AN ERROR
              ON ERROR GOTO TRYAGAIN
              CARDTYPE =13
              GOTO SCREENTEST
    '<--
TRYAGAIN:
              RESUME 100'USING A LINE NUMBER SHORTENS COMPILED CODE
              100 SCREENTEST: 'DUMMYLINENUMBER
              CARDTYPE = CARDTYPE-1
                  IF CARDTYPE<0 THEN GOTO FAILURE
    '<--
              SCREEN CARDTYPE
SUCCESS:
              PRINT "CARDTEST SUCCESSFUL"
              PRINT "GRAPHICS MODE IS ";CARDTYPE
              GOTO VCARDSETENDEND
    '<--
FAILURE:
              SCREEN
              PRINT "CARD TEST FAILED"
              GOTO VCARDSETENDEND
    '<--
VCARDSETENDEND:
              CLS
              ON ERROR GOTO 0
          END SUB
          SUB BLACKOUT
              WW%=INT((SWIDTH%-(SWIDTH%*XS))/(HWDS))
              WH%=INT((SHGHT%-(SHGHT%*XS))/(HWDS))
              BW%=SWIDTH%*XS/(HWDS+1)
              TBW%=SHGHT%*XS/(HWDS+1)
              ERASE COORD%
              DIM COORD%(HWDS,4)
              FOR WNDO%=1 TO HWDS
                  COORD%(WNDO%,1)=LL%+(WNDO%*BW%)+(WW%*(WNDO%-1))
                  COORD%(WNDO%,2)=LL%+(WNDO%*BW%)+(WW%*(WNDO%))
                  COORD%(WNDO%,3)=TT%+(1*TBW%)          '+(WH%*(WNDO%-1))
                  COORD%(WNDO%,4)=TT%+(1*TBW%)+(WH%)    '*(WNDO%))
              NEXT WNDO%
                                        'HGHT=BB-TT
              FOR WNDO=1 TO HWDS
                  VIEW (COORD%(WNDO,1),COORD%(WNDO,3))-(COORD%(WNDO,2),COORD%(WNDO,4)),,1
                  WINDOW (-WDISTANCE,WDISTANCE)-(WDISTANCE,-WDISTANCE)
                  CLS
              NEXT WNDO
          END SUB
          SUB REDRAW  'CURRENTLY UNUSED
              SHARED MAXTRAILS,COUNT, HWDS,COORD%(),SCALED,WDISTANCE,TRAILS()
              PERIOD=0
              WHILE PERIOD <= COUNT AND PERIOD <=MAXTRAIL
RV1:
RV2:
RV3:
                  PERIOD=PERIOD+1
              WEND
          END SUB
          SUB CIRCSIZE (CCTYPE%)
              SHARED OTOBJS,OOBJECTS(),WDISTANCE,V,MAXMASS,OMDISTANCE
              FOR PLANET=1 TO OTOBJS
                  SELECT CASE CCTYPE%
                  CASE 0
                      OOBJECTS(PLANET,20)=(LOG10 ( OOBJECTS(PLANET,0) )+.001)*WDISTANCE/1000*V+2
                  CASE 1
                      OOBJECTS(PLANET,20)=(LOG10 ( OOBJECTS(PLANET,0) )+.001)*OMDISTANCE/60*V+2
                  CASE 2
'RELATIVE TO PLANET 1,NOT BIGGER AS YOU ZOOM SCALED TO WINDOW SIZE
                      OOBJECTS(PLANET,20)= (OOBJECTS(PLANET,0)^(1/3)/OOBJECTS(1,0)^(1/3))*WDISTANCE/50+2
                                        'PRINT OOBJECTS(PLANET,19),WDISTANCE
                  CASE 3
'RELATIVE TO PLANET 1,BIGGER AS YOU ZOOM
                      OOBJECTS(PLANET,20)= (OOBJECTS(PLANET,0)^(1/3)/OOBJECTS(1,0)^(1/3))*OMDISTANCE/500
                  CASE 4
'RELATIVE TO MAXMASS,NOT BIGGER AS YOU ZOOM SCALED TO WINDOW SIZE
                      OOBJECTS(PLANET,20)= (OOBJECTS(PLANET,0)^(1/3)/MAXMASS^(1/3))*WDISTANCE/50+2
                                        'PRINT OOBJECTS(PLANET,19),WDISTANCE
                  CASE 5
'RELATIVE TO MAXMASS,BIGGER AS YOU ZOOM
                      OOBJECTS(PLANET,20)= (OOBJECTS(PLANET,0)^(1/3)/MAXMASS^(1/3))*OMDISTANCE/500
                  END SELECT
              NEXT PLANET
          END SUB

sub joystick
strig on

call joycal2
call joycal
call joystat
end sub


sub joystat
shared jx,jy,jr,jt,hat,jxc,jyc,jrc,jtc,jb1,jb2,jb3,jb4
shared jxm,jxn,jym,jyn,jrm,jrn,jtm,jtn

print "jx =";jx
print "jy =";jy
print "jr =";jr
print "jt =";jt
print "hat =";hat
print "jxc =";jxc
print "jyc =";jyc
print "jrc =";jrc
print "jtc =";jtc
print "jb1 =";jb1;" jb2 =";jb2
print "jb3 =";jb3;" jb4 =";jb4
print "jxm =";jxm;" jxn =";jxn
print "jym =";jym;" jyn =";jyn
print "jrm =";jrm;" jrn =";jrn
print "jtm =";jtm;" jtn =";jtn

print "press a key to continue"
WHILE NOT INSTAT
      WEND
      D$=INKEY$

end sub 'joystat joystick status printer

sub joycal 'calibrate joystick
shared jx,jy,jr,jt,hat,jxc,jyc,jrc,jtc,jb1,jb2,jb3,jb4
shared jxm,jxn,jym,jyn,jrm,jrn,jtm,jtn

Print " center joystick with throttle at 0 and release this press a key"
WHILE NOT INSTAT
              WEND
              D$=INKEY$
call joyread
jxc=jx
jyc=jy
jrc=jr
jtc=jt
jb1=jb1
jb2=jb2
jb3=jb3
jb4=jb4
hat=hat

end sub 'joycal

sub joycal2  'gets range of axises
shared jx,jy,jr,jt,hat,jxc,jyc,jrc,jtc,jb1,jb2,jb3,jb4
shared jxm,jxn,jym,jyn,jrm,jrn,jtm,jtn

Print " move joystick and throttle all around then this press any key"
WHILE NOT INSTAT

call joyread
if jx>jxm then jxm=jx
if jx<jxn then jxn=jx
if jy>jym then jym=jy
if jy<jyn then jxn=jy
if jr>jrm then jrm=jr
if jr<jrn then jrn=jr
if jt>jtm then jtm=jt
if jt<jtn then jtn=jt
wend

D$=INKEY$

end sub 'joycal2

sub joyread
shared jx,jy,jr,jt,hat,jxc,jyc,jrc,jtc,jb1,jb2,jb3,jb4
shared jxm,jxn,jym,jyn,jrm,jrn,jtm,jtn

readjoy:
jx=stick(0)
jy=stick(1)
jr=stick(2)
jt=stick(3)

jb1=strig(1)
jb2=strig(5)
jb3=strig(3)
jb4=strig(7)

readhat:
if Strig(1) and strig(5) and strig(7) and strig(3) then
hat=1
elseif strig (1) and strig(5) and strig(7) then
hat=3
elseif strig (1) and strig(5) and strig(3) then
hat=4
elseif strig (1) and strig(5) then
hat=2
else
 hat=0
end if
end sub 'joyread


