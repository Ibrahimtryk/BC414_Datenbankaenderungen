*----------------------------------------------------------------------*
*   INCLUDE MBC414_BOOK_UPDATE_SF02
*----------------------------------------------------------------------*

*&---------------------------------------------------------------------*
*&      Form  CHECK_SFLIGHT
*&---------------------------------------------------------------------*
*      <--CS_SDYN_CONN  text
*----------------------------------------------------------------------*
FORM check_sflight CHANGING cs_sdyn_conn TYPE sdyn_conn.

  DATA ls_sflight TYPE sflight.

  SELECT SINGLE * FROM sflight INTO ls_sflight
         WHERE carrid = cs_sdyn_conn-carrid
         AND   connid = cs_sdyn_conn-connid
         AND   fldate = cs_sdyn_conn-fldate.
  IF sy-subrc = 0.
    MOVE-CORRESPONDING ls_sflight TO cs_sdyn_conn.
  ELSE.
    MESSAGE e023 WITH cs_sdyn_conn-carrid
                      cs_sdyn_conn-connid
                      cs_sdyn_conn-fldate.
  ENDIF.

ENDFORM.                    " CHECK_SFLIGHT


*&---------------------------------------------------------------------*
*&      Form  CHECK_SPFLI
*&---------------------------------------------------------------------*
*      <--CS_SDYN_CONN  text
*----------------------------------------------------------------------*
FORM check_spfli CHANGING cs_sdyn_conn TYPE sdyn_conn.

  DATA ls_spfli TYPE spfli.

  SELECT SINGLE * FROM  spfli INTO ls_spfli
       WHERE  carrid  = cs_sdyn_conn-carrid
       AND    connid  = cs_sdyn_conn-connid.
  IF sy-subrc = 0.
    MOVE-CORRESPONDING ls_spfli TO cs_sdyn_conn.
  ELSE.
    MESSAGE e022 WITH cs_sdyn_conn-carrid
                      cs_sdyn_conn-connid.
  ENDIF.

ENDFORM.                    " CHECK_SPFLI


*&---------------------------------------------------------------------*
*&      Form  READ_BOOKINGS
*&---------------------------------------------------------------------*
*      -->PV_CARRID  text
*      -->PV_CONNID  text
*      -->PV_FLDATE  text
*      <--CT_BOOK    text
*      <--CT_CD      text
*----------------------------------------------------------------------*
FORM read_bookings USING    pv_carrid TYPE s_carr_id
                            pv_connid TYPE s_conn_id
                            pv_fldate TYPE s_date
                   CHANGING ct_book   TYPE gty_t_bookings
                            ct_cd     TYPE gty_t_cd.

  DATA ls_cd TYPE sbook.
  FIELD-SYMBOLS <ls_book> TYPE gty_s_bookings.

  CLEAR ct_book.
  CLEAR ct_cd.

  SELECT * FROM sbook INTO CORRESPONDING FIELDS OF TABLE ct_book
         WHERE carrid = pv_carrid
         AND   connid = pv_connid
         AND   fldate = pv_fldate.

  LOOP AT ct_book ASSIGNING <ls_book>.
*   SCUSTOM is buffered (single dataset)
    SELECT SINGLE name FROM scustom INTO <ls_book>-name
           WHERE id = <ls_book>-customid.
    MOVE-CORRESPONDING <ls_book> TO ls_cd.
    APPEND ls_cd TO ct_cd.
  ENDLOOP.
  SORT ct_book BY bookid customid.

ENDFORM.                               " READ_BOOKINGS


*&---------------------------------------------------------------------*
*&      Form  READ_CURRCODE
*&---------------------------------------------------------------------*
*      -->PV_CARRID     text
*      <--CV_LOCCURKEY  text
*----------------------------------------------------------------------*
FORM read_currcode  USING    pv_carrid    TYPE s_carr_id
                    CHANGING cv_loccurkey TYPE s_currcode.

  SELECT SINGLE currcode FROM scarr INTO cv_loccurkey
         WHERE carrid = pv_carrid.

ENDFORM.                    " READ_CURRCODE


************************************************************************
********************************* YOUR CODE ****************************
************************************************************************

*&---------------------------------------------------------------------*
*&      Form  MODIFY_BOOKINGS
*&---------------------------------------------------------------------*
*      -->PT_BOOKINGS_MOD  text
*      -->PS_SDYN_CONN     text
*----------------------------------------------------------------------*
FORM modify_bookings USING pt_bookings_mod TYPE gty_t_sbook
                           ps_sdyn_conn    TYPE sdyn_conn.

  CALL FUNCTION 'UPDATE_SBOOK' IN UPDATE TASK
    EXPORTING
      it_sbook = pt_bookings_mod.
  CALL FUNCTION 'UPDATE_SFLIGHT' IN UPDATE TASK
    EXPORTING
      iv_carrid = ps_sdyn_conn-carrid
      iv_connid = ps_sdyn_conn-connid
      iv_fldate = ps_sdyn_conn-fldate.

ENDFORM.                    " MODIFY_BOOKINGS


*&---------------------------------------------------------------------*
*&      Form  SAVE_NEW_BOOKING
*&---------------------------------------------------------------------*
*      -->PS_SDYN_BOOK  text
*----------------------------------------------------------------------*
FORM save_new_booking USING ps_sdyn_book TYPE sdyn_book.

  DATA ls_sbook  TYPE sbook.

  MOVE-CORRESPONDING ps_sdyn_book TO ls_sbook.

* get customer name
  SELECT SINGLE name FROM scustom INTO ls_sbook-passname
       WHERE id = ls_sbook-customid.
  IF ls_sbook-class IS INITIAL.
    ls_sbook-class = 'Y'.
  ENDIF.

  CALL FUNCTION 'INSERT_SBOOK' IN UPDATE TASK
    EXPORTING
      is_sbook = ls_sbook.
  CALL FUNCTION 'UPDATE_SFLIGHT' IN UPDATE TASK
    EXPORTING
      iv_carrid = ls_sbook-carrid
      iv_connid = ls_sbook-connid
      iv_fldate = ls_sbook-fldate.

ENDFORM.                               " SAVE_NEW_BOOKING
