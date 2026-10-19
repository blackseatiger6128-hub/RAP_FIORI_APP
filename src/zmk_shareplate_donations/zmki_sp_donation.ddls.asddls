@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Shareplate Donation Interface'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZMKI_SP_DONATION as select from zmkt_sp_donation
  composition [0..*] of ZMKI_SP_DONATION_ITEM as _Items
   composition[0..*] of ZMKI_SP_DONATTA as _Attachments
{
    key donation_uuid as DonationUuid,
    donation_id as DonationId,
    donor_name as DonorName,
    donor_email as DonorEmail,
    food_category as FoodCategory,
    food_description as FoodDescription,
    @Semantics.quantity.unitOfMeasure: 'QuantityUnit'
    quantity as Quantity,
    quantity_unit as QuantityUnit,
    expiry_date as ExpiryDate,
    pickup_address as PickupAddress,
    pickup_city as PickupCity,
    status as Status,
    cancellation_reason as CancellationReason,
    created_by as CreatedBy,
    created_at as CreatedAt,
    last_changed_by as LastChangedBy,
    last_changed_at as LastChangedAt,
    local_last_changed_at as LocalLastChangedAt,
    _Items, // Make association public
    _Attachments
}
