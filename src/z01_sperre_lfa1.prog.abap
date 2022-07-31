*&---------------------------------------------------------------------*
*& Report Z01_SPERRE_LFA1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z01_sperre_lfa1.

DATA gs_lfa1 TYPE lfa1.

gs_lfa1-lifnr = 'A4569'.

CALL FUNCTION 'ENQUEUE_EXLFA1'
  EXPORTING
*   MODE_LFA1    = 'E'
   MANDT        = space
*    lifnr        = gs_lfa1-lifnr
*   X_LIFNR      = ' '
*   _SCOPE       = '2'
*   _WAIT        = ' '
*   _COLLECT     = ' '
  EXCEPTIONS
    foreign_lock = 1
*   SYSTEM_FAILURE       = 2
*   OTHERS       = 3
  .
IF sy-subrc <> 0.
  MESSAGE 'Die Lieferantennummer ist gesperrt durch' && sy-msgv1 TYPE 'I'.

ELSE.
   INSERT lfa1 FROM gs_lfa1.
ENDIF.

write 'Programmende'.
