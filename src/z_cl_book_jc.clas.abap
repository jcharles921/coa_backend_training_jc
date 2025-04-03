CLASS z_cl_book_jc DEFINITION
  INHERITING FROM z_cl_media_jc
  PUBLIC
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS constructor
      IMPORTING
        iv_title TYPE string
        iv_author TYPE string
        iv_year TYPE i
        iv_pages TYPE i.

    METHODS get_title REDEFINITION.

    METHODS get_pages
      RETURNING
        VALUE(rv_pages) TYPE i.

    METHODS get_book_info
      RETURNING
        VALUE(rv_info) TYPE string.

  PROTECTED SECTION.

  PRIVATE SECTION.
    DATA: mv_pages TYPE i.
ENDCLASS.

CLASS z_cl_book_jc IMPLEMENTATION.
  METHOD constructor.
    super->constructor(
      iv_title = iv_title
      iv_author = iv_author
      iv_year = iv_year
    ).
    mv_pages = iv_pages.
  ENDMETHOD.

  METHOD get_title.
    rv_title = |Book: { mv_title }|.
  ENDMETHOD.

  METHOD get_pages.
    rv_pages = mv_pages.
  ENDMETHOD.

  METHOD get_book_info.
    rv_info = |Title: { mv_title }, Author: { mv_author }, Pages: { mv_pages }|.
  ENDMETHOD.
ENDCLASS.
