*&---------------------------------------------------------------------*
*& Report Z01_INSERT_IN_SCARR
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z01_insert_in_scarr.

DATA gs_scarr TYPE scarr.
*gs_scarr-carrid = 'WKO'.
*gs_scarr-mandt  = '200'.
*gs_scarr-carrname ='WKO Airline'.
*gs_scarr-currcode = 'EUR'.
*gs_scarr-url = 'wko.com'.

"insert scarr from gs_scarr.
INSERT INTO scarr  VALUES gs_scarr.
IF sy-subrc = 0.
  WRITE 'Datensatz eingefügt'.
ELSE.
  WRITE 'Existierte bereits - fehler'.
ENDIF.
