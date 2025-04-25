@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Equipment Data Definition'
@Metadata.ignorePropagatedAnnotations: true

define root view entity ZI_EQUIPMENT_JC
  as select from zequipment_jc as Equipment
   composition [0..*] of ZI_MAINTENANCE_TASK_JC as _MaintenanceTasks
{
 key equipment_id ,
      equipment_name as EquipmentName,
      location as Location,
      equipment_type as EquipmentType,
      @Semantics.user.createdBy: true
      created_by as CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      created_at as CreatedAt,
      @Semantics.user.lastChangedBy: true
      last_changed_by as LastChangedBy,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at as LastChangedAt,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed as LocalLastChanged,
      
     _MaintenanceTasks
}
