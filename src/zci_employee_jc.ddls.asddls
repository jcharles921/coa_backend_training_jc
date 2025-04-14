@AbapCatalog.sqlViewName: 'ZCIEMPDEPT_JC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Composite View for employees'
@Metadata.ignorePropagatedAnnotations: true
@VDM.viewType: #COMPOSITE
define view ZCI_EMPLOYEE_JC as select from zemployee_jc as emp
left outer join zdepartment_jc as dep
    on emp.departmentid = dep.departmentid
{
    emp.employeeid,
    emp.firstname,
    emp.lastname,
    emp.departmentid,
    dep.departmentname,
    emp.salary,
    emp.salary * 12 as AnnualSalary,
    emp.cuky_field as Currency
}
