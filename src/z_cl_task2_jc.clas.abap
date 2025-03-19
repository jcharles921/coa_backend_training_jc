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
    DATA: lt_employees TYPE TABLE OF zemployee_jc, wa_employee TYPE zemployee_jc.
    "Employee Charles
    wa_employee-emp_id   = 'E001'.
    wa_employee-emp_name = 'Jean Charles '.
    wa_employee-emp_age  = '24'.
    wa_employee-emp_pos  = 'Trainee'.
    APPEND wa_employee TO lt_employees.

    "Employee Kevine
    wa_employee-emp_id   = 'E002'.
    wa_employee-emp_name = 'Ishimwe Kevine'.
    wa_employee-emp_age  = '27'.
    wa_employee-emp_pos  = 'Software Engineer'.
    APPEND wa_employee TO lt_employees.

    "Employee Alice
    wa_employee-emp_id   = 'E003'.
    wa_employee-emp_name = 'Alice Johnson'.
    wa_employee-emp_age  = '35'.
    wa_employee-emp_pos  = 'Manager'.
    APPEND wa_employee TO lt_employees.

    " Displaying inserted employees
    out->write( | Table of employees | ).
    out->write( | ------------------ | ).
    LOOP AT lt_employees INTO wa_employee.
      out->write( | Employee ID: { wa_employee-emp_id }, Name: { wa_employee-emp_name }, Age: { wa_employee-emp_age }, Position: { wa_employee-emp_pos } | ).
    ENDLOOP.

  ENDMETHOD.
ENDCLASS.
