PROGRAM main
 !===================================
 !=           RULE 110              =
 !=          A. Windisch            =
 !=   andreas.windisch@yahoo.com    =
 !=            May 2018             =
 !===================================

 IMPLICIT NONE

 INTEGER(KIND=4), PARAMETER :: N = 1000
 LOGICAL(KIND=1) :: state(N), tmpstate(N)
 LOGICAL(KIND=1) :: a,b,c
 INTEGER(KIND=4) :: i,j

 ! reset and initialize
 state      = .FALSE.
 state(N)   = .TRUE.
 DO i=1, N
  IF ( state(i) ) PRINT *, i, N+1 
 END DO

 !evolve states
 !rule 110: (b AND (NOT a)) OR (b XOR  c)
 DO i=N, 1, -1
  DO j=1, N
   IF ( j .EQ. N ) THEN
    a = state(N-1); b = state(N); c = .FALSE. 
   ELSE IF ( j .EQ. 1 ) THEN
    a = .FALSE.; b = state(1); c = state(2) 
   ELSE  
    a = state(j-1); b = state(j); c = state(j+1) 
   END IF
   tmpstate(j) = ( b .AND. .NOT. a ) .OR. XOR( b, c )
   IF ( tmpstate(j) ) PRINT *, j, i 
  END DO
  state = tmpstate
 END DO

END PROGRAM main
