INTERFACE zif_empl_management_jc
  PUBLIC .
   METHODS get_employees
    IMPORTING
      VALUE(iv_first_name) TYPE zfirst_name_task5 OPTIONAL
      VALUE(iv_last_name)  TYPE zlast_name_task5 OPTIONAL
      VALUE(iv_department_name) TYPE zdepartment_name_task5 OPTIONAL
    RETURNING
      VALUE(rt_employees) TYPE ztt_employees_jc.

ENDINTERFACE.
