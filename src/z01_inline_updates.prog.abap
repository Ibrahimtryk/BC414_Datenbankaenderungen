*&---------------------------------------------------------------------*
*& Report Z01_INLINE_UPDATES
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z01_inline_updates.


PARAMETERS: pa_car  TYPE scarr-carrid, "Scarr
            pa_con  TYPE spfli-connid, "Spfli
            pa_cust TYPE scustom-id.  "Scustom


DATA: gs_scarr   TYPE scarr,
      gs_spfli   TYPE spfli,
      gs_scustom TYPE scustom.
"Start DB-LUW
* Sperre Scarr setzen
CALL FUNCTION 'ENQUEUE_EMDGAF_SCARR'
  EXPORTING
    carrid = pa_car
  EXCEPTIONS
    OTHERS = 3.
IF sy-subrc <> 0.
  MESSAGE 'Scarr kann nicht gesperrt werden' TYPE 'I'.
  RETURN.
ENDIF.

set UPDATE TASK LOCAL.

gs_scarr-carrid = pa_car.
CALL FUNCTION 'Z_01INSERTSCARR'
  IN UPDATE TASK
  EXPORTING
    is_scarr = gs_scarr.

MESSAGE 'Datensatz wurde in SCARR vorgemerkt' TYPE 'I'. " Implizites DB-Commit
"Start DB-LUW
* sperre SPFLI setzen
CALL FUNCTION 'ENQUEUE_ESSPFLI'
  EXPORTING
    carrid = pa_car
    connid = pa_con
  EXCEPTIONS
    OTHERS = 3.
IF sy-subrc <> 0.
  MESSAGE 'SPFLI kann nicht gesperrt werden' TYPE 'I'.
  RETURN.
ENDIF.

gs_spfli-carrid = pa_car.
gs_spfli-connid = pa_con.
CALL FUNCTION 'Z_01INSERTSPFLI'
  IN UPDATE TASK
  EXPORTING
    is_spfli = gs_spfli.

MESSAGE 'Spfli wurde vorbereitet' TYPE 'I'.
"Start DB-LUW
* Sperre auf Scustom setzen
CALL FUNCTION 'ENQUEUE_ESCUSTOM'
  EXPORTING
    id     = pa_cust
  EXCEPTIONS
    OTHERS = 3.
IF sy-subrc <> 0.
  MESSAGE 'Scustom kann nicht gepserrt werden' TYPE 'I'.
  RETURN .
ENDIF.

gs_scustom-id = pa_cust.
CALL FUNCTION 'Z_01INSERTSCUSTOM'
  IN UPDATE TASK
  EXPORTING
    is_scustom = gs_scustom.

MESSAGE 'Scustom wurde vorbereitet' TYPE 'I'.
MESSAGE 'Es konnten alle Sperren gesetzt werden' TYPE 'I'.

"ROLLBACK WORK.
"Löschen aller Vormerkungen in VB-Tabellen
"Löschen aller Vormerkungen in Perform-on-Commit-Tabelle
"Löschen aller Sperren
"Rollback auf alle Inline-Änderungen

COMMIT WORK AND WAIT. "Synchrone Verarbeitung
IF sy-subrc = 0.
  MESSAGE 'Verbuchung war erfolgreich' TYPE 'I'.
ELSE.
  MESSAGE 'Verbuchung mit Fehler beendet' TYPE 'I'.
ENDIF.
