*&---------------------------------------------------------------------*
*& Report Z01_USER_AUS_MANDANT_000
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z01_user_aus_mandant_000.
*SELECT * FROM usr02 USING CLIENT '001' INTO TABLE @DATA(gt_usr02).
*BREAK-POINT.
*
*LEAVE PROGRAM.
SELECT SINGLE * FROM usr02 USING CLIENT '100' INTO @DATA(gs)
      WHERE bname = 'TDC'.
IF sy-subrc = 0.
  update usr02 USING CLIENT '001' FROM @gs.
ENDIF.
