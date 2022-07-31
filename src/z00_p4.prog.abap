*&---------------------------------------------------------------------*
*& Report Z00_P4
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z00_p4.

DATA gt_daten TYPE TABLE OF spfli.
data gv_meldung type string.

IMPORT tabelle TO gt_daten FROM MEMORY ID 'DATEN'.

IF gt_daten IS NOT INITIAL.
  gv_meldung = 'Es sind Daten in der Tabelle'.
  LOOP AT gt_daten INTO DATA(gs_spfli).
    WRITE: / gs_spfli-carrid, gs_spfli-connid.
  ENDLOOP.
else.
  gv_meldung = 'Die Tabelle war leer'.
ENDIF.

export text from gv_meldung TO MEMORY id 'DATEN'.

WRITE 'Ende Programm 4'.
