@AbapCatalog.sqlViewName: 'ZCIDEPTAVG_JC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Composite View for Department average'
@Metadata.ignorePropagatedAnnotations: true
@VDM.viewType: #COMPOSITE
define view ZCI_DEP_AVG_JC
  as select from zdepartment_jc
    association [0..*] to zbi_employee_JC as _Employee on $projection.departmentid = _Employee.departmentid
{
  key zdepartment_jc.departmentid,
  
  zdepartment_jc.departmentname,
      
  @Semantics.amount.currencyCode: 'Currency'
  avg(_Employee.salary) as AverageSalary,
  
  _Employee.cuky_field as Currency,
      
  // Explose the association
  _Employee
}
group by
  zdepartment_jc.departmentid,
  zdepartment_jc.departmentname,
  _Employee.cuky_field
