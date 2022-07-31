FUNCTION z_01insertscarr .
*"----------------------------------------------------------------------
*"*"Verbuchungsfunktionsbaustein:
*"
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(IS_SCARR) TYPE  SCARR
*"----------------------------------------------------------------------
  "perform update_mara on COMMIT.
  INSERT scarr FROM is_scarr.

  IF sy-subrc <> 0.
    MESSAGE 'Fehler bei Insert Scarr' TYPE 'A'.
  ENDIF.


ENDFUNCTION.
