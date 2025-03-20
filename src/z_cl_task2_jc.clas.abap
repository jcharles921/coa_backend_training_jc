CLASS z_cl_task2_jc DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .
  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS z_cl_task2_jc IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

    "(3) Internal table for employees
    DATA: ls_employee TYPE zemployee_jc.

    "Populate table with inline VALUE declarations
    Data(lt_employees) = VALUE z_tt_employees_jc(
      ( emp_id = 'E001' emp_name = 'Jean Charles'  emp_age = '24' emp_pos = 'Trainee' )
      ( emp_id = 'E002' emp_name = 'Ishimwe Kevine' emp_age = '27' emp_pos = 'Software Engineer' )
      ( emp_id = 'E003' emp_name = 'Alice Johnson'  emp_age = '35' emp_pos = 'Manager' )
    ).

    " Displaying inserted employees
    out->write( | Table of employees | ).
    out->write( | ------------------ | ).
    LOOP AT lt_employees INTO ls_employee.
      out->write( | Employee ID: { ls_employee-emp_id }, Name: { ls_employee-emp_name }, Age: { ls_employee-emp_age }, Position: { ls_employee-emp_pos } | ).
    ENDLOOP.

  ENDMETHOD.
ENDCLASS.
