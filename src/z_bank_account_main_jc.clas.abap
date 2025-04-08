CLASS z_bank_account_main_jc DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS z_bank_account_main_jc IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    DATA: ls_account1_info TYPE zuser_info_jc,
          ls_account2_info TYPE zuser_info_jc.

    DATA(ls_account_1) = NEW z_bank_account_jc( is_user_info = VALUE #( user_id = 1 first_name = 'John' last_name = 'Doe' ) ).

    DATA(ls_account_2) = NEW z_bank_account_jc( is_user_info = VALUE #( user_id = 2 first_name = 'Alice' last_name = 'Smith' ) ).

    ls_account_1->deposit( iv_amount = 100 ).
    ls_account_2->deposit( iv_amount = 200 ).

    TRY.
        ls_account_1->withdraw( iv_amount = 70 ).
        out->write( |Withdrawal successful: Yes| ).

      CATCH cx_root INTO DATA(lx_overflow).
        out->write( |Withdrawal failed: { lx_overflow->get_text( ) }| ).
    ENDTRY.
    ls_account_1->deposit( iv_amount = 300 ).

    out->write( |Account 1: { ls_account_1->get_balance_status( ) }| ).
    out->write( |\n| ).

    out->write( |Account 2: { ls_account_2->get_balance_status( ) }| ).
    out->write( |\n| ).

    out->write( |Total accounts: { z_bank_account_jc=>get_total_accounts( ) }| ).
    out->write( |\n| ).

    out->write( |Total balance: { z_bank_account_jc=>get_total_balance( ) DECIMALS = 2 }| ).
    out->write( |\n| ).


  ENDMETHOD.
ENDCLASS.
