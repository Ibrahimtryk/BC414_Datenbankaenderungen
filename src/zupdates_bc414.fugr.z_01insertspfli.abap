FUNCTION Z_01INSERTSPFLI .
*"----------------------------------------------------------------------
*"*"Verbuchungsfunktionsbaustein:
*"
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(IS_SPFLI) TYPE  SPFLI
*"----------------------------------------------------------------------

  INSERT spfli FROM is_spfli.
  IF sy-subrc <> 0.
    MESSAGE 'Insert-Fehler SPFLI' TYPE 'A'.
  ENDIF.



ENDFUNCTION.
