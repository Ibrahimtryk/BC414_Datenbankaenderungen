*&---------------------------------------------------------------------*
*& Report Z011_SELECT_CLIENT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z011_select_client.

DATA gs_scarr TYPE scarr.
PARAMETERS pa_ma type scarr-mandt.

SELECT * FROM scarr USING CLIENT @pa_ma INTO @gs_scarr.
  " WHERE mandt = '100' or mandt = '000'.
*  ON CHANGE OF gs_scarr-mandt.
*    ULINE.
*  ENDON.
  WRITE / gs_scarr.

ENDSELECT.
