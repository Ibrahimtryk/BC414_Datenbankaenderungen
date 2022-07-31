*&---------------------------------------------------------------------*
*& Report Z01_INSERT_IN_SCARR
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z01_modify_in_scarr.

DATA gs_scarr TYPE scarr.
gs_scarr-carrid = 'WK2'.
gs_scarr-carrname ='WK2 Airline'.
gs_scarr-currcode = 'EUR'.
gs_scarr-url = 'wko.com'.

"insert scarr from gs_scarr.
MODIFY  scarr  FROM gs_scarr.
IF sy-subrc = 0.
  WRITE 'Datensatz eingefügt oder upgedated'.
ELSE.
  WRITE 'Unix-Index in der DB-Tabelle exisitierte bereits'.
ENDIF.
