@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection of booking'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZMKC_SA_BOOKING as projection on ZMKI_SA_BOOKING
{
    key TravelId,
    key BookingId,
    BookingDate,
    CustomerId,
    CarrierId,
    ConnectionId,
    FlightDate,
    @Semantics.amount.currencyCode: 'CurrencyCode'
    FlightPrice,
    CurrencyCode,
    BookingStatus,
    @Semantics.systemDateTime.lastChangedAt: true
    LastChangedAt,
    /* Associations */
    _BookingStatus,
    _Carrier,
    _Connection,
    _Customer,
    
    /*Redirect Assoc*/
    _BookingSupplement: redirected to composition child ZMKC_SA_BOOKINGSUPPL,
    _Travel: redirected to parent ZMKC_SA_TRAVEL
}
