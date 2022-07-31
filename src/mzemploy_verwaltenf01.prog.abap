*----------------------------------------------------------------------*
***INCLUDE MZEMPLOY_VERWALTENF01.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Form  NUMBER_GET_NEXT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_ZEMPLOY01_EMP_NUM  text
*----------------------------------------------------------------------*
FORM number_get_next  USING    p_zemploy01_emp_num p_zemploy01_carrier.
  CALL FUNCTION 'NUMBER_GET_NEXT'
    EXPORTING
      nr_range_nr                   = '01'
      object                        = 'Y01PERSNR'
*     QUANTITY                      = '1'
     SUBOBJECT                     =  p_zemploy01_carrier
*     TOYEAR                        = '0000'
*     IGNORE_BUFFER                 = ' '
   IMPORTING
     NUMBER                        = p_zemploy01_emp_num
*     QUANTITY                      =
*     RETURNCODE                    =
   EXCEPTIONS
     INTERVAL_NOT_FOUND            = 1
     NUMBER_RANGE_NOT_INTERN       = 2
     OBJECT_NOT_FOUND              = 3
     QUANTITY_IS_0                 = 4
     QUANTITY_IS_NOT_1             = 5
     INTERVAL_OVERFLOW             = 6
     BUFFER_OVERFLOW               = 7
     OTHERS                        = 8
            .
  IF sy-subrc <> 0.
    message `Fehler bei Nummernvergabe SY-SUBRC: ` && sy-subrc type 'I'.
  ENDIF.
ENDFORM.
