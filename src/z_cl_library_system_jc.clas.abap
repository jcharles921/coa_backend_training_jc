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

    DATA(lo_book) = NEW z_cl_book_jc(
      iv_title = 'Booking'
      iv_author = 'Book maker'
      iv_year = 1925
      iv_pages = 218
    ).

    " Create audiobook object
    DATA(lo_audiobook) = NEW z_cl_audiobook_jc(
      iv_title = 'Mockingbird'
      iv_author = 'Harper Lee'
      iv_year = 1960
      iv_duration = 720
    ).
*    DATA lt_media_info TYPE z_tt_media_item_jc .

  DATA: lt_media_info TYPE Z_TT_MEDIA_ITEM_JC,
          ls_media      TYPE zmedia_item_jc.


    ls_media-title = lo_book->get_title( ).
    ls_media-info  = lo_book->get_book_info( ).
    APPEND ls_media TO lt_media_info.


    ls_media-title = lo_audiobook->get_title( ).
    ls_media-info  = lo_audiobook->get_audiobook_info( ).
    APPEND ls_media TO lt_media_info.


    out->write( |Library Media Items:| ).
    out->write( |------------------| ).

    LOOP AT lt_media_info INTO ls_media.
      out->write( ls_media-title ).
    ENDLOOP.


    out->write( |------------------| ).
    out->write( |Detailed Information:| ).

    LOOP AT lt_media_info INTO ls_media.
      out->write( ls_media-info ).
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.
