@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection of travel root'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZMKC_SA_TRAVEL 
  provider contract transactional_query 
     as projection on ZMKI_SA_TRAVEL
{
   @ObjectModel.text.element: [ 'Description' ]
   key TravelId,
   @Consumption.valueHelpDefinition: [{ entity: { name: '/dmo/I_Agency', element: 'AgencyID' } }] 
   @ObjectModel.text.element: [ 'AgencyName' ]
   AgencyId,
   @Semantics.text: true
   AgencyName,
   @Consumption.valueHelpDefinition: [{ entity: { name: '/dmo/I_Customer', element: 'CustomerID' } }] 
   @ObjectModel.text.element: [ 'CustomerName' ]
   CustomerId,
   @Semantics.text: true
   CustomerName,
   BeginDate,
   EndDate,
   @Semantics.amount.currencyCode: 'CurrencyCode'
   BookingFee,
   @Semantics.amount.currencyCode: 'CurrencyCode'
   TotalPrice,
   CurrencyCode,
   @Semantics.text: true
   Description,
   //@Consumption.valueHelpDefinition: [{ entity: { name: '/DMO/I_Overall_Status_VH', element: 'OverallStatus' } }] 
   //@ObjectModel.text.element: [ 'StatusText' ]
   @ObjectModel.text.association: '_OverallStatus'
   OverallStatus,
   Criticality,
   @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_MK_SA_VE_CALC'
   @EndUserText.label: 'Co2 Tax'
   virtual Co2Tax: abap.int4,
   @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_MK_SA_VE_CALC'
   @EndUserText.label: 'Week Day'
   virtual dayOfTheLight: abap.char(9),
   //@Semantics.text: true
   StatusText,
   @Semantics.user.createdBy: true
   CreatedBy,
   @Semantics.systemDateTime.createdAt: true
   CreatedAt,
   @Semantics.user.lastChangedBy: true
   LastChangedBy,
   LastChangedAt,
    /* Associations */
    _Agency,
    _Booking: redirected to composition child ZMKC_SA_BOOKING,
    _Currency,
    _Customer,
    _OverallStatus // Verify this is active and matches the interface name casing
}
