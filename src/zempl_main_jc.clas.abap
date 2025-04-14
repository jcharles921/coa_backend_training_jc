CLASS zempl_main_jc DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zempl_main_jc IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.
    DATA: lo_employee_manager TYPE REF TO zif_empl_management_jc,
          lt_employees        TYPE ztt_employees_jc.

    DATA(lo_data_inserter) = NEW lcl_data_inserter( ).
    lo_data_inserter->insert_data( ).
    out->write( 'Data inserted into the database.' ).
    out->write( |\r| ).

    TRY.
        " Get instance of CDS implementation
        lo_employee_manager = zempl_factory_jc=>get_employee_instance( 'CDS' ).
        out->write( '======= CDS Implementation =======' ).
        out->write( |\r| ).

        lt_employees = lo_employee_manager->get_employees( ).
        out->write( 'All employees:' ).
        out->write( lt_employees ).
        out->write( |\r| ).

        lt_employees = lo_employee_manager->get_employees( iv_last_name = 'Doe' ).
        out->write( 'Employees with last name "Doe":' ).
        out->write( lt_employees ).
        out->write( |\r| ).

        lt_employees = lo_employee_manager->get_employees( iv_first_name = 'John' ).
        out->write( 'Employees with first name "John":' ).
        out->write( lt_employees ).
        out->write( |\r| ).
        lt_employees = lo_employee_manager->get_employees( iv_department_name = 'Finance' ).
        out->write( 'Employees in department "Finance":' ).
        out->write( lt_employees ).
        out->write( |\r| ).

        " Switch instance to ABAP implementation
        lo_employee_manager = zempl_factory_jc=>get_employee_instance( 'ABAP' ).
        out->write( '======= ABAP Implementation =======' ).
        out->write( |\r| ).

        lt_employees = lo_employee_manager->get_employees( iv_department_name = 'SAP' ).
        out->write( 'Employees in department "SAP":' ).
        out->write( 'Should return an empty table:' ).
        out->write( lt_employees ).
        out->write( |\r| ).

        lt_employees = lo_employee_manager->get_employees( iv_first_name = 'Jane' ).
        out->write( 'Employees with first name "Jane":' ).
        out->write( lt_employees ).
        out->write( |\r| ).
        lt_employees = lo_employee_manager->get_employees( iv_last_name = 'Smith' ).
        out->write( 'Employees with last name "Smith":' ).
        out->write( lt_employees ).

      CATCH cx_root INTO DATA(lx_root).
        out->write( 'Error occurred:' ).
        out->write( lx_root->get_text( ) ).
    ENDTRY.
  ENDMETHOD.
ENDCLASS.
