*&---------------------------------------------------------------------*
*& Report Z00_P2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z00_P2.


PARAMETERS pa_flg type scarr-carrid MEMORY ID car.
*data gv_flg type c LENGTH 10.
*get PARAMETER ID 'CAR' field gv_flg.


message 'Bin in Programm 2' && pa_flg type 'I'.
