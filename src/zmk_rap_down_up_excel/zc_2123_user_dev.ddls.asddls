@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'user details dev projection'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZC_2123_USER_DEV as projection on ZI_2123_user_dev
{
    key Emp_Id,
    key Dev_Id,
    key Serial_No,
    Object_Type,
    Object_Name,
    /* Associations */
    _User: redirected to parent ZC_2123_USER

}
