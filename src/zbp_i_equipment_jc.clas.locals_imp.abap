CLASS lhc_Equipment DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Equipment RESULT result.

ENDCLASS.

CLASS lhc_Equipment IMPLEMENTATION.

METHOD get_instance_authorizations.
  " Check requested authorizations for all instances
  LOOP AT keys ASSIGNING FIELD-SYMBOL(<key>).
    " Set default authorization to allowed
    IF requested_authorizations-%update = if_abap_behv=>mk-on.
      APPEND VALUE #( %tky    = <key>-%tky
                      %update = if_abap_behv=>auth-allowed ) TO result.
    ENDIF.

    IF requested_authorizations-%delete = if_abap_behv=>mk-on.
      APPEND VALUE #( %tky    = <key>-%tky
                      %delete = if_abap_behv=>auth-allowed ) TO result.
    ENDIF.
  ENDLOOP.
ENDMETHOD.

ENDCLASS.
