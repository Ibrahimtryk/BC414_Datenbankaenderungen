FUNCTION z_01_prot_buchungen_sammel.
*"----------------------------------------------------------------------
*"*"Verbuchungsfunktionsbaustein:
*"
*"*"Lokale Schnittstelle:
*"----------------------------------------------------------------------
  DATA ls_sbook TYPE sbook.
  DATA gs_prot TYPE zprot_sbook_01.
  DATA gv_id TYPE i.

  SELECT * FROM sbook INTO ls_sbook
    WHERE order_date = sy-datum.

    SELECT MAX( id ) FROM zprot_sbook_01 INTO gv_id.
    gv_id = gv_id + 1.

    gs_prot-aktion = 'UPDATE'.
    "gs_prot-benutzer = iv_benutzer.
    gs_prot-benutzer = sy-uname.
    "gs_prot-programm = iv_programm.
    gs_prot-programm = sy-cprog.
    gs_prot-bookid = ls_sbook-bookid.
    gs_prot-datum = sy-datum.
    gs_prot-uhrzeit = sy-uzeit.
    gs_prot-id = gv_id.

    INSERT zprot_sbook_01 FROM gs_prot.
    IF sy-subrc = 4.
      MESSAGE 'Fehler in Protokoll Buchungen' TYPE 'A'.
    ENDIF.

  ENDSELECT.




ENDFUNCTION.
