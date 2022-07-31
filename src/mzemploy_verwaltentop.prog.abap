*&---------------------------------------------------------------------*
*& Include MZEMPLOY_VERWALTENTOP                             Modulpool        SAPMZEMPLOY_VERWALTEN
*&
*&---------------------------------------------------------------------*
PROGRAM SAPMZEMPLOY_VERWALTEN.

tables zemploy01.
data ok_code type sy-ucomm.
data gv_auto_pers type c LENGTH 1.

load-OF-PROGRAM.
get PARAMETER ID 'ZPERS_AUTO' FIELD gv_auto_pers.
