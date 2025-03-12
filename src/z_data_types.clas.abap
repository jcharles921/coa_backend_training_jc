CLASS z_data_types DEFINITION
  PUBLIC

  FINAL
  CREATE PUBLIC .
  PUBLIC SECTION.
* Data Objects with Built-in Types
**********************************************************************
*    DATA variable TYPE i.
*   DATA variable TYPE d.
*    DATA variable TYPE c LENGTH 10.
*    DATA variable TYPE n LENGTH 10.
    DATA variable TYPE p LENGTH 8 DECIMALS 2.
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    TYPES my_type TYPE p LENGTH 3 DECIMALS 2.
    DATA my_variable TYPE my_type.
    " Place cursor on variable and press F2 or F3
    DATA airport TYPE /dmo/airport_id VALUE 'FRA'.
*    TYPES my_type TYPE i .
*    TYPES my_type TYPE string.
*    TYPES my_type TYPE n length 10.


* Example 3: Constants
**********************************************************************

    CONSTANTS c_text   TYPE string VALUE `Hello World`.
    CONSTANTS c_number TYPE i      VALUE 12345.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS z_data_types IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    out->write(  'Result with Initial Value)' ).
    out->write(   variable ).
    out->write(  '---------' ).
    variable = `6859.4` .

    out->write(  'Result with 6859.4' ).
    out->write(   variable ).
    out->write(  '---------' ).
    out->write(  `my_variable (TYPE MY_TYPE)` ).
    out->write(   my_variable ) .
    out->write(  `airport (TYPE /DMO/AIRPORT_ID )` ).
    out->write(   airport ).

    out->write(  `c_text (TYPE STRING)` ).
    out->write(   c_text ).
    out->write(  '---------' ).

    out->write(  `c_number (TYPE I )` ).
    out->write(   c_number ).
    out->write(  `---------` ).
    out->write(  '12345         Text Literal   (Type C)      ' ).
    out->write(  `12345         String Literal (Type STRING)      ` ).
    out->write( | { 12345 } Number Literal (Type I) |                ).    "

  ENDMETHOD.
ENDCLASS.
