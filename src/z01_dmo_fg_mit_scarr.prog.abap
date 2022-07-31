*&---------------------------------------------------------------------*
*& Report Z01_DMO_FG_MIT_SCARR
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z01_dmo_fg_mit_scarr.

DATA gs_scarr TYPE scarr.
SELECT * FROM scarr INTO gs_scarr WHERE currcode = 'EUR'.
  CALL FUNCTION 'Z_SET_SCARR_01'
    EXPORTING
      is_scarr = gs_scarr.
ENDSELECT.


DATA gt_fluggesellschaften TYPE TABLE OF scarr.
CALL FUNCTION 'Z_GET_TABLE_SCARR'
  importing
    et_scarr = gt_fluggesellschaften.


BREAK-POINT.
