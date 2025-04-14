CLASS zempl_cds_jc DEFINITION
PUBLIC
FINAL
CREATE PUBLIC.

PUBLIC SECTION.
  INTERFACES zif_empl_management_jc.
PROTECTED SECTION.
PRIVATE SECTION.
ENDCLASS.

CLASS zempl_cds_jc IMPLEMENTATION.

  METHOD zif_empl_management_jc~get_employees.

    SELECT employeeid,
           firstname,
           lastname,
           departmentid,
           departmentname,
           currency,
           salary,
           annualsalary
      FROM zci_employee_jc
      WHERE ( @iv_first_name IS INITIAL OR firstname = @iv_first_name )
        AND ( @iv_last_name IS INITIAL OR lastname = @iv_last_name )
        AND ( @iv_department_name IS INITIAL OR departmentname = @iv_department_name )
      INTO TABLE @DATA(lt_employees).

    rt_employees = CORRESPONDING #( lt_employees ).

  ENDMETHOD.

ENDCLASS.
