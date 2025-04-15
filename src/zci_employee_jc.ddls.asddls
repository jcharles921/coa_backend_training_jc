@AbapCatalog.sqlViewName: 'ZCIEMPDEPT_JC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Composite View for employees'
@Metadata.ignorePropagatedAnnotations: true
@VDM.viewType: #COMPOSITE
define view ZCI_EMPLOYEE_JC as select from zemployee_jc
  association [0..1] to zdepartment_jc as _Department on $projection.departmentid = _Department.departmentid
{

  key zemployee_jc.employeeid,
  
  zemployee_jc.firstname,
  
  zemployee_jc.lastname,
  
  zemployee_jc.departmentid,
  
  _Department.departmentname,
  
  @Semantics.amount.currencyCode: 'Currency'
  zemployee_jc.salary,
  
  @Semantics.amount.currencyCode: 'Currency'
  zemployee_jc.salary * 12 as AnnualSalary,
  
  @Semantics.currencyCode: true
  zemployee_jc.cuky_field as Currency,
  
  // Expose the association
  _Department
}
