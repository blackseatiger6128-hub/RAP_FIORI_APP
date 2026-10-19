@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Root travel node'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZMKI_SA_TRAVEL as select from /dmo/travel_m
 composition[0..*] of ZMKI_SA_BOOKING as _Booking
 association[1..1] to /DMO/I_Agency as _Agency on
   $projection.AgencyId = _Agency.AgencyID
 association[1..1] to /DMO/I_Customer as _Customer on
   $projection.CustomerId = _Customer.CustomerID
 association[1..1] to I_Currency as _Currency on
   $projection.CurrencyCode = _Currency.Currency  
 association[1..1] to /DMO/I_Overall_Status_VH as _OverallStatus on
   $projection.OverallStatus = _OverallStatus.OverallStatus     
{
   key travel_id as TravelId,
   agency_id as AgencyId,
   _Agency.Name as AgencyName,
   customer_id as CustomerId,
   _Customer.FirstName as CustomerName,
   begin_date as BeginDate,
   end_date as EndDate,
   @Semantics.amount.currencyCode: 'CurrencyCode'
   booking_fee as BookingFee,
   @Semantics.amount.currencyCode: 'CurrencyCode'
   total_price as TotalPrice,
   currency_code as CurrencyCode,
   description as Description,
   @ObjectModel.text.element: ['StatusText']
   @Consumption.valueHelpDefinition: [{ entity: { name: '/DMO/I_Overall_Status_VH', element: 'OverallStatus' } }]
   overall_status as OverallStatus,
   case overall_status
     when 'O' then 2 //yellow
     when 'A' then 3 // green
     else 1
   end as Criticality,
   //_OverallStatus üzerinden _Text ilişkisine geçip, oradan Text alanını çekmeye çalıştığınızda 
   //syntax veya runtime seviyesinde eşleşme problemi yaşanır. Çünkü _Text bir list (to-many) ilişkisidir ([0..*]). 
   //To-many ilişkiler üzerinden doğrudan alan çekmek (_Text.Text) CDS tarafında kardinalite hatasına veya 
   //boş veri dönmesine sebep olur.
   @Semantics.text: true
   _OverallStatus._Text[1: Language = $session.system_language].Text as StatusText,
   //@Semantics.text: true
   //_OverallStatus._Text[1: Language = 'E'].Text as StatusText,
   @Semantics.user.createdBy: true
   created_by as CreatedBy,
   @Semantics.systemDateTime.createdAt: true
   created_at as CreatedAt,
   @Semantics.user.lastChangedBy: true
   last_changed_by as LastChangedBy,
   @Semantics.systemDateTime.lastChangedAt: true 
   last_changed_at as LastChangedAt,
   _Agency,
   _Customer,
   _Currency,
   _OverallStatus,
   _Booking
}
