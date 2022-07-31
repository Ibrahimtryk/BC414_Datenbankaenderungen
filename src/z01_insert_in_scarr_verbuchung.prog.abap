*&---------------------------------------------------------------------*
*& Report Z01_INSERT_IN_SCARR
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z01_insert_in_scarr_verbuchung.

DATA gs_scarr TYPE scarr.
gs_scarr-carrid = 'RTZ'.
*gs_scarr-mandt  = '200'.
gs_scarr-carrname ='RTZ Airline'.
*gs_scarr-currcode = 'EUR'.
*gs_scarr-url = 'wko.com'.

CALL FUNCTION 'Z_01INSERTSCARR'
  in UPDATE TASK
  EXPORTING
    is_scarr = gs_scarr.
"Implizites DB-Commit
call TRANSACTION 'ZBOOKINGS_01' .
"neue DB-LUW - aber in Update-Task ist weiter aktiv
commit work.

write 'programmende'.
