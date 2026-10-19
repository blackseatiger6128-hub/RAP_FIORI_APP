@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Warehouse Inventory Interface View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #L,
  dataClass: #TRANSACTIONAL
}
define view entity ZMKI_WM_INVENTORY as select from zmk_t_wm_inventr as Inventory
 inner join zmk_t_wm_materia  as Material
      on Inventory.material_id = Material.material_id

{
    key Inventory.warehouse_id  as WarehouseId,
    key Inventory.material_id   as MaterialId,
    
     -- Malzeme bilgileri (join'den)
      Material.material_name  as MaterialName,
      Material.material_type  as MaterialType,
      Material.base_unit      as BaseUnit,
      Material.currency       as Currency,
      Material.image_url      as ImageUrl,
    
      @Semantics.amount.currencyCode: 'Currency'
      Material.unit_price     as UnitPrice,
      Material.unit_volume    as UnitVolume,
      
      -- Stok bilgileri
     Inventory.max_stock     as MaxStock,
     Inventory.current_stock as CurrentStock,
     
     -- Hesaplanan: Stok Doluluk %
      @Semantics.quantity.unitOfMeasure: 'BaseUnit'
      cast(
        case Inventory.max_stock
          when 0 then cast( 0 as abap.dec(15,2) )
          else cast(
            ( Inventory.current_stock / Inventory.max_stock ) * 100
            as abap.dec(15,2) )
        end
      as abap.dec(15,2) ) as StockUsagePct,
     
     -- Hesaplanan: Satır Toplam Değer (CurrentStock * UnitPrice)
        @Semantics.amount.currencyCode: 'Currency'
        cast(
          Inventory.current_stock * cast( Material.unit_price as abap.dec(15,2) )
          as abap.dec(15,2) ) as LineTotalValue,

      -- Hesaplanan: Satır Hacim Kullanımı
      cast(
        Inventory.current_stock * Material.unit_volume
        as abap.dec(15,3) )   as LineUsedVolume,
        
      Inventory.shelf_location as ShelfLocation,
      Inventory.batch_no       as BatchNo,
      Inventory.serial_no      as SerialNo,
      
     -- Admin alanları
      Inventory.created_by     as CreatedBy,
      Inventory.created_at     as CreatedAt,
      Inventory.changed_by     as ChangedBy,
      Inventory.changed_at     as ChangedAt
}
