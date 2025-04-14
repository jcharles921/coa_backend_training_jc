CLASS z_seeder_jc DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS z_seeder_jc IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.
    DATA(lo_helper) = NEW lcl_helper( ).

    out->write( |Starting Seeding ...| ).

    " Populate Department Table
    lo_helper->populate_department_table( ).

    " Populate Employee Table
    lo_helper->populate_employee_table( ).

    " Fetch and Print Department Data
    DATA(lt_department) = lo_helper->get_department_data( ).
    LOOP AT lt_department INTO DATA(ls_department).
      out->write( | Department Name: { ls_department-departmentname }| ).
    ENDLOOP.

    " Fetch and Print Employee Data
    DATA(lt_employee) = lo_helper->get_employee_data( ).
    LOOP AT lt_employee INTO DATA(ls_employee).
      out->write( |Employee ID: { ls_employee-employeeid }, Name: { ls_employee-firstname } { ls_employee-lastname }, Department ID: { ls_employee-departmentid }, Salary: { ls_employee-salary } { ls_employee-cuky_field }| ).
    ENDLOOP.
    out->write( |Department Table Populated| ).
    out->write( |Employee Table Populated| ).
  ENDMETHOD.
ENDCLASS.

