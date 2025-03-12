CLASS z_string_transformation DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
*TYPES t_result TYPE p LENGTH 8 DECIMALS 2.
TYPES t_result TYPE i.

    DATA result TYPE t_result.
    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS z_string_transformation IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
*  result = sqrt( 9 ).
    result = ipow( base = 1 exp = 3 ).

    out->write( result ).
  ENDMETHOD.
ENDCLASS.
