*&---------------------------------------------------------------------*
*& Report Z01_DRUCKAUSGABE_SPFLI
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z01_druckausgabe_spfli.

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
PARAMETERS pa_lst AS CHECKBOX .
SELECTION-SCREEN END OF BLOCK b3.

INITIALIZATION.
  gv_push = 'Spoolverwaltung'.

AT SELECTION-SCREEN.
  IF sy-ucomm = 'SPOOL'.
    CALL TRANSACTION 'SP02'.
  ENDIF.


START-OF-SELECTION.
  IF pa_lst = abap_true.
    NEW-PAGE PRINT ON NO DIALOG.
  ENDIF.

  SELECT * FROM spfli INTO gs_spfli
    WHERE carrid IN so_car
     AND  connid IN so_con.
    ON CHANGE OF gs_spfli-carrid.
      NEW-PAGE.
    ENDON.
    WRITE: / gs_spfli-carrid UNDER 'Airline' QUICKINFO 'Das ist die Fluggesellschaft',
             gs_spfli-connid UNDER 'Flugnummer',
             gs_spfli-cityto UNDER 'Ankunftstadt',
             gs_spfli-cityfrom UNDER 'Abflugstadt'.
  ENDSELECT.
  IF sy-subrc = 4.
    save_subrc = sy-subrc.
    MESSAGE 'Keine Daten zu dieser Selektion' TYPE 'S'.
  ENDIF.
  IF pa_lst <> abap_false.
    NEW-PAGE PRINT OFF.
    IF save_subrc = 0.
      MESSAGE 'Daten wurden in den Spool geschrieben' TYPE 'S'.
    ENDIF.
  ENDIF.

TOP-OF-PAGE.
  WRITE: 'Airline',
         'Flugnummer',
         'Abflugstadt',
         AT 70 'Ankunftstadt'.
  ULINE.
