

CLASS z_cl_library_system_jc DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS z_cl_library_system_jc IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    " Create book object
    DATA(lo_book) = NEW z_cl_book_jc(
      iv_title  = 'Booking'
      iv_author = 'Book maker'
      iv_year   = 1925
      iv_pages  = 218
    ).

    " Create audiobook object
    DATA(lo_audiobook) = NEW z_cl_audiobook_jc(
      iv_title    = 'Mockingbird'
      iv_author   = 'Harper Lee'
      iv_year     = 1960
      iv_duration = 720
    ).


    DATA: lt_media TYPE TABLE OF REF TO z_cl_media_jc.

    APPEND lo_book TO lt_media.
    APPEND lo_audiobook TO lt_media.

    " Display titles
    out->write( |Library Media Items:| ).
    out->write( |------------------| ).
    LOOP AT lt_media INTO DATA(lo_media_ref).
      out->write( lo_media_ref->get_title( ) ).
    ENDLOOP.

    " Display detailed information
    out->write( |------------------| ).
    out->write( |Detailed Information:| ).

    LOOP AT lt_media INTO lo_media_ref.

      " When it is a book
      IF lo_media_ref IS INSTANCE OF z_cl_book_jc.
        DATA(lo_book_casted) = CAST z_cl_book_jc( lo_media_ref ).
        out->write( lo_book_casted->get_book_info( ) ).

        "When it is a audio book
      ELSEIF lo_media_ref IS INSTANCE OF z_cl_audiobook_jc.
        DATA(lo_audio_casted) = CAST z_cl_audiobook_jc( lo_media_ref ).
        out->write( lo_audio_casted->get_audiobook_info( ) ).
      ELSE.
        out->write( 'Unknown media type' ).
      ENDIF.

    ENDLOOP.

  ENDMETHOD.
ENDCLASS.
