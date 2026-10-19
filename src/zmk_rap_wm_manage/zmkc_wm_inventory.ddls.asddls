@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Inventory Consumption View'
@Metadata.ignorePropagatedAnnotations: true

@UI.headerInfo: {
  typeName: 'Envanter Kalemi',
  typeNamePlural: 'Envanter Kalemleri',
  title: {
    type: #STANDARD,
    value: 'MaterialName'
  },
  description: {
    type: #STANDARD,
    value: 'MaterialId'
  },
  imageUrl: 'ImageUrl'
}

define view entity ZMKC_WM_INVENTORY
  as select from ZMKI_WM_INVENTORY

  association to parent ZMKC_WM_WAREHOUSE as _Warehouse
    on $projection.WarehouseId = _Warehouse.WarehouseId

  association [1..1] to ZMKC_WM_MATERIALS as _Material
    on $projection.MaterialId = _Material.MaterialId
{
  @UI.facet: [
    {
      id: 'StockKPI',
      purpose: #HEADER,            
      type: #DATAPOINT_REFERENCE,
      targetQualifier: 'StockUsageKPI',
      position: 10
    },
    {
      id: 'ValueKPI',
      purpose: #HEADER,         
      type: #DATAPOINT_REFERENCE,
      targetQualifier: 'ValueKPI',
      position: 20
    },
    {
      id: 'InventoryInfo',
      type: #FIELDGROUP_REFERENCE,
      targetQualifier: 'InvInfo',
      label: 'Envanter Bilgileri',
      position: 30
    }
  ]

  @UI.hidden: true
  key WarehouseId,

  @UI.selectionField: [{ position: 10 }]
  @UI.lineItem: [{ position: 10, label: 'Malzeme Kodu' }]
  @UI.fieldGroup: [{ qualifier: 'InvInfo', position: 10, label: 'Malzeme Kodu' }]
  @Consumption.valueHelpDefinition: [{
    entity: {
      name: 'ZMKC_WM_MATERIALS',
      element: 'MaterialId'
    },
    additionalBinding: [
      {
        localElement: 'MaterialName',
        element: 'MaterialName',
        usage: #RESULT
      },
      {
        localElement: 'MaterialType',
        element: 'MaterialType',
        usage: #RESULT
      },
      {
        localElement: 'BaseUnit',
        element: 'BaseUnit',
        usage: #RESULT
      },
      {
        localElement: 'UnitPrice',
        element: 'UnitPrice',
        usage: #RESULT
      },
      {
        localElement: 'Currency',
        element: 'Currency',
        usage: #RESULT
      },
      {
        localElement: 'UnitVolume',
        element: 'UnitVolume',
        usage: #RESULT
      },
      {
        localElement: 'ImageUrl',
        element: 'ImageUrl',
        usage: #RESULT
      }
    ]
  }]
  key MaterialId,

  @UI.selectionField: [{ position: 20 }]
  @UI.lineItem: [{ position: 15, label: 'Malzeme Adı' }]
  @UI.fieldGroup: [{ qualifier: 'InvInfo', position: 15, label: 'Malzeme Adı' }]
  MaterialName,

  @UI.selectionField: [{ position: 30 }]
  @UI.lineItem: [{ position: 17, label: 'Malzeme Tipi' }]
  @UI.fieldGroup: [{ qualifier: 'InvInfo', position: 17, label: 'Malzeme Tipi' }]
  MaterialType,

  @UI.lineItem: [{ position: 20, label: 'Birim' }]
  @UI.fieldGroup: [{ qualifier: 'InvInfo', position: 20, label: 'Birim' }]
  BaseUnit,

  @UI.lineItem: [{ position: 30, label: 'Birim Fiyat' }]
  @UI.fieldGroup: [{ qualifier: 'InvInfo', position: 30, label: 'Birim Fiyat' }]
  @Semantics.amount.currencyCode: 'Currency'
  UnitPrice,

  @UI.hidden: true
  Currency,

  @UI.fieldGroup: [{ qualifier: 'InvInfo', position: 25, label: 'Birim Hacim (m³)' }]
  UnitVolume,

  @UI.lineItem: [{ position: 40, label: 'Maks. Stok', importance: #HIGH }]
  @UI.fieldGroup: [{ qualifier: 'InvInfo', position: 40, label: 'Maksimum Stok' }]
  MaxStock,

  @UI.lineItem: [{ position: 50, label: 'Mevcut Stok', importance: #HIGH }]
  @UI.fieldGroup: [{ qualifier: 'InvInfo', position: 50, label: 'Mevcut Stok' }]
  CurrentStock,

  @UI.lineItem: [{
    position: 60,
    label: 'Stok Doluluk (%)',
    criticality: 'StockCriticality',
    importance: #HIGH
  }]
  @UI.dataPoint: {
    qualifier: 'StockUsageKPI',          
    title: 'Stok Doluluk Oranı',
    visualization: #PROGRESS,
    targetValue: 100,
    criticality: 'StockCriticality'
  }
  @UI.fieldGroup: [{ qualifier: 'InvInfo', position: 55, label: 'Stok Doluluk (%)' }]
  StockUsagePct,

  @UI.hidden: true
  cast(
    case
      when StockUsagePct >= 70 then cast( 3 as abap.int1 )
      when StockUsagePct >= 30 then cast( 2 as abap.int1 )
      else cast( 1 as abap.int1 )
    end
  as abap.int1 ) as StockCriticality,

  @UI.lineItem: [{ position: 70, label: 'Toplam Değer', importance: #HIGH }]
  @UI.dataPoint: {                      
    qualifier: 'ValueKPI',
    title: 'Toplam Değer',
    visualization: #NUMBER
  }
  @UI.fieldGroup: [{ qualifier: 'InvInfo', position: 60, label: 'Satır Toplam Değer' }]
  @Semantics.amount.currencyCode: 'Currency'
  LineTotalValue,

  @UI.fieldGroup: [{ qualifier: 'InvInfo', position: 65, label: 'Kullanılan Hacim (m³)' }]
  LineUsedVolume,

  @UI.fieldGroup: [{ qualifier: 'InvInfo', position: 80, label: 'Raf Konumu' }]
  ShelfLocation,

  @UI.fieldGroup: [{ qualifier: 'InvInfo', position: 90, label: 'Parti Numarası' }]
  BatchNo,

  @UI.fieldGroup: [{ qualifier: 'InvInfo', position: 100, label: 'Seri Numarası' }]
  SerialNo,

@UI.lineItem: [{ position: 5, label: 'Resim' }]
@UI.fieldGroup: [{ qualifier: 'InvInfo', position: 110, label: 'Resim URL' }]
@Semantics.imageUrl: true
ImageUrl,

  @Semantics.user.createdBy: true
  CreatedBy,

  @Semantics.systemDateTime.createdAt: true
  CreatedAt,

  @Semantics.user.lastChangedBy: true
  ChangedBy,

  @Semantics.systemDateTime.lastChangedAt: true
  ChangedAt,

  _Warehouse,
  _Material
}
