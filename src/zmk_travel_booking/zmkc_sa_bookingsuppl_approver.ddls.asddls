@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection of booking supplement'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZMKC_SA_BOOKINGSUPPL_APPROVER as projection on ZMKI_SA_BOOKINGSUPPL
{
    key TravelId,
    key BookingId,
    key BookingSupplementId,
    SupplementId,
    @Semantics.amount.currencyCode: 'CurrencyCode'
    Price,
    CurrencyCode,
    @Semantics.systemDateTime.lastChangedAt: true
    LastChangedAt,
    /* Associations */
    _Booking: redirected to parent ZMKC_SA_BOOKING_APPROVER,
    _Product,
    _SupplementText,
    _Travel: redirected to ZMKC_SA_TRAVEL_APPROVER
}
