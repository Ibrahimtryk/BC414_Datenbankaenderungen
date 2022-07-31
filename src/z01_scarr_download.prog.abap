*&---------------------------------------------------------------------*
*& Report Z01_SCARR_DOWNLOAD
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z01_scarr_download.

DATA gt_scarr TYPE TABLE OF scarr.
SELECT * FROM scarr INTO TABLE gt_scarr.

data gv_datei type c LENGTH 20 value 'SCARR.TXT'.

open DATASET gv_datei for OUTPUT ENCODING DEFAULT in TEXT MODE.

loop at gt_scarr into data(gs_scarr).
  TRANSFER gs_scarr TO gv_datei.
ENDLOOP.

WRITE 'Datei übertragen'.
