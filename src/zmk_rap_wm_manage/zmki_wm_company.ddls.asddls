@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Company Interface View'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZMKI_WM_COMPANY
  as select from zmk_t_wm_company
{
  key company_id   as CompanyId,
      company_name as CompanyName,
      country      as Country,
      city         as City,
      is_active    as IsActive,
      case is_active
        when 'X' then cast( 3 as abap.int1 )
        else          cast( 1 as abap.int1 )
      end          as ActiveCriticality,
      -- Admin alanları
      created_by   as CreatedBy,
      created_at   as CreatedAt,
      changed_by   as ChangedBy,
      changed_at   as ChangedAt
}
