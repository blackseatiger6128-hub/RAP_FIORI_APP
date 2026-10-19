@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Donation Item'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZMKI_SP_DONATION_ITEM as select from zmkt_sp_donaitem
 association to parent ZMKI_SP_DONATION as _Donation
   on $projection.DonationUuid = _Donation.DonationUuid
{
    key item_uuid as ItemUuid,
    donation_uuid as DonationUuid,
    itemno as ItemNo,
    foodcategory as FoodCategory,
    fooddescription as FoodDescription,
    @Semantics.quantity.unitOfMeasure: 'QuantityUnit'
    quantity as Quantity,
    quantityunit as QuantityUnit,
    expirydate as ExpiryDate,
    createdby as CreatedBy,
    createdat as CreatedAt,
    lastchangedby as LastChangedBy,
    lastchangedat as LastChangedAt,
    locallastchangedat as LocalLastChangedAt,
    _Donation
}
