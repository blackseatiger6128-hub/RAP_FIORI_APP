@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'user details projection'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZC_2123_USER 
  provider contract transactional_query 
   as projection on ZI_2123_user
{
    key Emp_Id,
    key Dev_Id,
    Dev_Description,
    @Semantics.largeObject: { 
      mimeType: 'Mime_Type',
      fileName: 'File_Name',
      acceptableMimeTypes: [ 'application/vnd.ms-excel', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' ]
      //contentDispositionPreferece: #ATTACHMENT
    }
    Attachment,
    @Semantics.mimeType: true
    Mime_Type,
    File_Name,
    File_Status,
    Templete_Status,
    Criticality,
    Template_Criticality,
    Local_Created_By,
    Local_Created_At,
    Local_Last_Changed_By,
    Local_Last_Changed_At,
    Last_Changed_At,
    /* Associations */
    _UserDev: redirected to composition child ZC_2123_USER_DEV

}
