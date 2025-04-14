@AbapCatalog.sqlViewName: 'ZCIDEPTAVG_JC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Composite View for Departemnt average'
@Metadata.ignorePropagatedAnnotations: true
@VDM.viewType: #COMPOSITE
define view ZCI_DEP_AVG_JC
  as select from    zdepartment_jc  as dep
    left outer join zbi_employee_JC as emp on dep.departmentid = emp.departmentid
{
  key dep.departmentid,
  dep.departmentname,
  @Semantics.amount.currencyCode: 'Currency'
  avg( emp.salary ) as AverageSalary,
  emp.cuky_field as Currency

  }
  group by
  dep.departmentid,
  dep.departmentname,
  emp.cuky_field
