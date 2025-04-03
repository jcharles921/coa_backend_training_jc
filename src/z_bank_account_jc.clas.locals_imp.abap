*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
CLASS lcl_method_helpers DEFINITION FINAL CREATE PUBLIC.
  PUBLIC SECTION.

    CLASS-DATA mv_total_accounts TYPE i.
    CLASS-DATA mv_total_balance TYPE decfloat34.

    " Constructor for the account structure
    CLASS-METHODS:
      create_account
        IMPORTING
          is_user_info      TYPE zuser_info_jc
        RETURNING
          VALUE(ro_account) TYPE REF TO zuser_info_jc,

      deposit
        IMPORTING
          io_account TYPE REF TO zuser_info_jc
          iv_amount  TYPE decfloat34,

      withdraw
        IMPORTING
          io_account        TYPE REF TO zuser_info_jc
          iv_amount         TYPE decfloat34
        RETURNING
          VALUE(rv_success) TYPE abap_bool,

      get_balance_status
        IMPORTING
          io_account       TYPE REF TO zuser_info_jc
        RETURNING
          VALUE(rv_status) TYPE string,

      get_total_accounts
        RETURNING
          VALUE(rv_total) TYPE i,

      get_total_balance
        RETURNING
          VALUE(rv_total) TYPE decfloat34.

  PRIVATE SECTION.
    CLASS-METHODS:
      validate_amount
        IMPORTING
          iv_amount       TYPE decfloat34
        RETURNING
          VALUE(rv_valid) TYPE abap_bool.
ENDCLASS.

CLASS lcl_method_helpers IMPLEMENTATION.
  METHOD create_account.

    CREATE DATA ro_account.

    ro_account->user_id = is_user_info-user_id.
    ro_account->first_name = is_user_info-first_name.
    ro_account->last_name = is_user_info-last_name.
    ro_account->balance = is_user_info-balance.

    " Increment total accounts counter
    mv_total_accounts = mv_total_accounts + 1.

    " Add initial balance to total balance
    mv_total_balance = mv_total_balance + is_user_info-balance.
  ENDMETHOD.

  METHOD deposit.
    IF validate_amount( iv_amount ) = abap_true.
      io_account->balance = io_account->balance + iv_amount.
      mv_total_balance = mv_total_balance + iv_amount.
    ENDIF.
  ENDMETHOD.

  METHOD withdraw.
    IF validate_amount( iv_amount ) = abap_true AND
    io_account->balance >= iv_amount.
      io_account->balance = io_account->balance - iv_amount.
      mv_total_balance = mv_total_balance - iv_amount.
      rv_success = abap_true.
    ELSE.
      rv_success = abap_false.
    ENDIF.
  ENDMETHOD.

  METHOD get_balance_status.
    rv_status = |Your balance is: { io_account->balance DECIMALS = 2 } $|.
  ENDMETHOD.

  METHOD get_total_accounts.
    rv_total = mv_total_accounts.
  ENDMETHOD.

  METHOD get_total_balance.
    rv_total = mv_total_balance.
  ENDMETHOD.

  METHOD validate_amount.
    rv_valid = COND #( WHEN iv_amount > 0 THEN abap_true ELSE abap_false ).
  ENDMETHOD.
ENDCLASS.
