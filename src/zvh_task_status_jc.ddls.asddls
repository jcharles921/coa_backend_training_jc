@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'View helper for maintenace Task'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZVH_TASK_STATUS_JC  as select from DDCDS_CUSTOMER_DOMAIN_VALUE( p_domain_name: 'ZTASK_STATUS_JC' )
{
  @UI.hidden: true
  key domain_name,

  @UI.hidden: true
  key value_position,

  value_low as Status
}
