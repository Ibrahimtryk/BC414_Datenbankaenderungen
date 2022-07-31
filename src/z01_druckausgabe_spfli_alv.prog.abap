*&---------------------------------------------------------------------*
*& Report Z01_DRUCKAUSGABE_SPFLI
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z01_druckausgabe_spfli_alv.

DATA gs_spfli TYPE spfli.
DATA save_subrc TYPE sy-subrc.
SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
SELECTION-SCREEN PUSHBUTTON /40(20) gv_push USER-COMMAND spool.
SELECTION-SCREEN END OF BLOCK b1.
SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME.
SELECT-OPTIONS: so_car FOR gs_spfli-carrid,
                so_con FOR gs_spfli-connid.
SELECTION-SCREEN END OF BLOCK b2.
SELECTION-SCREEN BEGIN OF BLOCK b3 WITH FRAME.
PARAMETERS pa_lst AS CHECKBOX USER-COMMAND liste .
SELECTION-SCREEN END OF BLOCK b3.

"DATA gt_spfli TYPE TABLE OF spfli.
DATA go_alv TYPE REF TO cl_salv_table.
DATA go_func TYPE REF TO cl_salv_functions.

INITIALIZATION.
  gv_push = 'Spoolverwaltung'.

AT SELECTION-SCREEN.
  IF sy-ucomm = 'SPOOL'.
    CALL TRANSACTION 'SP02'.
  ENDIF.


START-OF-SELECTION.
  IF pa_lst = 'X'.
    NEW-PAGE PRINT ON NO DIALOG.
  ENDIF.

  SELECT carrid, connid, countryfr, cityfrom, airpfrom, cityto FROM spfli INTO TABLE @DATA(gt_spfli)
    WHERE carrid IN @so_car
     AND  connid IN @so_con.

  IF sy-subrc = 4.
    save_subrc = sy-subrc.
    MESSAGE 'Keine Daten zu dieser Selektion' TYPE 'S'.
  ELSE.
    CALL METHOD cl_salv_table=>factory
    "  EXPORTING
    "   list_display   =  pa_lst
*      r_container    = go_alv
*      container_name =
      IMPORTING
        r_salv_table = go_alv
      CHANGING
        t_table      = gt_spfli.
    go_func = go_alv->get_functions( ).
    go_func->set_all( ).
    CALL METHOD go_alv->display.
  ENDIF.


  IF pa_lst <> abap_false.
    NEW-PAGE PRINT OFF.
    IF save_subrc = 0.
      MESSAGE 'Daten wurden in den Spool geschrieben' TYPE 'S'.
    ENDIF.
  ENDIF.

  IF sy-batch = abap_true.
    ULINE.
    WRITE: / 'Report', sy-repid, 'von User', sy-uname, 'Endzeit', sy-datum, sy-uzeit.
  ENDIF.
