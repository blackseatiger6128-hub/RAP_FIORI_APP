@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Inventory Aggregation View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #L,
  dataClass: #TRANSACTIONAL
}
define view entity ZMKI_WM_INVAGGR as select from zmk_t_wm_inventr as Inv
    left outer join zmk_t_wm_materia as Mat
      on Inv.material_id = Mat.material_id

{
  key Inv.warehouse_id as WarehouseId,

      @DefaultAggregation: #SUM
      sum(
        cast(
          Inv.current_stock * coalesce( cast( Mat.unit_volume as abap.dec(10,4) ), cast( 0 as abap.dec(10,4) ) )
          as abap.dec(15,3) )
      ) as UsedCapacity,

      @DefaultAggregation: #SUM
      sum(
        cast(
          Inv.current_stock * coalesce( cast( Mat.unit_price as abap.dec(15,2) ), cast( 0 as abap.dec(15,2) ) )
          as abap.dec(15,2) )
      ) as StockTotalValue
}
group by Inv.warehouse_id
