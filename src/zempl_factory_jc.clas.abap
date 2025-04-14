CLASS zempl_factory_jc DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    CLASS-METHODS get_employee_instance
      IMPORTING
        iv_type TYPE string
      RETURNING
        VALUE(ro_instance) TYPE REF TO zif_empl_management_jc
      RAISING
        cx_sy_create_object_error.
ENDCLASS.

CLASS zempl_factory_jc IMPLEMENTATION.

  METHOD get_employee_instance.
    CASE iv_type.
      WHEN 'CDS'.
        CREATE OBJECT ro_instance TYPE zempl_cds_jc.
      WHEN 'ABAP'.
        CREATE OBJECT ro_instance TYPE zempl_abap_jc.
      WHEN OTHERS.
        RAISE EXCEPTION TYPE cx_sy_create_object_error.
    ENDCASE.
  ENDMETHOD.

ENDCLASS.

