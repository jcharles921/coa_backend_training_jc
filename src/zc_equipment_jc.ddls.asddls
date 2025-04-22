@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Equipment Projection View'
@Metadata.allowExtensions: true
define root view entity ZC_EQUIPMENT_JC
  provider contract transactional_query

  as projection on zi_equipment_jc as Equipment
{
  key equipment_id,
      @Search.defaultSearchElement: true
      EquipmentName,
      Location,
      EquipmentType,
      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt,
      LocalLastChanged,
      
      /* Associations */
      _MaintenanceTasks : redirected to composition child ZC_MAINTENANCE_TASK_JC
}
