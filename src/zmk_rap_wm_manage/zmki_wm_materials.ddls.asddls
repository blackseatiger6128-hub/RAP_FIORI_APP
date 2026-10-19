@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Materials Interface View'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZMKI_WM_MATERIALS as select from zmk_t_wm_materia
{
  key material_id   as MaterialId,
      material_name as MaterialName,
      material_type as MaterialType,
      base_unit     as BaseUnit,
      currency      as Currency,

      @Semantics.amount.currencyCode: 'Currency'
      unit_price    as UnitPrice,

      unit_volume   as UnitVolume,
      image_url     as ImageUrl,

      -- Admin alanları
      created_by    as CreatedBy,
      created_at    as CreatedAt,
      changed_by    as ChangedBy,
      changed_at    as ChangedAt
}
