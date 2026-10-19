@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'child interface view for user details'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_2123_user_dev as select from zt2123_user_dev
    association to parent ZI_2123_user as _User
      on $projection.Emp_Id = _User.Emp_Id
      and $projection.Dev_Id = _User.Dev_Id
{
    key emp_id     as Emp_Id,
    key dev_id     as Dev_Id,
    key serial_no  as Serial_No,
    object_type    as Object_Type,
    object_name    as Object_Name,
    _User
}
