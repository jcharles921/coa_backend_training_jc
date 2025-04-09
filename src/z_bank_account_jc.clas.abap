CLASS z_bank_account_jc DEFINITION
PUBLIC
FINAL
CREATE PUBLIC.
  PUBLIC SECTION.
    METHODS:
      constructor IMPORTING is_user_info TYPE zuser_info_jc,

      deposit IMPORTING iv_amount TYPE decfloat34,

      withdraw IMPORTING iv_amount         TYPE decfloat34,


      get_balance_status RETURNING VALUE(rv_status) TYPE string.

    CLASS-METHODS:
      get_total_accounts RETURNING VALUE(rv_total) TYPE i,

      get_total_balance RETURNING VALUE(rv_total) TYPE decfloat34.

  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA: user_id    TYPE i,
          first_name TYPE string,
          last_name  TYPE string,
          balance    TYPE decfloat34.
    CLASS-DATA:
      sv_total_accounts TYPE i,
      sv_total_balance  TYPE decfloat34.

    CLASS-METHODS validate_amount IMPORTING iv_amount       TYPE decfloat34
                                  RETURNING VALUE(rv_valid) TYPE abap_bool.
ENDCLASS.

CLASS z_bank_account_jc IMPLEMENTATION.
  METHOD constructor.
    user_id = is_user_info-user_id.
    first_name = is_user_info-first_name.
    last_name = is_user_info-last_name.
    balance = 0.
    sv_total_accounts = sv_total_accounts + 1.
  ENDMETHOD.

  METHOD deposit.
    IF validate_amount( iv_amount ) = abap_true.
      balance = balance + iv_amount.
      sv_total_balance = sv_total_balance + iv_amount.
    ENDIF.
  ENDMETHOD.

  METHOD withdraw.
    IF validate_amount( iv_amount ) = abap_false.
      RAISE EXCEPTION TYPE cx_sy_arithmetic_overflow
        EXPORTING
          textid = 'Z_BANK_ACCOUNT_JC'.
    ENDIF.

    IF balance < iv_amount.
      RAISE EXCEPTION TYPE cx_sy_arithmetic_overflow
        EXPORTING
          textid = 'Z_BANK_ACCOUNT_JC'.
    ENDIF.

    balance = balance - iv_amount.
    sv_total_balance = sv_total_balance - iv_amount.
  ENDMETHOD.

  METHOD get_total_accounts.
    rv_total = sv_total_accounts.
  ENDMETHOD.

  METHOD get_total_balance.
    rv_total = sv_total_balance.
  ENDMETHOD.

  METHOD validate_amount.
    rv_valid = COND #( WHEN iv_amount > 0 THEN abap_true ELSE abap_false ).
  ENDMETHOD.

  METHOD get_balance_status.
    rv_status = |Your balance is: { balance DECIMALS = 2 } $|.
  ENDMETHOD.
ENDCLASS.

