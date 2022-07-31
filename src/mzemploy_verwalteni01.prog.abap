*&---------------------------------------------------------------------*
*&  Include           MZEMPLOY_VERWALTENI01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
  CASE ok_code.
    WHEN 'EXIT'.
      LEAVE PROGRAM.
    WHEN 'CANCEL'.
      CLEAR zemploy01.
    WHEN 'SAVE'.
      IF gv_auto_pers = 'X'.
        PERFORM number_get_next USING zemploy01-emp_num zemploy01-carrier.
      ENDIF.
      CALL FUNCTION 'ENQUEUE_EZEMPLOY01'
        EXPORTING
*         MODE_ZEMPLOY01       = 'E'
*         CLIENT       = SY-MANDT
          carrier      = zemploy01-carrier
          emp_num      = zemploy01-emp_num
*         X_CARRIER    = ' '
*         X_EMP_NUM    = ' '
*         _SCOPE       = '2'
*         _WAIT        = ' '
*         _COLLECT     = ' '
        EXCEPTIONS
          foreign_lock = 1
*         SYSTEM_FAILURE       = 2
*         OTHERS       = 3
        .
      CASE sy-subrc.
        WHEN 0.

          INSERT zemploy01 FROM zemploy01.
          IF sy-subrc = 0.
            MESSAGE 'Der Datensatz wurde gespeichert' TYPE 'S'.
          ELSE.
            MESSAGE 'Die Personalnummer ist bereits belegt' TYPE 'I'.
          ENDIF.
      ENDCASE.
    WHEN 1.
      MESSAGE 'Diese Personalnummer ist in der Fluggesellschaft gesperrt' TYPE 'I'.
      LEAVE TO SCREEN 100.
  ENDCASE.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  PERSONALNUMMER_VORSCHLAG  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
