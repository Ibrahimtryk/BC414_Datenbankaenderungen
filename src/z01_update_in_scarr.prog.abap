*&---------------------------------------------------------------------*
*& Report Z01_INSERT_IN_SCARR
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z01_update_in_scarr.

DATA gs_scarr TYPE scarr.
*select single * from scarr into gs_scarr
*  where carrid = 'AA'.
"gs_scarr-carrid = 'WKO'.
"gs_scarr-mandt  = '200'.
"gs_scarr-carrname ='WKO Airline'.
gs_scarr-currcode = 'USD'.
*gs_scarr-url = 'wko.com'.

"insert scarr from gs_scarr.
UPDATE scarr  SET "currcode = gs_scarr-currcode
                  "url = 'neue URL'
                  zzversion = zzversion + 20.
 "WHERE currcode = 'EUR'.
IF sy-subrc = 0.
  WRITE 'Datensatz eingefügt'.
ELSE.
  WRITE 'Existierte bereits - fehler'.
ENDIF.
