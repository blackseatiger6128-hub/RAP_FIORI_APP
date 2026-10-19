@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection of donation consumption'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions:true
define root view entity ZMKC_SP_DONATION 
 provider contract transactional_query
   as projection on ZMKI_SP_DONATION
{   
    @EndUserText.label: 'Technical Donation UUID'
    key DonationUuid,
    @EndUserText.label: 'Donation Number'
    DonationId,
    @EndUserText.label: 'Donor Name'
    DonorName,
    @EndUserText.label: 'Donor Contact Email'
    DonorEmail,
    @EndUserText.label: 'Food Category'
    FoodCategory,
    @EndUserText.label: 'Food Description'
    FoodDescription,
    @EndUserText.label: 'Donated Quantity'
    @Semantics.quantity.unitOfMeasure:'QuantityUnit'
    Quantity,
    @EndUserText.label: 'Unit of Measure'
    QuantityUnit,
    @EndUserText.label: 'Best-Befor or Expiry Date'
    ExpiryDate,
    @EndUserText.label: 'Pickup Address'
    PickupAddress,
    @EndUserText.label: 'Pickup City'
    PickupCity,
    @EndUserText.label: 'Donation Status'
    Status,
    @EndUserText.label: 'Canncellation Reason'
    CancellationReason,
    @EndUserText.label: 'Created By'
    CreatedBy,
    @EndUserText.label: 'Created On'
    CreatedAt,
    @EndUserText.label: 'Last Updated By'
    LastChangedBy,
    @EndUserText.label: 'Last Updated On'
    LastChangedAt,
    @EndUserText.label: 'Technical Local change Timestamp'
    LocalLastChangedAt,
    _Items : redirected to composition child ZMKC_SP_DONATION_ITEM,
    _Attachments: redirected to composition child ZMKC_SP_DONATTA
}
