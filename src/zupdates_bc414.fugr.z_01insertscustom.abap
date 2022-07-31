FUNCTION z_01insertscustom.
*"----------------------------------------------------------------------
*"*"Verbuchungsfunktionsbaustein:
*"
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(IS_SCUSTOM) TYPE  SCUSTOM
*"----------------------------------------------------------------------
  INSERT scustom FROM is_scustom.
  IF sy-subrc <> 0.
    MESSAGE 'Doppelter Schlüssel in Tabelle Scustom' TYPE 'A'.
  ENDIF.




ENDFUNCTION.
