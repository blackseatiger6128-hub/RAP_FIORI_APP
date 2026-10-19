@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'User details'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZI_2123_user as select from zt2123_user
   composition [0..*] of ZI_2123_user_dev as _UserDev

{
    key   emp_id             as Emp_Id,
    key   dev_id             as Dev_Id,
    dev_description          as Dev_Description,
    @Semantics.largeObject: { 
      mimeType: 'Mime_Type',
      fileName: 'File_Name',
      acceptableMimeTypes: [ 'application/vnd.ms-excel', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' ]
      //contentDispositionPreferece: #ATTACHMENT
    }
    attachment               as Attachment,
    @Semantics.mimeType: true
    mimetype                 as Mime_Type,
    //@Semantics.filePath: true
    filename                 as File_Name,
    file_status              as File_Status,
    template_status          as Templete_Status,
    case file_status
       when 'File Selected' then 2
       when 'File Uploaded' then 3
       when 'File not Selected' then 1
       else 0
    end as Criticality,
    case template_status
       when 'Present' then 3
       when 'Absent' then 1
       else 0
    end as Template_Criticality,
    @Semantics.user.createdBy: true
    local_created_by      as Local_Created_By,
    @Semantics.systemDateTime.createdAt: true 
    local_created_at      as Local_Created_At,
    @Semantics.user.lastChangedBy: true
    local_last_changed_by as Local_Last_Changed_By,
    @Semantics.systemDateTime.lastChangedAt: true
    local_last_changed_at as Local_Last_Changed_At,
    @Semantics.systemDateTime.lastChangedAt: true
    last_changed_at       as Last_Changed_At,
    _UserDev

}
