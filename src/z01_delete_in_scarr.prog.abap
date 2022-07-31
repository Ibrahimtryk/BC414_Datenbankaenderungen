*&---------------------------------------------------------------------*
*& Report Z01_INSERT_IN_SCARR
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z01_delete_in_scarr.

delete from scarr where currcode like '%'.

message 'Datnsätze werden zurückgeholt' type 'A'.
"call TRANSACTION 'SE11'.

ROLLBACK WORK.
*DATA gs_scarr TYPE scarr.
*gs_scarr-carrid = 'WKO'.
*
*
*"insert scarr from gs_scarr.
*delete  scarr  from gs_scarr.
*IF sy-subrc = 0.
*  WRITE 'Datensatz gelöscht'.
*ELSE.
*  WRITE 'Existierte nicht - fehler'.
*ENDIF.
