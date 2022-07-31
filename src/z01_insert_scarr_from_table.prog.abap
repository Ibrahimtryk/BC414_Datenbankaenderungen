*&---------------------------------------------------------------------*
*& Report Z01_INSERT_SCARR_FROM_TABLE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z01_insert_scarr_from_table.

delete from scarr using client '301' where currcode = 'EUR'.
COMMIT WORK.
DATA gt_scarr TYPE TABLE OF scarr.
SELECT * FROM scarr INTO TABLE gt_scarr.

INSERT scarr USING CLIENT '301' FROM TABLE @gt_scarr ACCEPTING DUPLICATE KEYS.
IF sy-subrc = 0.
  WRITE: 'Alle Datensätze eingefügt', sy-dbcnt.
ELSE.
  WRITE: 'Es konnten nicht alle Datensätze eingefügt werden - nur:', sy-dbcnt.
ENDIF.
