CLASS z_string_manipulation_jc DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES tt_numbers_array TYPE TABLE OF i.
    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS z_string_manipulation_jc IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.
    DATA(lo_helper) = NEW lcl_method_helpers(  ).



    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    "Question 1
    DATA(lv_user_name_age) = lo_helper->get_age_and_name(
                                                          EXPORTING
                                                             iv_personal_info = VALUE zpersonnal_info_jc(
                                                                                                 first_name    = 'Alice'
                                                                                                 last_name     = 'Forger'
                                                                                                 date_of_birth = 1997 )
                                                         ).
    out->write( |Question 1 \r{ lv_user_name_age }| ).
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    "Question 2

    lo_helper->get_all_even_numbers( EXPORTING
                                       it_number = 20
                                     IMPORTING
                                       rt_numbers_array = DATA(lt_array)
                                        ).
    out->write( |Question 2  | ).
    out->write( lt_array ).
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    "Question 3
    out->write( |Question 3  | ).
    TRY.
        DATA(lv_sum_digits) = lo_helper->get_sum_of_digits( '1234567111' ).
        out->write( |Sum of digits = { lv_sum_digits }| ).
      CATCH cx_sy_conversion_error INTO DATA(lcx_conversion_error).
        out->write( | invalid input ! { lcx_conversion_error->get_text( ) } | ) .
    ENDTRY.
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    "Question 4
    DATA lt_list_numbers TYPE tt_numbers_array.

    lt_list_numbers = VALUE #( ( 12 ) ( 23 ) ( 45 ) ( 22 ) ).

    DATA(lv_biggest_number) = lo_helper->get_biggest_number( EXPORTING it_numbers = lt_list_numbers ).

    out->write( |Question 4  | ).
    out->write( lv_biggest_number ) .


    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " Question 5: Combine Two Strings
    DATA(lv_combined_string) = lo_helper->combine_two_strings(
      EXPORTING
        iv_first_string = 'aaaaaaa'
        iv_second_string = 'bbbbbbb'
    ).
    out->write( |Question 5  | ).
    out->write( lv_combined_string ).
  ENDMETHOD.
ENDCLASS.
