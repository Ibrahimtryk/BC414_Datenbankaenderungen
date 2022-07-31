*&---------------------------------------------------------------------*
*& Report Z01_SFLIGHT_UND_SBOOK_SPERREN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z01_SFLIGHT_UND_SBOOK_SPERREN.

CALL FUNCTION 'ENQUEUE_EZ00_SFLIGHT_BO'
* EXPORTING
*   MODE_SFLIGHT         = 'E'
*   MODE_SBOOK           = 'S'
*   MANDT                = SY-MANDT
*   CARRID               =
   CONNID               =
   FLDATE               =
   BOOKID               =
*   X_CARRID             = ' '
*   X_CONNID             = ' '
*   X_FLDATE             = ' '
*   X_BOOKID             = ' '
*   _SCOPE               = '2'
*   _WAIT                = ' '
*   _COLLECT             = ' '
* EXCEPTIONS
*   FOREIGN_LOCK         = 1
*   SYSTEM_FAILURE       = 2
*   OTHERS               = 3
          .
IF sy-subrc <> 0.
* Implement suitable error handling here
ENDIF.
