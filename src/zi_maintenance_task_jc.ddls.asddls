@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Maintenance Task Data Definition'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType: {
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}

define view entity ZI_MAINTENANCE_TASK_JC
  as select from zmaintenance_jc as Task
  association to parent ZI_EQUIPMENT_JC as _Equipment on $projection.equipment_id = _Equipment.equipment_id
{
  key task_id            as TaskId,
      equipment_id,
      task_description   as TaskDescription,
      status             as Status,
      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZVH_TASK_STATUS_JC', element: 'Status' } }]
      @Search: { fuzzinessThreshold: 0.7 }
      case status
        when 'OPEN' then 1
        when 'IN PROGRES' then 2
        when 'DONE' then 3
        else 0
      end                as StatusCriticality,
      @Semantics.calendar.month:true
      due_date           as DueDate,
      @Semantics.user.createdBy: true
      created_by         as CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      created_at         as CreatedAt,
      @Semantics.user.lastChangedBy: true
      last_changed_by    as LastChangedBy,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at    as LastChangedAt,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed as LocalLastChanged,

      _Equipment
}
