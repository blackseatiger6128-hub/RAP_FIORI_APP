@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Material Consumption View'
@Metadata.ignorePropagatedAnnotations: true

@UI.headerInfo: {
  typeName: 'Malzeme',
  typeNamePlural: 'Malzemeler',
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
define root view entity ZMKC_WM_MATERIALS as select from ZMKI_WM_MATERIALS
{
@UI.facet: [
  {
    id: 'MaterialInfo',
    type: #FIELDGROUP_REFERENCE,
    targetQualifier: 'MatInfo',
    label: 'Malzeme Bilgileri',
    position: 10
  }
]

  @Consumption.valueHelpDefinition: [{
    entity: {
      name: 'ZMKI_WM_MATERIALS',
      element: 'MaterialId'
    }
  }]
  @UI.lineItem:       [{ position: 10, label: 'Malzeme Kodu' }]
  @UI.selectionField: [{ position: 10 }]
  @UI.fieldGroup:     [{ qualifier: 'MatInfo', position: 10, label: 'Malzeme Kodu' }]
  key MaterialId,
  
   @Consumption.valueHelpDefinition: [{
    entity: {
      name: 'ZMKI_WM_MATERIALS',
      element: 'MaterialName'
    }
  }]
  @UI.lineItem:       [{ position: 20, label: 'Malzeme Adı' }]
  @UI.selectionField: [{ position: 20 }]
  @UI.fieldGroup:     [{ qualifier: 'MatInfo', position: 20, label: 'Malzeme Adı' }]
  MaterialName,
  
  @UI.lineItem:       [{ position: 30, label: 'Malzeme Tipi' }]
  @UI.selectionField: [{ position: 30 }]
  @UI.fieldGroup:     [{ qualifier: 'MatInfo', position: 30, label: 'Malzeme Tipi' }]
  @Consumption.valueHelpDefinition: [{
    entity: {
      name: 'ZMKI_WM_MATERIALTYPE',
      element: 'MaterialType'
    }
  }]
  MaterialType,
  
  @UI.lineItem:   [{ position: 40, label: 'Birim' }]
  @UI.fieldGroup: [{ qualifier: 'MatInfo', position: 40, label: 'Birim' }]
  @Consumption.valueHelpDefinition: [{
    entity: {
      name: 'I_UnitOfMeasure',
      element: 'UnitOfMeasure'
    }
  }]
  
  BaseUnit,
  
  @UI.lineItem:   [{ position: 50, label: 'Birim Fiyat' }]
  @UI.fieldGroup: [{ qualifier: 'MatInfo', position: 50, label: 'Birim Fiyat' }]
  @Semantics.amount.currencyCode: 'Currency'
  UnitPrice,
  
  @UI.lineItem:   [{ position: 51, label: 'Para Birimi' }]
  @UI.fieldGroup: [{ qualifier: 'MatInfo', position: 51, label: 'Para Birimi' }]
  @Consumption.valueHelpDefinition: [{
    entity: {
      name: 'I_Currency',
      element: 'Currency'
    }
  }]
  Currency,
  
  @UI.fieldGroup: [{ qualifier: 'MatInfo', position: 70, label: 'Birim Hacim' }]
  UnitVolume,
  
  @UI.fieldGroup: [{ qualifier: 'MatInfo', position: 80, label: 'Resim URL' }]
  ImageUrl,
  
  CreatedBy,
  CreatedAt,
  ChangedBy,
  ChangedAt
}
