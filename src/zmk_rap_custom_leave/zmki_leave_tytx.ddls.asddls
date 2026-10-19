@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Leave Type Text Interface'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZMKI_LEAVE_TYTX as select from ZMKDB_LEAVE_TYTX
   association to parent ZMKI_LEAVE_TYPE as _LeaveType 
         on $projection.code = _LeaveType.code 
{
   key code as Code, 
   key spras as Spras, 
   text, 
   _LeaveType 
}



