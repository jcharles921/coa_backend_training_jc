*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
CLASS lcl_helper DEFINITION FINAL CREATE PUBLIC.
  PUBLIC SECTION.
    METHODS populate_department_table.
    METHODS populate_employee_table.
    METHODS get_department_data
      RETURNING VALUE(rt_department) TYPE z_tt_department_jc.
    METHODS get_employee_data
      RETURNING VALUE(rt_employee) TYPE z_tt_employees_jc.
ENDCLASS.

CLASS lcl_helper IMPLEMENTATION.

  METHOD populate_department_table.
    DATA(lt_department) = VALUE z_tt_department_jc(
          ( departmentid = '001' departmentname = 'HR' )
          ( departmentid = '002' departmentname = 'Finance' )
          ( departmentid = '003' departmentname = 'IT' )
          ( departmentid = '004' departmentname = 'Marketing' )
          ( departmentid = '005' departmentname = 'Operations' )
         ).
    DELETE FROM zdepartment_jc.
    INSERT zdepartment_jc FROM TABLE @lt_department.
  ENDMETHOD.

  METHOD populate_employee_table.
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

  METHOD get_department_data.
    SELECT * FROM zdepartment_jc INTO TABLE @rt_department.
  ENDMETHOD.

  METHOD get_employee_data.
    SELECT * FROM zemployee_jc INTO TABLE @rt_employee.
  ENDMETHOD.

ENDCLASS.
