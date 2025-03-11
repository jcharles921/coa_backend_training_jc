CLASS z_hello_world_2 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS z_hello_world_2 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    out->write( 'Hello world from charles' ).
  ENDMETHOD.
ENDCLASS.
