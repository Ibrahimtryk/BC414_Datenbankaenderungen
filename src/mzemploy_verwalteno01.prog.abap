*&---------------------------------------------------------------------*
*&  Include           MZEMPLOY_VERWALTENO01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  STATUS_0100  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
  SET PF-STATUS 'STATUS_0100'.
*  SET TITLEBAR 'xxx'.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  SCREEN_VERAENDERN  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE screen_veraendern OUTPUT.
  IF gv_auto_pers = 'X'.
    LOOP AT SCREEN INTO screen.
      IF screen-name CS 'EMP_NUM'.
        screen-active = 0.
        MODIFY screen FROM screen.
      ENDIF.
    ENDLOOP.
  ENDIF.
ENDMODULE.
