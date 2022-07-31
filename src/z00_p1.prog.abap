*&---------------------------------------------------------------------*
*& Report Z00_P1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z00_P1.

PARAMETERS pa_car type scarr-carrid MEMORY ID car.

*data gv_text type c LENGTH 40.
*get PARAMETER ID 'CLASS' field gv_text.
*write: 'Zuletzt benutzte Klasse', gv_text.
submit z00_p2 AND RETURN VIA SELECTION-SCREEN.
SUBMIT z00_p2
        WITH pa_flg = pa_car.

write 'Zurück in Programm 1'.
