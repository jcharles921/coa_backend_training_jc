*"* Use this source file for the definition and implementation of
*"* local helper classes, interface definitions, and type
*"* declarations


CLASS lcl_method_helpers DEFINITION FINAL CREATE PUBLIC.
  PUBLIC SECTION.
    TYPES tt_numbers_array TYPE TABLE OF i.
*    TYPES: BEGIN OF ls_personal_info ,
*             iv_first_name    TYPE string,
*             iv_last_name     TYPE string,
*             iv_year_of_birth TYPE i,
*           END OF ls_personal_info.

    METHODS get_age_and_name
      IMPORTING iv_personal_info    TYPE zpersonnal_info_jc
      RETURNING VALUE(rv_full_name) TYPE string.

    METHODS get_all_even_numbers
      IMPORTING
        it_number               TYPE i
      EXPORTING
        VALUE(rt_numbers_array) TYPE tt_numbers_array.

    METHODS get_sum_of_digits
      IMPORTING iv_str        TYPE string
      RETURNING VALUE(rv_sum) TYPE i .

    METHODS get_biggest_number
      IMPORTING it_numbers               TYPE  tt_numbers_array
      RETURNING VALUE(rv_biggest_number) TYPE  i
      RAISING   cx_sy_itab_line_not_found.

    METHODS combine_two_strings
      IMPORTING iv_first_string           TYPE string
                iv_second_string          TYPE string
      RETURNING VALUE(rv_combined_string) TYPE string.


ENDCLASS.

CLASS lcl_method_helpers IMPLEMENTATION.
  " Question 1
  METHOD get_age_and_name.
    DATA lv_full_name TYPE string.
    lv_full_name = |{ iv_personal_info-first_name } { iv_personal_info-last_name }|.
    DATA(lv_current_time) = cl_abap_context_info=>get_system_date( ).
    DATA(lv_current_year) = lv_current_time+0(4).
    rv_full_name = |{ lv_full_name }, { lv_current_year - iv_personal_info-date_of_birth } years old |.
  ENDMETHOD.
  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  " Question 2
  METHOD get_all_even_numbers.
    DATA lt_numbers TYPE tt_numbers_array.
    DO it_number TIMES.
      DATA(lv_index) = sy-index - 1.
      IF lv_index MOD 2 = 0 AND lv_index <> 0.
        APPEND lv_index TO lt_numbers.
      ENDIF.
    ENDDO.
    rt_numbers_array = lt_numbers.
  ENDMETHOD.
  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  " Question 3: Sum of Digits
  METHOD get_sum_of_digits.

    DATA: lv_index TYPE i,
          lv_char  TYPE c LENGTH 1,
          lv_digit TYPE i.

    " Initialize sum"
    rv_sum = 0.
    " Loop through each character in the string"
    DO strlen( iv_str ) TIMES.
      lv_char = iv_str+lv_index(1). " Extract one character at a time"

      " Try converting the character to an integer
      lv_digit = lv_char.
      " Add digit to the sum"
      rv_sum = rv_sum + lv_digit.
      " Move to the next character"
      lv_index = lv_index + 1.
    ENDDO.

  ENDMETHOD.
  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  " Question 4
  METHOD get_biggest_number.
    DATA: lv_current_biggest TYPE i .

    IF lines( it_numbers ) > 0 . " check is internal table is empty

      lv_current_biggest = it_numbers[ 1 ].
      LOOP AT it_numbers INTO DATA(current_number) FROM 2.
        IF   current_number > lv_current_biggest .
          lv_current_biggest = current_number  .
        ENDIF.
      ENDLOOP.

    ENDIF.
    rv_biggest_number = lv_current_biggest .
  ENDMETHOD.
  METHOD combine_two_strings.
    DATA: lv_combined_string TYPE string,
          lv_length_first    TYPE i,
          lv_length_second   TYPE i,
          lv_index           TYPE i.

    " lengths of both importing strings
    lv_length_first = strlen( iv_first_string ).
    lv_length_second = strlen( iv_second_string ).

    lv_index = 0.

    " Loop through the characters of both strings
    WHILE lv_index < lv_length_first OR lv_index < lv_length_second.
      " Append character from the first string if within bounds
      IF lv_index < lv_length_first.
        lv_combined_string = lv_combined_string && iv_first_string+lv_index(1).
      ENDIF.

      IF lv_index < lv_length_second.
        lv_combined_string = lv_combined_string && iv_second_string+lv_index(1).
      ENDIF.
      " Move to the next character
      lv_index = lv_index + 1.
    ENDWHILE.
    " Return the combined string
    rv_combined_string = lv_combined_string.
  ENDMETHOD.

ENDCLASS.
