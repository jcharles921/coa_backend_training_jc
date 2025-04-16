*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
CLASS lcl_data_inserter DEFINITION FINAL CREATE PUBLIC.
  PUBLIC SECTION.
    CLASS-METHODS insert_data.
ENDCLASS.

CLASS lcl_data_inserter IMPLEMENTATION.

  METHOD insert_data.
    DATA(lt_department) = VALUE z_tt_department_jc(
          ( departmentid = '001' departmentname = 'HR' )
          ( departmentid = '002' departmentname = 'Finance' )
          ( departmentid = '003' departmentname = 'IT' )
          ( departmentid = '004' departmentname = 'Marketing' )
          ( departmentid = '005' departmentname = 'Operations' )
         ).
    DELETE FROM zdepartment_jc.
    INSERT zdepartment_jc FROM TABLE @lt_department.

    DATA(lt_employee) = VALUE z_tt_employees_jc(
          (  employeeid = '001' firstname = 'John'  lastname = 'Doe'     departmentid = '001' cuky_field = 'USD' salary = 50000 )
          (  employeeid = '002' firstname = 'Jane'  lastname = 'Smith'   departmentid = '002' cuky_field = 'USD' salary = 60000 )
          (  employeeid = '003' firstname = 'Mike'  lastname = 'Johnson' departmentid = '003' cuky_field = 'USD' salary = 65000 )
          (  employeeid = '004' firstname = 'Sarah' lastname = 'Lee'     departmentid = '004' cuky_field = 'USD' salary = 55000 )
          (  employeeid = '005' firstname = 'David' lastname = 'Brown'   departmentid = '001' cuky_field = 'USD' salary = 52000 )
          (  employeeid = '006' firstname = 'Lisa'  lastname = 'Wilson'  departmentid = '002' cuky_field = 'EUR' salary = 58000 )
          (  employeeid = '007' firstname = 'Robert' lastname = 'Taylor' departmentid = '005' cuky_field = 'USD' salary = 70000 )
         ).
    DELETE FROM zemployee_jc.
    INSERT zemployee_jc FROM TABLE @lt_employee.
  ENDMETHOD.

ENDCLASS.
