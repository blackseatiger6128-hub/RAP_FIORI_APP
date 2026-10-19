@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection of donation attachment'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@UI.presentationVariant: [{ 
        sortOrder: [{ 
            by: 'CreatedAt', 
            direction: #DESC 
            }], 
        visualizations: [{ 
            type: #AS_LINEITEM 
            }] 
        }]
define view entity ZMKC_SP_DONATTA as projection on ZMKI_SP_DONATTA
{
    key AttachmentUuid,
    DonationUuid,
    FileName,
    MimeType,
    FileSize,
     @Semantics.largeObject: {
      mimeType: 'MimeType',
      fileName: 'FileName',
      contentDispositionPreference: #INLINE
    }
    FileContent,
    CreatedBy,
    CreatedAt,
    LastChangedBy,
    LastChangedAt,
    LocalLastChangedAt,
    /* Associations */
    _Donation: redirected to parent ZMKC_SP_DONATION
}
