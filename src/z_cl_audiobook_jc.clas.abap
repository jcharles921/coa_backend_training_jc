CLASS z_cl_audiobook_jc DEFINITION
  INHERITING FROM z_cl_media_jc
  PUBLIC
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS constructor
      IMPORTING
        iv_title TYPE string
        iv_author TYPE string
        iv_year TYPE i
        iv_duration TYPE i.

    METHODS get_title REDEFINITION.

    METHODS get_duration
      RETURNING
        VALUE(rv_duration) TYPE i.

    METHODS get_audiobook_info
      RETURNING
        VALUE(rv_info) TYPE string.

  PROTECTED SECTION.

  PRIVATE SECTION.
    DATA: mv_duration TYPE i.
ENDCLASS.

CLASS z_cl_audiobook_jc IMPLEMENTATION.
  METHOD constructor.
    super->constructor(
      iv_title = iv_title
      iv_author = iv_author
      iv_year = iv_year
    ).
    mv_duration = iv_duration.
  ENDMETHOD.

  METHOD get_title.
    rv_title = |AudioBook: { mv_title }|.
  ENDMETHOD.

  METHOD get_duration.
    rv_duration = mv_duration.
  ENDMETHOD.

  METHOD get_audiobook_info.
    rv_info = |Title: { mv_title }, Author: { mv_author }, Duration: { mv_duration } minutes|.
  ENDMETHOD.
ENDCLASS.
