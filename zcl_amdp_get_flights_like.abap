CLASS zcl_amdp_get_flights DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    types: tt_sflight type STANDARD TABLE OF sflight WITH default key.
    INTERFACES if_amdp_marker_hdb .
    CLASS-METHODS: get_flights importing value(iv_mandt) type sy-mandt
                                         value(iv_planetype) type s_planetpp
                               exporting value(et_data) TYPE tt_sflight
    .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_amdp_get_flights IMPLEMENTATION.
  METHOD get_flights BY DATABASE PROCEDURE
  FOR HDB LANGUAGE SQLSCRIPT
  options READ-ONLY
  USING sflight.


  et_data = select *
               from sflight as S
             where S.mandt = :iv_mandt
            AND S.planetype LIKE  '%' || upper( iv_planetype ) || '%';


  ENDMETHOD.

ENDCLASS.