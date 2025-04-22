CLASS z_seeders_jc DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS z_seeders_jc IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DELETE FROM zequipment_jc.
    DELETE FROM zmaintenance_jc.

    DATA: lt_equipment TYPE TABLE OF zequipment_jc,
          lt_tasks     TYPE TABLE OF zmaintenance_jc.

    DATA: lv_timestamp TYPE timestampl.
    GET TIME STAMP FIELD lv_timestamp.

    lt_equipment = VALUE #(
    ( equipment_id = '001' equipment_name = 'Conveyor Belt 1' location = 'Line A' equipment_type = 'MECHANICAL'
      created_by = sy-uname created_at = lv_timestamp last_changed_by = sy-uname last_changed_at = lv_timestamp local_last_changed = lv_timestamp )
    ( equipment_id = '002' equipment_name = 'Packing Robot' location = 'Line B' equipment_type = 'ELECTRICAL'
      created_by = sy-uname created_at = lv_timestamp last_changed_by = sy-uname last_changed_at = lv_timestamp local_last_changed = lv_timestamp )
    ( equipment_id = '003' equipment_name = 'Air Conditioner' location = 'Office 1' equipment_type = 'ELECTRICAL'
      created_by = sy-uname created_at = lv_timestamp last_changed_by = sy-uname last_changed_at = lv_timestamp local_last_changed = lv_timestamp )
    ( equipment_id = '004' equipment_name = 'Printer' location = 'Office 2' equipment_type = 'ELECTRICAL'
      created_by = sy-uname created_at = lv_timestamp last_changed_by = sy-uname last_changed_at = lv_timestamp local_last_changed = lv_timestamp )
    ( equipment_id = '005' equipment_name = 'Generator' location = 'Basement' equipment_type = 'MECHANICAL'
      created_by = sy-uname created_at = lv_timestamp last_changed_by = sy-uname last_changed_at = lv_timestamp local_last_changed = lv_timestamp )
    ).

    INSERT zequipment_jc FROM TABLE @lt_equipment.

    lt_tasks = VALUE #(
    ( task_id = '001' equipment_id = '001' task_description = 'Lubricate moving parts' status = 'OPEN' due_date = '20250420'
      created_by = sy-uname created_at = lv_timestamp last_changed_by = sy-uname last_changed_at = lv_timestamp local_last_changed = lv_timestamp )
    ( task_id = '002' equipment_id = '001' task_description = 'Replace worn-out belt' status = 'IN PROGRES' due_date = '20250425'
      created_by = sy-uname created_at = lv_timestamp last_changed_by = sy-uname last_changed_at = lv_timestamp local_last_changed = lv_timestamp )
    ( task_id = '003' equipment_id = '001' task_description = 'Clean the conveyor' status = 'OPEN' due_date = '20250430'
      created_by = sy-uname created_at = lv_timestamp last_changed_by = sy-uname last_changed_at = lv_timestamp local_last_changed = lv_timestamp )

    ( task_id = '004' equipment_id = '002' task_description = 'Update firmware' status = 'OPEN' due_date = '20250422'
      created_by = sy-uname created_at = lv_timestamp last_changed_by = sy-uname last_changed_at = lv_timestamp local_last_changed = lv_timestamp )
    ( task_id = '005' equipment_id = '002' task_description = 'Replace faulty sensor' status = 'DONE' due_date = '20250410'
      created_by = sy-uname created_at = lv_timestamp last_changed_by = sy-uname last_changed_at = lv_timestamp local_last_changed = lv_timestamp )
    ( task_id = '006' equipment_id = '002' task_description = 'Check for loose screws' status = 'IN PROGRES' due_date = '20250415'
      created_by = sy-uname created_at = lv_timestamp last_changed_by = sy-uname last_changed_at = lv_timestamp local_last_changed = lv_timestamp )

    ( task_id = '007' equipment_id = '003' task_description = 'Clean air filters' status = 'OPEN' due_date = '20250501'
      created_by = sy-uname created_at = lv_timestamp last_changed_by = sy-uname last_changed_at = lv_timestamp local_last_changed = lv_timestamp )
    ( task_id = '008' equipment_id = '003' task_description = 'Check refrigerant levels' status = 'OPEN' due_date = '20250510'
      created_by = sy-uname created_at = lv_timestamp last_changed_by = sy-uname last_changed_at = lv_timestamp local_last_changed = lv_timestamp )

    ( task_id = '009' equipment_id = '004' task_description = 'Replace ink cartridge' status = 'OPEN' due_date = '20250505'
      created_by = sy-uname created_at = lv_timestamp last_changed_by = sy-uname last_changed_at = lv_timestamp local_last_changed = lv_timestamp )
    ( task_id = '010' equipment_id = '004' task_description = 'Clean printer head' status = 'IN PROGRES' due_date = '20250512'
      created_by = sy-uname created_at = lv_timestamp last_changed_by = sy-uname last_changed_at = lv_timestamp local_last_changed = lv_timestamp )

    ( task_id = '011' equipment_id = '005' task_description = 'Check oil levels' status = 'OPEN' due_date = '20250515'
      created_by = sy-uname created_at = lv_timestamp last_changed_by = sy-uname last_changed_at = lv_timestamp local_last_changed = lv_timestamp )
    ( task_id = '012' equipment_id = '005' task_description = 'Replace air filter' status = 'OPEN' due_date = '20250520'
      created_by = sy-uname created_at = lv_timestamp last_changed_by = sy-uname last_changed_at = lv_timestamp local_last_changed = lv_timestamp )
    ( task_id = '013' equipment_id = '005' task_description = 'Inspect for leaks' status = 'IN PROGRES' due_date = '20250525'
      created_by = sy-uname created_at = lv_timestamp last_changed_by = sy-uname last_changed_at = lv_timestamp local_last_changed = lv_timestamp )
    ).

    INSERT zmaintenance_jc FROM TABLE @lt_tasks.

    COMMIT WORK.

    out->write( 'Equipment and maintenance data with administration fields has been created' ).

  ENDMETHOD.

ENDCLASS.

