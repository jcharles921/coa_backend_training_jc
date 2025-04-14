@AbapCatalog.sqlViewName: 'ZBIEMPLOYEE_JC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'BASIC View for employees'
@Metadata.ignorePropagatedAnnotations: true
@VDM.viewType: #BASIC
define view zbi_employee_JC
  as select from zemployee_jc
{
 
  key employeeid,
      firstname,
      lastname,
      departmentid,
      salary ,
      cuky_field
}
