*"* use this source file for your ABAP unit test classes

*/**TESTING THE AMDP METHODS*/
CLASS ltcl_tester DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    METHODS test_apply_filter FOR TESTING RAISING cx_static_check.
    METHODS test_schema FOR TESTING RAISING cx_static_check.

    METHODS:setup, teardown.

ENDCLASS.


CLASS ltcl_tester IMPLEMENTATION.


  METHOD setup.

  ENDMETHOD.

  METHOD teardown.
  ENDMETHOD.



  METHOD test_apply_filter.
**How do we filter a table
* cl_abap_unit_assert=>fail( 'Always start with A Failure first!' ).

    DATA(lv_carrid) = 'AA'.
    DATA(lv_connid) = '0017'.
    DATA(lv_where) = | CARRID  = '{ lv_carrid }' AND  CONNID  = '{ lv_connid }'|.

** call
    zcl_amdp_schema_demo=>test_apply_filter(
     EXPORTING iv_where = lv_where
     IMPORTING flight_tab = DATA(lt_tab)
     ).



  ENDMETHOD.

  METHOD test_schema.

    DATA(lv_sw_blockid) = 309.
    DATA(lv_where) = | sw_blockid = '{ lv_sw_blockid } ' |.
** call
    zcl_amdp_schema_demo=>test_schema( iv_where =  lv_where ).


  ENDMETHOD.

ENDCLASS.