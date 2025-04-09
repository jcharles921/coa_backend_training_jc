CLASS z_cl_media_jc DEFINITION
  PUBLIC
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS constructor
      IMPORTING
        iv_title TYPE string
        iv_author TYPE string
        iv_year TYPE i.

    METHODS get_title
      RETURNING
        VALUE(rv_title) TYPE string.

    METHODS get_author
      RETURNING
        VALUE(rv_author) TYPE string.

    METHODS get_year
      RETURNING
        VALUE(rv_year) TYPE i.

  PROTECTED SECTION.
    DATA: mv_title TYPE string,
          mv_author TYPE string,
          mv_year TYPE i.

  PRIVATE SECTION.
ENDCLASS.

CLASS z_cl_media_jc IMPLEMENTATION.
  METHOD constructor.
    mv_title = iv_title.
    mv_author = iv_author.
    mv_year = iv_year.
  ENDMETHOD.

  METHOD get_title.
    rv_title = mv_title.
  ENDMETHOD.

  METHOD get_author.
    rv_author = mv_author.
  ENDMETHOD.

  METHOD get_year.
    rv_year = mv_year.
  ENDMETHOD.
ENDCLASS.

