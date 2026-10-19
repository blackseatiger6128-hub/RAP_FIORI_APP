@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Leave Type Interface'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZMKI_LEAVE_TYPE as select from ZMKDB_LEAVE_TYPE
    association [1..*] to ZMKI_LEAVE_TYTX as _Texts 
            on $projection.code = _Texts.code
{
    key code as Code, 
    created_by as CreatedBy, 
    created_at as CreatedAt, 
    changed_by as ChangedBy, 
    changed_at as ChangedAt,
    _Texts
}
