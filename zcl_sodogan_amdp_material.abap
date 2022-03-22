class zcl_sodogan_amdp_material definition
  public
  final
  create public .

   public section.
   types: begin of ty_material,
           matnr type mara-matnr,
           matkl type mara-matkl,
           mtart type mara-mtart,
           maktx type makt-maktx,
           end of ty_material.

   types: tt_mara type standard table of ty_material with empty key.
   interfaces if_amdp_marker_hdb .
   class-methods get_material_data importing value(iv_matnr) type mara-matnr
                                             value(iv_mandt) type sy-mandt
                                   exporting value(et_data) type tt_mara
                                   .

  protected section.
  private section.
endclass.



class zcl_sodogan_amdp_material implementation.
  method get_material_data by database procedure
                           for hdb language sqlscript
                           options read-only
                           using mara makt.
**Get the current client
*  declare lv_mandt  nvarchar( 13 );
 

  et_data = select M.matnr,
                   M.matkl,
                   M.mtart,
                   X.maktx
               from mara as M
               inner join makt as X on
               M.mandt = X.mandt AND
               M.matnr = X.matnr
             where M.mandt = :iv_mandt
             AND M.matnr = :iv_matnr ;

  endmethod.

endclass.