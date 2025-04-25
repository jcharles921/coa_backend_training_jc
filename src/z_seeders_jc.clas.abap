CLASS z_seeders_jc DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS z_seeders_jc IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.
    " Clear existing data
    DELETE FROM zequipment_jc.
    DELETE FROM zmaintenance_jc.

    " Declare variables
    DATA: lt_equipment      TYPE TABLE OF zequipment_jc,
          lt_tasks          TYPE TABLE OF zmaintenance_jc,
          lv_timestamp      TYPE timestampl,
          lt_equipment_ids  TYPE TABLE OF string.

    GET TIME STAMP FIELD lv_timestamp.

    " Generate equipment data with UUIDs
    DATA(lv_uuid1) = cl_system_uuid=>create_uuid_x16_static( ).
    APPEND lv_uuid1 TO lt_equipment_ids.
    APPEND VALUE #(
      equipment_id      = lv_uuid1
      equipment_name    = 'Conveyor Belt 1'
      location          = 'Line A'
      equipment_type    = 'MECHANICAL'
      created_by        = sy-uname
      created_at        = lv_timestamp
      last_changed_by   = sy-uname
      last_changed_at   = lv_timestamp
      local_last_changed = lv_timestamp
    ) TO lt_equipment.

    DATA(lv_uuid2) = cl_system_uuid=>create_uuid_x16_static( ).
    APPEND lv_uuid2 TO lt_equipment_ids.
    APPEND VALUE #(
      equipment_id      = lv_uuid2
      equipment_name    = 'Packing Robot'
      location          = 'Line B'
      equipment_type    = 'ELECTONICS'
      created_by        = sy-uname
      created_at        = lv_timestamp
      last_changed_by   = sy-uname
      last_changed_at   = lv_timestamp
      local_last_changed = lv_timestamp
    ) TO lt_equipment.

    DATA(lv_uuid3) = cl_system_uuid=>create_uuid_x16_static( ).
    APPEND lv_uuid3 TO lt_equipment_ids.
    APPEND VALUE #(
      equipment_id      = lv_uuid3
      equipment_name    = 'Air Conditioner'
      location          = 'Office 1'
      equipment_type    = 'ELECTONICS'
      created_by        = sy-uname
      created_at        = lv_timestamp
      last_changed_by   = sy-uname
      last_changed_at   = lv_timestamp
      local_last_changed = lv_timestamp
    ) TO lt_equipment.

    DATA(lv_uuid4) = cl_system_uuid=>create_uuid_x16_static( ).
    APPEND lv_uuid4 TO lt_equipment_ids.
    APPEND VALUE #(
      equipment_id      = lv_uuid4
      equipment_name    = 'Printer'
      location          = 'Office 2'
      equipment_type    = 'ELECTONICS'
      created_by        = sy-uname
      created_at        = lv_timestamp
      last_changed_by   = sy-uname
      last_changed_at   = lv_timestamp
      local_last_changed = lv_timestamp
    ) TO lt_equipment.

    DATA(lv_uuid5) = cl_system_uuid=>create_uuid_x16_static( ).
    APPEND lv_uuid5 TO lt_equipment_ids.
    APPEND VALUE #(
      equipment_id      = lv_uuid5
      equipment_name    = 'Generator'
      location          = 'Basement'
      equipment_type    = 'MECHANICAL'
      created_by        = sy-uname
      created_at        = lv_timestamp
      last_changed_by   = sy-uname
      last_changed_at   = lv_timestamp
      local_last_changed = lv_timestamp
    ) TO lt_equipment.

    INSERT zequipment_jc FROM TABLE @lt_equipment.

    " Generate maintenance tasks with UUIDs
    " Tasks for equipment 1 - Conveyor Belt 1
    DATA(lv_task_uuid1) = cl_system_uuid=>create_uuid_x16_static( ).
    APPEND VALUE #(
      task_id           = lv_task_uuid1
      equipment_id      = lv_uuid1
      task_description  = 'Lubricate moving parts'
      status            = 'OPEN'
      due_date          = '20250420'
      created_by        = sy-uname
      created_at        = lv_timestamp
      last_changed_by   = sy-uname
      last_changed_at   = lv_timestamp
      local_last_changed = lv_timestamp
    ) TO lt_tasks.

    DATA(lv_task_uuid2) = cl_system_uuid=>create_uuid_x16_static( ).
    APPEND VALUE #(
      task_id           = lv_task_uuid2
      equipment_id      = lv_uuid1
      task_description  = 'Replace worn-out belt'
      status            = 'IN PROGRES'
      due_date          = '20250425'
      created_by        = sy-uname
      created_at        = lv_timestamp
      last_changed_by   = sy-uname
      last_changed_at   = lv_timestamp
      local_last_changed = lv_timestamp
    ) TO lt_tasks.

    DATA(lv_task_uuid3) = cl_system_uuid=>create_uuid_x16_static( ).
    APPEND VALUE #(
      task_id           = lv_task_uuid3
      equipment_id      = lv_uuid1
      task_description  = 'Clean the conveyor'
      status            = 'OPEN'
      due_date          = '20250430'
      created_by        = sy-uname
      created_at        = lv_timestamp
      last_changed_by   = sy-uname
      last_changed_at   = lv_timestamp
      local_last_changed = lv_timestamp
    ) TO lt_tasks.

    " Tasks for equipment 2 - Packing Robot
    DATA(lv_task_uuid4) = cl_system_uuid=>create_uuid_x16_static( ).
    APPEND VALUE #(
      task_id           = lv_task_uuid4
      equipment_id      = lv_uuid2
      task_description  = 'Update firmware'
      status            = 'OPEN'
      due_date          = '20250422'
      created_by        = sy-uname
      created_at        = lv_timestamp
      last_changed_by   = sy-uname
      last_changed_at   = lv_timestamp
      local_last_changed = lv_timestamp
    ) TO lt_tasks.

    DATA(lv_task_uuid5) = cl_system_uuid=>create_uuid_x16_static( ).
    APPEND VALUE #(
      task_id           = lv_task_uuid5
      equipment_id      = lv_uuid2
      task_description  = 'Replace faulty sensor'
      status            = 'DONE'
      due_date          = '20250410'
      created_by        = sy-uname
      created_at        = lv_timestamp
      last_changed_by   = sy-uname
      last_changed_at   = lv_timestamp
      local_last_changed = lv_timestamp
    ) TO lt_tasks.

    DATA(lv_task_uuid6) = cl_system_uuid=>create_uuid_x16_static( ).
    APPEND VALUE #(
      task_id           = lv_task_uuid6
      equipment_id      = lv_uuid2
      task_description  = 'Check for loose screws'
      status            = 'IN PROGRES'
      due_date          = '20250415'
      created_by        = sy-uname
      created_at        = lv_timestamp
      last_changed_by   = sy-uname
      last_changed_at   = lv_timestamp
      local_last_changed = lv_timestamp
    ) TO lt_tasks.

    " Tasks for equipment 3 - Air Conditioner
    DATA(lv_task_uuid7) = cl_system_uuid=>create_uuid_x16_static( ).
    APPEND VALUE #(
      task_id           = lv_task_uuid7
      equipment_id      = lv_uuid3
      task_description  = 'Clean air filters'
      status            = 'OPEN'
      due_date          = '20250501'
      created_by        = sy-uname
      created_at        = lv_timestamp
      last_changed_by   = sy-uname
      last_changed_at   = lv_timestamp
      local_last_changed = lv_timestamp
    ) TO lt_tasks.

    DATA(lv_task_uuid8) = cl_system_uuid=>create_uuid_x16_static( ).
    APPEND VALUE #(
      task_id           = lv_task_uuid8
      equipment_id      = lv_uuid3
      task_description  = 'Check refrigerant levels'
      status            = 'OPEN'
      due_date          = '20250510'
      created_by        = sy-uname
      created_at        = lv_timestamp
      last_changed_by   = sy-uname
      last_changed_at   = lv_timestamp
      local_last_changed = lv_timestamp
    ) TO lt_tasks.

    " Tasks for equipment 4 - Printer
    DATA(lv_task_uuid9) = cl_system_uuid=>create_uuid_x16_static( ).
    APPEND VALUE #(
      task_id           = lv_task_uuid9
      equipment_id      = lv_uuid4
      task_description  = 'Replace ink cartridge'
      status            = 'OPEN'
      due_date          = '20250505'
      created_by        = sy-uname
      created_at        = lv_timestamp
      last_changed_by   = sy-uname
      last_changed_at   = lv_timestamp
      local_last_changed = lv_timestamp
    ) TO lt_tasks.

    DATA(lv_task_uuid10) = cl_system_uuid=>create_uuid_x16_static( ).
    APPEND VALUE #(
      task_id           = lv_task_uuid10
      equipment_id      = lv_uuid4
      task_description  = 'Clean printer head'
      status            = 'IN PROGRES'
      due_date          = '20250512'
      created_by        = sy-uname
      created_at        = lv_timestamp
      last_changed_by   = sy-uname
      last_changed_at   = lv_timestamp
      local_last_changed = lv_timestamp
    ) TO lt_tasks.

    " Tasks for equipment 5 - Generator
    DATA(lv_task_uuid11) = cl_system_uuid=>create_uuid_x16_static( ).
    APPEND VALUE #(
      task_id           = lv_task_uuid11
      equipment_id      = lv_uuid5
      task_description  = 'Check oil levels'
      status            = 'OPEN'
      due_date          = '20250515'
      created_by        = sy-uname
      created_at        = lv_timestamp
      last_changed_by   = sy-uname
      last_changed_at   = lv_timestamp
      local_last_changed = lv_timestamp
    ) TO lt_tasks.

    DATA(lv_task_uuid12) = cl_system_uuid=>create_uuid_x16_static( ).
    APPEND VALUE #(
      task_id           = lv_task_uuid12
      equipment_id      = lv_uuid5
      task_description  = 'Replace air filter'
      status            = 'OPEN'
      due_date          = '20250520'
      created_by        = sy-uname
      created_at        = lv_timestamp
      last_changed_by   = sy-uname
      last_changed_at   = lv_timestamp
      local_last_changed = lv_timestamp
    ) TO lt_tasks.

    DATA(lv_task_uuid13) = cl_system_uuid=>create_uuid_x16_static( ).
    APPEND VALUE #(
      task_id           = lv_task_uuid13
      equipment_id      = lv_uuid5
      task_description  = 'Inspect for leaks'
      status            = 'IN PROGRES'
      due_date          = '20250525'
      created_by        = sy-uname
      created_at        = lv_timestamp
      last_changed_by   = sy-uname
      last_changed_at   = lv_timestamp
      local_last_changed = lv_timestamp
    ) TO lt_tasks.

    INSERT zmaintenance_jc FROM TABLE @lt_tasks.
    COMMIT WORK.

    out->write( 'Equipment and maintenance data with UUID-based IDs has been created' ).
  ENDMETHOD.

ENDCLASS.
