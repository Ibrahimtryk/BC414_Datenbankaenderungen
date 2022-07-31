*&---------------------------------------------------------------------*
*& Report Z01_NETCT_PERS_NR
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z01_netct_pers_nr.
DATA gv_pers_nr TYPE zempnum01.
data gv_quantity type inri-quantity.
CALL FUNCTION 'NUMBER_GET_NEXT'
  EXPORTING
    nr_range_nr             = '1'
    object                  = 'ZPERSNR'
   QUANTITY                = '10'
    subobject               = 'AA'
*   TOYEAR                  = '0000'
*   IGNORE_BUFFER           = ' '
  IMPORTING
    number                  = gv_pers_nr
   QUANTITY                = gv_quantity
*   RETURNCODE              =
  EXCEPTIONS
    interval_not_found      = 1
    number_range_not_intern = 2
    object_not_found        = 3
    quantity_is_0           = 4
    quantity_is_not_1       = 5
    interval_overflow       = 6
    buffer_overflow         = 7
    OTHERS                  = 8.
IF sy-subrc <> 0.
  MESSAGE `Fehler Sy-SUBRC:` && sy-subrc TYPE 'I'.
  RETURN.
ENDIF.

WRITE : 'Generierte Personalnummer für AA', gv_pers_nr, gv_quantity.
