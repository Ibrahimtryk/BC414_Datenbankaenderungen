FUNCTION z_01_prot_buchungen.
*"----------------------------------------------------------------------
*"*"Verbuchungsfunktionsbaustein:
*"
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(IV_BENUTZER) TYPE  SYUNAME
*"     VALUE(IV_PROGRAMM) TYPE  PROGRAM
*"     VALUE(IV_AKTION) TYPE  TEXT40
*"     VALUE(IV_BOOKID) TYPE  S_BOOK_ID
*"----------------------------------------------------------------------

  DATA gs_prot TYPE zprot_sbook_01.
  DATA gv_id TYPE i.
  SELECT MAX( id ) FROM zprot_sbook_01 INTO gv_id.
  gv_id = gv_id + 1.

  gs_prot-aktion = iv_aktion.
  "gs_prot-benutzer = iv_benutzer.
  gs_prot-benutzer = sy-uname.
  "gs_prot-programm = iv_programm.
  gs_prot-programm = sy-cprog.
  gs_prot-bookid = iv_bookid.
  gs_prot-datum = sy-datum.
  gs_prot-uhrzeit = sy-uzeit.
  gs_prot-id = gv_id.

  INSERT zprot_sbook_01 FROM gs_prot.
  IF sy-subrc = 4.
    MESSAGE 'Fehler in Protokoll Buchungen' TYPE 'A'.
  ENDIF.




ENDFUNCTION.
