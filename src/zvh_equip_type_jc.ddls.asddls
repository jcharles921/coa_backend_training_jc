@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'View helper for equipment'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZVH_EQUIP_TYPE_JC as select from DDCDS_CUSTOMER_DOMAIN_VALUE( p_domain_name: 'ZEQUIP_TYPE_JC' )
{
  @UI.hidden: true
  key domain_name,

  @UI.hidden: true
  key value_position,

  value_low as EquipmentTypeName
}
