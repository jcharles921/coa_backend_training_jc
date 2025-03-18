CLASS z_discount_legibility DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .


  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS z_discount_legibility IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

    DATA: lv_purchase            TYPE decfloat34,lv_discount_percentage  TYPE p LENGTH 8 DECIMALS 2,
          lv_final_amount        TYPE p LENGTH 8 DECIMALS 2.
    "purchase = 350.
    lv_purchase = '600.55'.
    "purchase = 100.
    IF lv_purchase >= 500 .
      lv_discount_percentage = 10.
    ELSEIF lv_purchase >= 200 AND lv_purchase < 500.
      lv_discount_percentage = 5.
    ELSE.
      lv_discount_percentage = 0.
    ENDIF.

    lv_final_amount = lv_purchase - ( lv_purchase * lv_discount_percentage / 100 ).
    out->write( |Purchase Amount: { lv_purchase }| ).
    out->write( |Discount Percentage: { lv_discount_percentage }| ).
    out->write( |Final Amount: { lv_final_amount }| ).

  ENDMETHOD.

ENDCLASS.
