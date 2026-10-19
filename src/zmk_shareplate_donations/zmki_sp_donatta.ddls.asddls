@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Shareplate Donation Attachment Interface'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZMKI_SP_DONATTA as select from zmkt_sp_donatta
 association to parent ZMKI_SP_DONATION as _Donation 
  on $projection.DonationUuid = _Donation.DonationUuid 
{ 
  key attachment_uuid as AttachmentUuid, 
  donation_uuid as DonationUuid, 
  file_name as FileName, 
  @Semantics.mimeType: true
  mime_type as MimeType, 
  file_size as FileSize, 
  @Semantics.largeObject: { 
     mimeType: 'MimeType', 
     fileName: 'FileName', 
     acceptableMimeTypes:[ 
        'application/pdf', 
        'image/jpeg', 
        'image/png', 
        'text/plain', 
        'text/csv', 
        'application/msword', 
        'application/vnd.openxmlformats-officedocument.wordprocessingml.document', 
        'application/vnd.ms-excel', 
        'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' ]
    }
  file_content as FileContent, 
  @Semantics.user.createdBy:true
  created_by as CreatedBy, 
  @Semantics.systemDateTime.createdAt: true
  created_at as CreatedAt, 
  @Semantics.user.lastChangedBy: true
  last_changed_by as LastChangedBy, 
  @Semantics.systemDateTime.lastChangedAt: true
  last_changed_at as LastChangedAt, 
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  local_last_changed_at as LocalLastChangedAt, 
  _Donation 
}
