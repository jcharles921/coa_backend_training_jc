@AbapCatalog.sqlViewName: 'ZBIDEPT_JC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'BASIC View for department'
@Metadata.ignorePropagatedAnnotations: true
define view ZBI_DEPARTMENT_JC
  as select from zdepartment_jc
{
 
  key departmentid,
      departmentname
}
