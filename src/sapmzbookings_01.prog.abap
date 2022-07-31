*&---------------------------------------------------------------------*
*& Modulpool SAPMBC414_BOOK_UPDATE_S
*&---------------------------------------------------------------------*

INCLUDE MZBOOKINGS_01TOP.
*INCLUDE MBC414_BOOK_UPDATE_STOP.
INCLUDE MZBOOKINGS_01O01.
*INCLUDE MBC414_BOOK_UPDATE_SO01.
INCLUDE MZBOOKINGS_01I01.
*INCLUDE MBC414_BOOK_UPDATE_SI01.
INCLUDE MZBOOKINGS_01F01.
*INCLUDE MBC414_BOOK_UPDATE_SF01.
INCLUDE MZBOOKINGS_01F02.
*INCLUDE MBC414_BOOK_UPDATE_SF02.
*&---------------------------------------------------------------------*
*&      Form  get_number
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM get_number using P_bookid type s_book_id
                      p_carrid type s_carr_id.
CALL FUNCTION 'NUMBER_GET_NEXT'
  EXPORTING
    nr_range_nr                   = '01'
    object                        =  'ZBOOK_01'
*   QUANTITY                      = '1'
   SUBOBJECT                     = p_carrid
*   TOYEAR                        = '0000'
*   IGNORE_BUFFER                 = ' '
 IMPORTING
   NUMBER                        = p_bookid
*   QUANTITY                      =
*   RETURNCODE                    =
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
   message 'Fhler bei automatischer Buchungsnummer:' && sy-subrc type 'I'.
ENDIF.



ENDFORM.
