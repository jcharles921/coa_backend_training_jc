CLASS z_discount_legibility DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .


  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .
    DATA: purchase            TYPE f,discount_percentage TYPE f,
          final_amount        TYPE f.



  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS z_discount_legibility IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    "purchase = 350.
    purchase = 600.
    "purchase = 100.
    IF purchase >= 500 .
      discount_percentage = 10.
    ELSEIF purchase >= 200 AND purchase < 500.
      discount_percentage = 5.
    ELSE.
      discount_percentage = 0.
    ENDIF.
* Applied percentage
   final_amount = purchase - ( purchase * discount_percentage / 100 ).
   out->write( |Purchase Amount: { purchase }| ).
    out->write( |Discount Percentage: { discount_percentage }| ).
    out->write( |Final Amount: { final_amount }| ).

  ENDMETHOD.

ENDCLASS.
