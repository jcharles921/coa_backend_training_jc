CLASS z_bank_account_jc DEFINITION
PUBLIC
FINAL
CREATE PUBLIC.
  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
ENDCLASS.

CLASS z_bank_account_jc IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

    DATA: ls_account1_info TYPE zuser_info_jc,
          ls_account2_info TYPE zuser_info_jc.


    DATA(ls_account_1) = VALUE zuser_info_jc(
                                            user_id = 1
                                            first_name = 'John'
                                            last_name = 'Doe'
                                            balance = 0
                                            ).

    DATA(ls_account_2) = VALUE zuser_info_jc(
                                            user_id = 2
                                            first_name = 'Alice'
                                            last_name = 'Smith'
                                            balance = 0
                                            ).

    " Create accounts using the constructor method
    DATA(lr_account1) = lcl_method_helpers=>create_account(
    is_user_info = ls_account1_info
    ).

    DATA(lr_account2) = lcl_method_helpers=>create_account(
    is_user_info = ls_account2_info
    ).


    lcl_method_helpers=>deposit(
                                EXPORTING
                                io_account = lr_account1
                                iv_amount = 100
                                ).

    lcl_method_helpers=>deposit(
                                EXPORTING
                                io_account = lr_account2
                                iv_amount = 200
                                ).

    DATA(lv_withdraw_success) = lcl_method_helpers=>withdraw(
                                                            EXPORTING
                                                                io_account = lr_account1
                                                                iv_amount = 50
                                                            ).


    out->write( |Account 1: { lcl_method_helpers=>get_balance_status( lr_account1 ) }| ).
    out->write( |\n| ).

    out->write( |Account 2: { lcl_method_helpers=>get_balance_status( lr_account2 ) }| ).
    out->write( |\n| ).

    out->write( |Total accounts: { lcl_method_helpers=>get_total_accounts( ) }| ).
    out->write( |\n| ).

    out->write( |Total balance: { lcl_method_helpers=>get_total_balance( ) DECIMALS = 2 }| ).
    out->write( |\n| ).

    out->write( |Withdrawal successful: { COND #( WHEN lv_withdraw_success = abap_true THEN 'Yes' ELSE 'No' ) }| ).
  ENDMETHOD.
ENDCLASS.

