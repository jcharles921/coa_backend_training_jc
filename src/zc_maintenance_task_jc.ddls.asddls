@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Maintenance Task Projection View'
@Metadata.allowExtensions: true
define view entity ZC_MAINTENANCE_TASK_JC
  as projection on zi_maintenance_task_jc as Task
{
  key TaskId,
      equipment_id,
      @Search.defaultSearchElement: true
      TaskDescription,
      Status,
      DueDate,
      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt,
      LocalLastChanged,

      /* Associations */
      _Equipment : redirected to parent ZC_EQUIPMENT_JC
}
