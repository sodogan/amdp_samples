CLASS zcl_amdp_schema_demo DEFINITION
  PUBLIC
   CREATE PUBLIC .

  PUBLIC SECTION.

     INTERFACES: if_amdp_marker_hdb.

    CLASS-METHODS: test_apply_filter IMPORTING VALUE(iv_where)   TYPE string
                                     EXPORTING VALUE(flight_tab) TYPE sflight_tab2  .

     CLASS-METHODS: test_schema  IMPORTING VALUE(iv_where)   TYPE string
*                                     EXPORTING VALUE(flight_tab) TYPE sflight_tab2
.
  PROTECTED SECTION.


  PRIVATE SECTION.

ENDCLASS.



CLASS zcl_amdp_schema_demo IMPLEMENTATION.




  METHOD test_apply_filter BY DATABASE PROCEDURE
                            FOR HDB LANGUAGE SQLSCRIPT
                            OPTIONS READ-ONLY
                             using sflight.


**how do we filter a table -storage
    lt_data = APPLY_FILTER("SFLIGHT", :iv_where) ;


*  for lv_index in 1..record_count( :lt_data )
*    do
*
*  end for;

--   flight_tab = :lt_data;
  flight_tab = select *
                 from
                :lt_data;

  ENDMETHOD.


  METHOD test_schema BY DATABASE PROCEDURE
                            FOR HDB LANGUAGE SQLSCRIPT
                            OPTIONS READ-ONLY
                             using SCHEMA demo_logical_db_schema_to_abap  OBJECTS sw_block .




  lt_filtered_data = APPLY_FILTER("MG_KOTKA"."SW_BLOCK", :iv_where) ;

  lt_data = select top 10  blocknumber
                 FROM "$ABAP.schema( DEMO_LOGICAL_DB_SCHEMA_TO_ABAP )"."SW_BLOCK"
                 ;


  ENDMETHOD.

ENDCLASS.