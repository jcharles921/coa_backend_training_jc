CLASS lhc_maintenance DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.
    METHODS validateDueDate FOR VALIDATE ON SAVE
      IMPORTING keys FOR Maintenance~validateDueDate.

    METHODS validateMaintenanceMandatory FOR VALIDATE ON SAVE
      IMPORTING keys FOR Maintenance~validateMaintenanceMandatory.

    METHODS setDefaultDueDate FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Maintenance~setDefaultDueDate.

    METHODS setDefaultStatus FOR DETERMINE ON SAVE
      IMPORTING keys FOR Maintenance~setDefaultStatus.

    METHODS setEquipmentType FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Equipment~setEquipmentType.

    METHODS startProgress FOR MODIFY
      IMPORTING keys FOR ACTION Maintenance~startProgress RESULT result.

    METHODS closeTask FOR MODIFY
      IMPORTING keys FOR ACTION Maintenance~closeTask RESULT result.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR Maintenance RESULT result.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Maintenance RESULT result.

ENDCLASS.

CLASS lhc_maintenance IMPLEMENTATION.
  METHOD validateDueDate.
    " Read maintenance task data for the given keys
    READ ENTITIES OF zi_equipment_jc IN LOCAL MODE
      ENTITY Maintenance
        FIELDS ( DueDate )
        WITH CORRESPONDING #( keys )
        RESULT DATA(maintenance_tasks).

    " Get current date
    DATA(lv_today) = cl_abap_context_info=>get_system_date( ).

    " Calculate minimum due date (current date + 7 days)
    DATA(lv_min_due_date) = lv_today + 7.

    " Check if due date is at least 7 days in the future
    LOOP AT maintenance_tasks INTO DATA(maintenance_task).
      " Skip empty due dates (they will be caught by mandatory field validation)
      IF maintenance_task-DueDate IS INITIAL.
        CONTINUE.
      ENDIF.

      " Check if due date is at least 7 days in the future
      IF maintenance_task-DueDate < lv_min_due_date.
        APPEND VALUE #( %key = maintenance_task-%key
                      %msg = new_message( id = 'SY'
                                        number = '002'
                                        severity = if_abap_behv_message=>severity-error
                                        v1 = 'Due Date must be at least 7 days in the future' )
                      %element-DueDate = if_abap_behv=>mk-on ) TO reported-maintenance.
        APPEND VALUE #( %key = maintenance_task-%key ) TO failed-maintenance.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD validateMaintenanceMandatory.
    " Read the maintenance task entries that need to be validated
    READ ENTITIES OF zi_equipment_jc IN LOCAL MODE
      ENTITY Maintenance
        FIELDS (  TaskDescription DueDate   )
        WITH CORRESPONDING #( keys )
        RESULT DATA(maintenance_tasks).

    LOOP AT maintenance_tasks INTO DATA(task).
      " Check if all mandatory fields are filled


      IF task-TaskDescription IS INITIAL.
        APPEND VALUE #( %tky = task-%tky ) TO failed-maintenance.
        APPEND VALUE #( %tky = task-%tky
                        %msg = new_message_with_text(
                                 severity = if_abap_behv_message=>severity-error
                                 text = 'Description is required' )
                        %element-TaskDescription = if_abap_behv=>mk-on
                      ) TO reported-maintenance.
      ENDIF.

      IF task-DueDate IS INITIAL.
        APPEND VALUE #( %tky = task-%tky ) TO failed-maintenance.
        APPEND VALUE #( %tky = task-%tky
                        %msg = new_message_with_text(
                                 severity = if_abap_behv_message=>severity-error
                                 text = 'Due date is required' )
                        %element-DueDate = if_abap_behv=>mk-on
                      ) TO reported-maintenance.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD setDefaultDueDate.
    " Read maintenance task data
    READ ENTITIES OF zi_equipment_jc IN LOCAL MODE
      ENTITY Maintenance
        FIELDS ( DueDate )
        WITH CORRESPONDING #( keys )
        RESULT DATA(maintenance_tasks).

    DATA(lv_today) = cl_abap_context_info=>get_system_date( ).

    " Calculate default due date (7 days from today)
    DATA(lv_default_due_date) = CONV d( lv_today + 7 ).

    " Prepare modifications for tasks with empty due date (efficient modify)
    DATA: update_tasks TYPE TABLE FOR UPDATE zi_equipment_jc\\Maintenance.

    LOOP AT maintenance_tasks INTO DATA(task) WHERE DueDate IS INITIAL.
      APPEND VALUE #( %tky = task-%tky
                      DueDate = lv_default_due_date ) TO update_tasks.
    ENDLOOP.

    " Apply the modifications if any
    IF update_tasks IS NOT INITIAL.
      MODIFY ENTITIES OF zi_equipment_jc IN LOCAL MODE
        ENTITY Maintenance
        UPDATE FIELDS ( DueDate )
        WITH update_tasks.
    ENDIF.
  ENDMETHOD.

  METHOD setDefaultStatus.
    " Read maintenance task data
    READ ENTITIES OF zi_equipment_jc IN LOCAL MODE
      ENTITY Maintenance
        FIELDS ( Status StatusCriticality )
        WITH CORRESPONDING #( keys )
        RESULT DATA(maintenance_tasks).

    " Prepare modifications for tasks with empty status (efficient modify)
    DATA: update_tasks TYPE TABLE FOR UPDATE zi_equipment_jc\\Maintenance.

    LOOP AT maintenance_tasks INTO DATA(task) WHERE Status IS INITIAL.
      APPEND VALUE #( %tky = task-%tky
                      Status = 'OPEN'
                      StatusCriticality = 1
                      ) TO update_tasks.
    ENDLOOP.

    " Apply the modifications if any
    IF update_tasks IS NOT INITIAL.
      MODIFY ENTITIES OF zi_equipment_jc IN LOCAL MODE
        ENTITY Maintenance
        UPDATE FIELDS ( Status StatusCriticality )
        WITH update_tasks.
    ENDIF.
  ENDMETHOD.

  METHOD setEquipmentType.
    READ ENTITIES OF zi_equipment_jc IN LOCAL MODE
      ENTITY Equipment
        FIELDS ( EquipmentType )
        WITH CORRESPONDING #( keys )
        RESULT DATA(equipments).

    " Prepare modifications for those with empty equipment type (efficient modify)
    DATA: update_equipment TYPE TABLE FOR UPDATE zi_equipment_jc\\Equipment.

    LOOP AT equipments INTO DATA(equipment) WHERE EquipmentType IS INITIAL.
      " Set default equipment type to 'MECHANICAL'
      APPEND VALUE #( %tky = equipment-%tky
                      EquipmentType = 'MECHANICAL' ) TO update_equipment.
    ENDLOOP.

    " Apply the modifications if any
    IF update_equipment IS NOT INITIAL.
      MODIFY ENTITIES OF zi_equipment_jc IN LOCAL MODE
        ENTITY Equipment
          UPDATE FIELDS ( EquipmentType )
          WITH update_equipment.
    ENDIF.
  ENDMETHOD.

  METHOD startProgress.
    " Read the task entries that need to be updated
    READ ENTITIES OF zi_equipment_jc IN LOCAL MODE
      ENTITY Maintenance
      ALL FIELDS
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_entries).

    " Prepare modifications to set status to 'IN PROGRESS'
    DATA: lt_updates TYPE TABLE FOR UPDATE zi_equipment_jc\\Maintenance.
    DATA: lt_failed_keys TYPE TABLE FOR FAILED zi_equipment_jc\\Maintenance.
    DATA: lt_reported TYPE TABLE FOR REPORTED zi_equipment_jc\\Maintenance.

    LOOP AT lt_entries INTO DATA(ls_entry).
      " Check if task is already in progress or completed
      IF ls_entry-Status = 'IN PROGRES'.
        " Add to failed and reported
        APPEND VALUE #( %tky = ls_entry-%tky ) TO lt_failed_keys.
        APPEND VALUE #( %tky = ls_entry-%tky
                        %msg = new_message_with_text(
                                 severity = if_abap_behv_message=>severity-error
                                 text = 'Task is already in progress' )
                       ) TO lt_reported.
      ELSEIF ls_entry-Status = 'DONE'.
        " Add to failed and reported
        APPEND VALUE #( %tky = ls_entry-%tky ) TO lt_failed_keys.
        APPEND VALUE #( %tky = ls_entry-%tky
                        %msg = new_message_with_text(
                                 severity = if_abap_behv_message=>severity-error
                                 text = 'Completed tasks cannot be started again' )
                       ) TO lt_reported.
      ELSE.
        " Only update tasks that are not already in progress or done
        APPEND VALUE #( %tky = ls_entry-%tky
                       Status = 'IN PROGRES'
                       StatusCriticality = 2
                      ) TO lt_updates.
      ENDIF.
    ENDLOOP.

    " Apply the modifications
    MODIFY ENTITIES OF zi_equipment_jc IN LOCAL MODE
      ENTITY Maintenance
      UPDATE FIELDS ( Status StatusCriticality )
      WITH lt_updates.

    " Set the failed and reported entities
    failed-maintenance = lt_failed_keys.
    reported-maintenance = lt_reported.

    " Return the updated entries
    result = VALUE #( FOR ls_item IN lt_entries ( %tky = ls_item-%tky ) ).
  ENDMETHOD.

  METHOD closeTask.
    " Read the task entries that need to be updated
    READ ENTITIES OF zi_equipment_jc IN LOCAL MODE
      ENTITY Maintenance
        ALL FIELDS
        WITH CORRESPONDING #( keys )
      RESULT DATA(lt_entries).

    " Prepare modifications to set status to 'DONE'
    DATA: lt_updates TYPE TABLE FOR UPDATE zi_equipment_jc\\Maintenance.
    DATA: lt_failed_keys TYPE TABLE FOR FAILED zi_equipment_jc\\Maintenance.
    DATA: lt_reported TYPE TABLE FOR REPORTED zi_equipment_jc\\Maintenance.

    LOOP AT lt_entries INTO DATA(ls_entry).
      " Check if task is already done
      IF ls_entry-Status = 'DONE'.
        " Add to failed and reported
        APPEND VALUE #( %tky = ls_entry-%tky ) TO lt_failed_keys.
        APPEND VALUE #( %tky = ls_entry-%tky
                        %msg = new_message_with_text(
                          severity = if_abap_behv_message=>severity-error
                          text = 'Task is already marked as done' )
                      ) TO lt_reported.
      ELSE.
        " Update tasks that are not already done
        APPEND VALUE #( %tky = ls_entry-%tky
                        Status = 'DONE'
                        StatusCriticality = 3
                      ) TO lt_updates.
      ENDIF.
    ENDLOOP.

    " Apply the modifications
    MODIFY ENTITIES OF zi_equipment_jc IN LOCAL MODE
      ENTITY Maintenance
        UPDATE FIELDS ( Status StatusCriticality )
        WITH lt_updates.

    " Set the failed and reported entities
    failed-maintenance = lt_failed_keys.
    reported-maintenance = lt_reported.

    " Return the updated entries
    result = VALUE #( FOR ls_item IN lt_entries ( %tky = ls_item-%tky ) ).
  ENDMETHOD.

  METHOD get_instance_features.
    " Read relevant maintenance task instance data
    READ ENTITIES OF zi_equipment_jc IN LOCAL MODE
      ENTITY Maintenance
        FIELDS ( Status )
        WITH CORRESPONDING #( keys )
      RESULT DATA(maintenance_tasks)
      FAILED failed.

    result = VALUE #( FOR task IN maintenance_tasks
                      ( %tky = task-%tky
                        %action-startProgress = COND #( WHEN task-Status = 'OPEN'
                                                      THEN if_abap_behv=>fc-o-enabled
                                                      ELSE if_abap_behv=>fc-o-disabled )
                        %action-closeTask = COND #( WHEN task-Status = 'OPEN' OR task-Status = 'IN PROGRES'
                                                  THEN if_abap_behv=>fc-o-enabled
                                                  ELSE if_abap_behv=>fc-o-disabled ) )
                    ).
  ENDMETHOD.

  METHOD get_instance_authorizations.
  ENDMETHOD.
ENDCLASS.

CLASS lhc_Equipment DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Equipment RESULT result.

    METHODS validateEquipmentMandatory FOR VALIDATE ON SAVE
      IMPORTING keys FOR Equipment~validateEquipmentMandatory.

    METHODS validateEquipmentName FOR VALIDATE ON SAVE
      IMPORTING keys FOR Equipment~validateEquipmentName.

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

  METHOD validateEquipmentMandatory.
    READ ENTITIES OF zi_equipment_jc IN LOCAL MODE
    ENTITY Equipment
      FIELDS ( EquipmentName Location EquipmentType )
      WITH CORRESPONDING #( keys )
      RESULT DATA(equipments).

    " Check if all mandatory fields are filled
    LOOP AT equipments INTO DATA(equipment).
      " Check EquipmentName (mandatory)
      IF equipment-EquipmentName IS INITIAL.
        APPEND VALUE #( %key = equipment-%key
                      %msg = new_message( id = 'SY'
                                        number = '002'
                                        severity = if_abap_behv_message=>severity-error
                                        v1 = 'Equipment Name is required' )
                      %element-EquipmentName = if_abap_behv=>mk-on ) TO reported-equipment.
        APPEND VALUE #( %key = equipment-%key ) TO failed-equipment.
      ENDIF.

      " Check Location (mandatory)
      IF equipment-Location IS INITIAL.
        APPEND VALUE #( %key = equipment-%key
                      %msg = new_message( id = 'SY'
                                        number = '002'
                                        severity = if_abap_behv_message=>severity-error
                                        v1 = 'Location is required' )
                      %element-Location = if_abap_behv=>mk-on ) TO reported-equipment.
        APPEND VALUE #( %key = equipment-%key ) TO failed-equipment.
      ENDIF.

      " Check EquipmentType (mandatory)
      IF equipment-EquipmentType IS INITIAL.
        APPEND VALUE #( %key = equipment-%key
                      %msg = new_message( id = 'SY'
                                        number = '002'
                                        severity = if_abap_behv_message=>severity-error
                                        v1 = 'Equipment Type is required' )
                      %element-EquipmentType = if_abap_behv=>mk-on ) TO reported-equipment.
        APPEND VALUE #( %key = equipment-%key ) TO failed-equipment.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD validateEquipmentName.
    " Read the equipment entries that need to be validated
    READ ENTITIES OF zi_equipment_jc IN LOCAL MODE
      ENTITY Equipment
      ALL FIELDS
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_equipment).

    " Get all equipment names from the database for comparison
    SELECT equipment_id, equipment_name
      FROM zequipment_jc
      INTO TABLE @DATA(lt_existing_equipment).

    " Check equipment with non-empty names for duplicates
    LOOP AT lt_equipment INTO DATA(ls_equipment) WHERE EquipmentName IS NOT INITIAL.
      " Convert to uppercase for case-insensitive comparison
      DATA(lv_upper_name) = to_upper( ls_equipment-EquipmentName ).

      " Check against all existing equipment
      LOOP AT lt_existing_equipment INTO DATA(ls_existing) WHERE equipment_id <> ls_equipment-equipment_id.
        " Case-insensitive comparison
        IF to_upper( ls_existing-equipment_name ) = lv_upper_name.
          " Equipment name already exists - report error
          APPEND VALUE #( %tky = ls_equipment-%tky
                          %msg = new_message( id = 'SY'
                                            number = '002'
                                            severity = if_abap_behv_message=>severity-error
                                            v1 = 'Equipment with this name already exists' )
                          %element-EquipmentName = if_abap_behv=>mk-on ) TO reported-equipment.

          APPEND VALUE #( %tky = ls_equipment-%tky ) TO failed-equipment.

          " Exit inner loop once a duplicate is found
          EXIT.
        ENDIF.
      ENDLOOP.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.
