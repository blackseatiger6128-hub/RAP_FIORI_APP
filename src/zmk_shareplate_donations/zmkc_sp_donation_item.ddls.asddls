@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Donation Item Projection'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions:true
define view entity ZMKC_SP_DONATION_ITEM as projection on ZMKI_SP_DONATION_ITEM
{
    @EndUserText.label:'Technical Item UUID'
    key ItemUuid,
    @EndUserText.label: 'Parent Donation UUID'
    DonationUuid,
    @EndUserText.label: 'Item Number'
    ItemNo,
    @EndUserText.label: 'Food Category'
    FoodCategory,
    @EndUserText.label: 'Food Description'
    FoodDescription,
    @Semantics.quantity.unitOfMeasure: 'QuantityUnit'
    @EndUserText.label: 'Donated Quantity'
    Quantity,
    @EndUserText.label: 'Unit of Measure'
    QuantityUnit,
    @EndUserText.label: 'Bst-Before or Expiry Date'
    ExpiryDate,
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
    /* Associations */
    _Donation : redirected to parent ZMKC_SP_DONATION
}
