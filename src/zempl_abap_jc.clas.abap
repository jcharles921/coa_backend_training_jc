CLASS zempl_abap_jc DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES zif_empl_management_jc.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zempl_abap_jc IMPLEMENTATION.

  METHOD zif_empl_management_jc~get_employees.
    DATA(lt_employees) = VALUE ztt_employees_jc( ).

    SELECT e~employeeid,
           e~firstname,
           e~lastname,
           e~departmentid,
           d~departmentname,
           e~cuky_field AS currency,
           e~salary,
           e~salary * 12 AS annualsalary
      FROM zemployee_jc AS e
      INNER JOIN zdepartment_jc AS d
        ON e~departmentid = d~departmentid
      WHERE ( @iv_first_name IS INITIAL OR e~firstname = @iv_first_name )
        AND ( @iv_last_name IS INITIAL OR e~lastname = @iv_last_name )
        AND ( @iv_department_name IS INITIAL OR d~departmentname = @iv_department_name )
      INTO TABLE @lt_employees.
    rt_employees = lt_employees.

  ENDMETHOD.

ENDCLASS.

