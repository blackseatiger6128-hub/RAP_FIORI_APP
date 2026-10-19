@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Warehouse Interface View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #L,
  dataClass: #MASTER
}
define view entity ZMKI_WM_WAREHOUSE as select from ZMK_T_WM_WHOUSE as Warehouse
 inner join ZMK_T_WM_COMPANY as Company
      on Warehouse.company_id = Company.company_id
    left outer join ZMKI_WM_INVAGGR as InvAgg
      on Warehouse.warehouse_id = InvAgg.WarehouseId
{
     key Warehouse.warehouse_id      as WarehouseId,
      Warehouse.company_id        as CompanyId,
      Company.company_name        as CompanyName,
      Warehouse.warehouse_name    as WarehouseName,
      Warehouse.warehouse_type    as WarehouseType,
      Warehouse.plant_id          as PlantId,
      Warehouse.storage_location  as StorageLocation,
      Warehouse.country           as Country,
      Warehouse.city              as City,
      Warehouse.postal_code       as PostalCode,
      Warehouse.address_text      as AddressText,
      Warehouse.capacity_unit     as CapacityUnit,
      Warehouse.total_capacity    as TotalCapacity,
      Warehouse.is_active         as IsActive,
      Warehouse.cost_currency     as CostCurrency,
      
    @Semantics.amount.currencyCode: 'CostCurrency'
      Warehouse.fixed_cost_tl     as FixedCostTl,

      -- Hesaplanan: Kullanılan Kapasite
      cast(
        coalesce( InvAgg.UsedCapacity, cast(0 as abap.dec(15,3)) )
        as abap.dec(15,3) )       as UsedCapacity,

    -- Hesaplanan: Kapasite Doluluk %
  cast(
    case Warehouse.total_capacity
      when cast(0 as abap.dec(15,3))
      then cast(0 as abap.dec(15,2))
      else cast(
        coalesce( InvAgg.UsedCapacity, cast(0 as abap.dec(15,3)) )
        / Warehouse.total_capacity * 100
        as abap.dec(15,2) )
    end
  as abap.dec(15,2) ) as CapacityUsagePct,
  
   case Warehouse.is_active
        when 'X' then 3
        else 1
      end                    as ActiveCriticality,

      -- Capacity Criticality
  cast(
    case
      when Warehouse.total_capacity > 0 
           and ( coalesce( InvAgg.UsedCapacity, 0 ) / Warehouse.total_capacity * 100 ) >= 80
      then 1
      when Warehouse.total_capacity > 0 
           and ( coalesce( InvAgg.UsedCapacity, 0 ) / Warehouse.total_capacity * 100 ) >= 50
      then 2
      else 3
    end
  as abap.int1 ) as CapacityCriticality,
  
     -- Hesaplanan: Toplam Depo Maliyeti TL
  @Semantics.amount.currencyCode: 'CostCurrency'
  cast(
    cast( Warehouse.fixed_cost_tl as abap.dec(15,2) )
    + coalesce( cast( InvAgg.StockTotalValue as abap.dec(15,2) ), 
                cast( 0 as abap.dec(15,2) ) )
    as abap.dec(15,2) 
  ) as TotalWarehouseCostTl,
  
  -- Admin alanları
   Warehouse.created_by        as CreatedBy,
   Warehouse.created_at        as CreatedAt,
   Warehouse.changed_by        as ChangedBy,
   Warehouse.changed_at        as ChangedAt

}
