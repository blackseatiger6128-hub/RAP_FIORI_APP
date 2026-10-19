@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Company Consumption View'
@Metadata.ignorePropagatedAnnotations: true

@UI.headerInfo: {
  typeName: 'Şirket',
  typeNamePlural: 'Şirketler',
  title: {
    type: #STANDARD,
    value: 'CompanyName'
  },
  description: {
    type: #STANDARD,
    value: 'CompanyId'
  }
}

define root view entity ZMKC_WM_COMPANY as select from ZMKI_WM_COMPANY
 association [0..*] to ZMKC_WM_WAREHOUSE as _Warehouse
    on $projection.CompanyId = _Warehouse.CompanyId
{    
     @UI.facet: [{
        id: 'CompanyInfo',
        type: #FIELDGROUP_REFERENCE,
        targetQualifier: 'CompInfo',
        label: 'Şirket Bilgileri',
        position: 10
      }]

    @Consumption.valueHelpDefinition: [{
     entity: {
      name: 'ZMKI_WM_COMPANY',
      element: 'CompanyId'
    }
  }]
      @UI.fieldGroup:     [{ qualifier: 'CompInfo', position: 10, label: 'Şirket Kodu' }]
      @UI.lineItem: [{ position: 10, label: 'Şirket Kodu' }]
      @UI.selectionField: [{ position: 10 }]
      @UI.identification: [{ position: 10 }]   
    key CompanyId,
    
    @Consumption.valueHelpDefinition: [{
      entity: {
        name: 'ZMKI_WM_COMPANY',
        element: 'CompanyName'
     }
   }]
      @UI.fieldGroup:     [{ qualifier: 'CompInfo', position: 20, label: 'Şirket Adı' }]
      @UI.lineItem:       [{ position: 20, label: 'Şirket Adı' }]
      @UI.selectionField: [{ position: 20 }]
      @UI.identification: [{ position: 20 }]
    CompanyName,
    
     @UI.fieldGroup:     [{ qualifier: 'CompInfo', position: 30, label: 'Ülke' }]
      @UI.lineItem:       [{ position: 30, label: 'Ülke' }]
        @Consumption.valueHelpDefinition: [{
        entity: {
          name: 'I_Country',
          element: 'Country'
        }
      }]
    
    Country,
    
    @UI.fieldGroup:     [{ qualifier: 'CompInfo', position: 40, label: 'Şehir' }]
    @UI.lineItem:       [{ position: 40, label: 'Şehir' }]
    
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
    
    @UI.fieldGroup:     [{ qualifier: 'CompInfo', position: 50, label: 'Aktif' }]
      @UI.lineItem:       [{
        position: 50,
        label: 'Durum',
        criticality: 'ActiveCriticality',
        criticalityRepresentation: #WITH_ICON
      }]
    IsActive,
    
    @UI.hidden: true
    ActiveCriticality,
    
    -- Admin
   @UI.lineItem: [{ position: 60, label: 'Oluşturma Zamanı' }]
   @UI.fieldGroup: [{ qualifier: 'BasicInfo', position: 100, label: 'Oluşturma Zamanı' }]
   @Semantics.user.createdBy: true
    CreatedBy,
    
   @UI.lineItem: [{ position: 70, label: 'Değiştirme Zamanı' }]
   @UI.fieldGroup: [{ qualifier: 'BasicInfo', position: 110, label: 'Değiştirme Zamanı' }]
   @Semantics.systemDateTime.createdAt: true
    CreatedAt,
    
   @UI.lineItem: [{ position: 80, label: 'Oluşturan Kullanıcı' }]
   @UI.fieldGroup: [{ qualifier: 'BasicInfo', position: 120, label: 'Oluşturan' }]
   @Semantics.user.lastChangedBy: true
    ChangedBy,
    
   @UI.lineItem: [{ position: 90, label: 'Değiştiren Kullanıcı' }]
   @UI.fieldGroup: [{ qualifier: 'BasicInfo', position: 130, label: 'Değiştiren' }]
   @Semantics.systemDateTime.lastChangedAt: true
    ChangedAt,
    
   -- Association
   _Warehouse

}
