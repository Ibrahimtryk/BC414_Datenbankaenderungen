*&---------------------------------------------------------------------*
*& Report Z00_P3
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z00_p3.

PARAMETERS pa_car TYPE spfli-carrid.
DATA gt_spfli TYPE TABLE OF spfli.
data gv_text type string.

SELECT * FROM spfli INTO TABLE gt_spfli
  WHERE carrid = pa_car.

EXPORT tabelle FROM gt_spfli TO MEMORY ID 'DATEN'.

SUBMIT z00_p4 AND RETURN.

import text to gv_text FROM MEMORY id 'XYDATEN'.
write: / gv_text.
