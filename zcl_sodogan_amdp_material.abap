class zcl_sodogan_amdp_driver definition
  public
  final
  create public .

  public section.
    interfaces if_oo_adt_classrun.

  protected section.

  private section.
    methods select_from_internal_tab.
endclass.



class zcl_sodogan_amdp_driver implementation.

  method if_oo_adt_classrun~main.
    if  cl_abap_dbfeatures=>use_features(
    requested_features = value #( ( cl_abap_dbfeatures=>amdp_table_function )
     ( cl_abap_dbfeatures=>call_amdp_method )
     ) ) .

**Test the AMDP here to select from MARA table!
      data: lv_matnr type mara-matnr value  '2500000000'.
      data(lv_matnr_str) = |{ lv_matnr alpha = in  }|.

      data: ld_delivery_number type vbeln_vl value '80003371'.
      data: ls_delivery_header type likp.

      data(ls_delivery_number) = |{ ld_delivery_number alpha = in }|.


      select_from_internal_tab(  ).

      zcl_sodogan_amdp_test1=>get_material_data(
      exporting
      iv_mandt = sy-mandt
      iv_matnr = lv_matnr
      importing
      et_data =  data(lt_data)
      ).

      out->write( lt_data ).
    else.
      out->write( 'AMDP not supported here!' ).
    endif.
  endmethod.

  method select_from_internal_tab.
    types: tt_scarr type standard table of scarr with empty key.
    DATA:lr_carrid type range of scarr-carrid.
    break sodogan.

    DATA(lt_carriers) = value tt_scarr(
    ( carrid = 'AA' carrname ='aa here')
    ( carrid = 'AB' carrname ='ab here')

    ).


    select carrid,
           SUM( distance ) as total_distance
           from spfli
      into table @data(lt_total_distance)
      group by carrid
      order by carrid
     .


   select 'I' as sign,
          'EQ' as option,
           carrid as low
         from scarr
      into table @lr_carrid
   .


   select 'I' as sign,
          'EQ' as option,
           carrid as low
         from @lt_carriers as carriers
     where carriers~carrid ='AB'
      into table @lr_carrid
   .


    select * from scarr
    into table @data(lt_scarr)
    where carrid = 'AA'
    .


    select * from spfli
    for all entries in @lt_scarr
    where carrid = @lt_scarr-carrid
    into table @data(lt_spfli)
     .

    data(lt_filter) = value tt_scarr( ( carrid = 'AA' ) ).

    select s~carrid,
           f~carrname
            from spfli as s
    inner join @lt_filter as f
     on s~carrid = f~carrid
    into table @data(lt_test)

    .



    break sodogan.





  endmethod.

endclass.