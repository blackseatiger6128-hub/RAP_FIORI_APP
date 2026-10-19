@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Warehouse Consumption View'
@Metadata.ignorePropagatedAnnotations: true

@UI.createHidden: false
@UI.updateHidden: false
@UI.deleteHidden: false

@UI.headerInfo: {
  typeName: 'Depo',
  typeNamePlural: 'Depolar',
  title: {
    type: #STANDARD,
    value: 'WarehouseName'
  },
  description: {
    type: #STANDARD,
    value: 'WarehouseId'
  }
}

define root view entity ZMKC_WM_WAREHOUSE as select from ZMKI_WM_WAREHOUSE
  composition [0..*] of ZMKC_WM_INVENTORY as _Inventory
  association [1..1] to ZMKC_WM_COMPANY as _Company
    on $projection.CompanyId = _Company.CompanyId
{
  @UI.facet: [
    {
      id: 'KPI_Cost',
      purpose: #HEADER,
      type: #DATAPOINT_REFERENCE,
      targetQualifier: 'TotalCostKPI',
      position: 10,
      label: 'Toplam Depo Maliyeti'
    },
    {
      id: 'KPI_Capacity',
      purpose: #HEADER,
      type: #DATAPOINT_REFERENCE,
      targetQualifier: 'CapacityKPI',
      position: 20,
      label: 'Hacimsel Doluluk'
    },
    {
      id: 'GeneralInfo',
      type: #COLLECTION,
      label: 'Depo Ana Verileri',
      position: 10
    },
    {
      id: 'BasicFields',
      type: #FIELDGROUP_REFERENCE,
      targetQualifier: 'BasicInfo',
      label: 'Temel Bilgiler',
      parentId: 'GeneralInfo',
      position: 10
    },
    {
      id: 'LocationFields',
      type: #FIELDGROUP_REFERENCE,
      targetQualifier: 'LocationInfo',
      label: 'Konum Bilgileri',
      parentId: 'GeneralInfo',
      position: 20
    },
    {
      id: 'CapacityFields',
      type: #FIELDGROUP_REFERENCE,
      targetQualifier: 'CapacityInfo',
      label: 'Kapasite Bilgileri',
      parentId: 'GeneralInfo',
      position: 30
    },
    {
      id: 'InventoryTab',
      type: #LINEITEM_REFERENCE,
      label: 'Depo Envanteri',
      position: 20,
      targetElement: '_Inventory'
    }
  ]
  @Consumption.valueHelpDefinition: [{
    entity: {
      name: 'ZMKI_WM_WAREHOUSE',
      element: 'WarehouseId'
    }
  }]
  @UI.selectionField: [{ position: 10 }]
  @UI.lineItem: [{ position: 10, label: 'Depo Kodu',importance: #HIGH  }]
  @UI.fieldGroup: [{ qualifier: 'BasicInfo', position: 10, label: 'Depo Kodu' }]
    key WarehouseId,
    
     @UI.selectionField: [{ position: 20 }]
  @UI.lineItem: [{ position: 20, label: 'Şirket Kodu',importance: #HIGH  }]
  @UI.fieldGroup: [{ qualifier: 'BasicInfo', position: 20, label: 'Şirket Kodu' }]
  @Consumption.valueHelpDefinition: [{
    entity: {
      name: 'ZMKC_WM_COMPANY',
      element: 'CompanyId'
    },
    additionalBinding: [{
      localElement: 'CompanyName',
      element: 'CompanyName',
      usage: #RESULT
    }]
  }]
    
    CompanyId,
    
   @UI.lineItem: [{ position: 25, label: 'Şirket Adı' }]
  @UI.fieldGroup: [{ qualifier: 'BasicInfo', position: 25, label: 'Şirket Adı' }]
  CompanyName,
  
  @Consumption.valueHelpDefinition: [{
    entity: {
      name: 'ZMKI_WM_WAREHOUSE',
      element: 'WarehouseName'
    }
  }]
  @UI.selectionField: [{ position: 30 }]
  @UI.lineItem: [{ position: 30, label: 'Depo Adı',importance: #HIGH  }]
  @UI.fieldGroup: [{ qualifier: 'BasicInfo', position: 30, label: 'Depo Adı' }]
  WarehouseName,

  @UI.selectionField: [{ position: 40 }]
  @UI.lineItem: [{ position: 40, label: 'Tip',importance: #HIGH  }]
  @UI.fieldGroup: [{ qualifier: 'BasicInfo', position: 40, label: 'Depo Tipi' }]
  @Consumption.valueHelpDefinition: [{
    entity: {
      name: 'ZMKI_WM_WAREHOUSETYPE',
      element: 'WarehouseType'
    },
    additionalBinding: [{
      localElement: 'WarehouseType',
      element: 'WarehouseType',
      usage: #RESULT
    }]
  }]
  WarehouseType,

  @Consumption.valueHelpDefinition: [{
    entity: {
      name: 'ZMKI_WM_WAREHOUSE',
      element: 'PlantId'
    }
  }]
  @UI.selectionField: [{ position: 50 }]
  @UI.fieldGroup: [{ qualifier: 'BasicInfo', position: 50, label: 'Tesis' }]
  PlantId,

  @UI.selectionField: [{ position: 60 }]
  @UI.lineItem: [{ position: 55, label: 'Ülke',importance: #HIGH  }]
  @UI.fieldGroup: [{ qualifier: 'LocationInfo', position: 10, label: 'Ülke' }]
  @Consumption.valueHelpDefinition: [{
    entity: {
      name: 'I_Country',
      element: 'Country'
    }
  }]
  Country,

  @UI.selectionField: [{ position: 70 }]
  @UI.lineItem: [{ position: 50, label: 'Şehir',importance: #HIGH  }]
  @UI.fieldGroup: [{ qualifier: 'LocationInfo', position: 20, label: 'Şehir' }]
  @Consumption.valueHelpDefinition: [{
    entity: {
      name: 'I_Region',
      element: 'Region'
    },
    additionalBinding: [{
      localElement: 'Country',
      element: 'Country',
      usage: #FILTER_AND_RESULT
    }]
  }]
  City,

  @UI.fieldGroup: [{ qualifier: 'LocationInfo', position: 30, label: 'Posta Kodu' }]
  PostalCode,

  @UI.fieldGroup: [{ qualifier: 'LocationInfo', position: 40, label: 'Tam Adres' }]
  AddressText,

  @UI.fieldGroup: [{ qualifier: 'LocationInfo', position: 50, label: 'Depo Yeri' }]
  StorageLocation,
  
  @UI.lineItem: [{
    position: 60,
    label: 'Durum',
    criticality: 'ActiveCriticality',
    criticalityRepresentation: #WITH_ICON
  }]
  @UI.fieldGroup: [{ qualifier: 'BasicInfo', position: 60, label: 'Aktif' }]
  IsActive,

  @UI.hidden: true
  ActiveCriticality,


  @UI.fieldGroup: [{ qualifier: 'CapacityInfo', position: 10, label: 'Kapasite Birimi' }]
  @Consumption.valueHelpDefinition: [{
    entity: {
      name: 'I_UnitOfMeasure',
      element: 'UnitOfMeasure'
    }
  }]
  CapacityUnit,

  @UI.fieldGroup: [{ qualifier: 'CapacityInfo', position: 20, label: 'Toplam Kapasite' }]
  TotalCapacity,

  @UI.fieldGroup: [{ qualifier: 'CapacityInfo', position: 30, label: 'Kullanılan Kapasite' }]
  UsedCapacity,

  @UI.lineItem: [{
    position: 70,
    label: 'Hacimsel Doluluk (%)',
    criticality: 'CapacityCriticality',
    importance: #HIGH 
  }]
  @UI.dataPoint: {
    qualifier: 'CapacityKPI',
    title: 'Hacimsel Doluluk',
    visualization: #PROGRESS,
    targetValue: 100,
    criticality: 'CapacityCriticality'
  }
  CapacityUsagePct,

  @UI.hidden: true
  CapacityCriticality,


  @UI.fieldGroup: [{ qualifier: 'CapacityInfo', position: 40, label: 'Para Birimi' }]
  @Consumption.valueHelpDefinition: [{
    entity: {
      name: 'I_Currency',
      element: 'Currency'
    }
  }]
  CostCurrency,

  @UI.fieldGroup: [{ qualifier: 'CapacityInfo', position: 50, label: 'Sabit Maliyet' }]
  @Semantics.amount.currencyCode: 'CostCurrency'
  FixedCostTl,


  @UI.lineItem: [{
    position: 80,
    label: 'Toplam Maliyet (TL)', 
    importance: #HIGH 
  }]
  @UI.dataPoint: {
    qualifier: 'TotalCostKPI',
    title: 'Toplam Depo Maliyeti (TL)',
    visualization: #NUMBER
  }
  @Semantics.amount.currencyCode: 'CostCurrency'
  TotalWarehouseCostTl,

  @Semantics.user.createdBy: true
  CreatedBy,

  @Semantics.systemDateTime.createdAt: true
  CreatedAt,

  @Semantics.user.lastChangedBy: true
  ChangedBy,

  @Semantics.systemDateTime.lastChangedAt: true
  ChangedAt,


  _Inventory,
  _Company

}
