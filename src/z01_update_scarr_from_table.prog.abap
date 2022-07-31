*&---------------------------------------------------------------------*
*& Report Z01_INSERT_SCARR_FROM_TABLE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z01_update_scarr_from_table.

DATA gt_scarr TYPE TABLE OF scarr.
SELECT * FROM scarr INTO TABLE gt_scarr.

update scarr  FROM TABLE gt_scarr .
IF sy-subrc = 0.
  WRITE: 'Alle Datensätze eingefügt', sy-dbcnt.
ELSE.
  WRITE: 'Es konnten nicht alle Datensätze eingefügt werden - nur:', sy-dbcnt.
ENDIF.
