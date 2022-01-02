# Marlin Configuration

D - Disable, ie place `//` at the start of a line<br>
E - Enable, ie delete the `//` at the start of a line<br>
C - Change<br>
E&C - Enable and Change

# Marlin/src/inc/Conditionals_LCD.h

Change the line:

```h
#if ANY(HAS_Z_SERVO_PROBE, FIX_MOUNTED_PROBE, NOZZLE_AS_PROBE, TOUCH_MI_PROBE, Z_PROBE_ALLEN_KEY, Z_PROBE_SLED, SOLENOID_PROBE, SENSORLESS_PROBING, RACK_AND_PINION_PROBE)
```

to

```h
#if ANY(PROBE_MANUALLY, HAS_Z_SERVO_PROBE, FIX_MOUNTED_PROBE, NOZZLE_AS_PROBE, TOUCH_MI_PROBE, Z_PROBE_ALLEN_KEY, Z_PROBE_SLED, SOLENOID_PROBE, SENSORLESS_PROBING, RACK_AND_PINION_PROBE)
```

This allows babystepping to be used with manual probing.

## Configuration.h

```h
C
#define MOTHERBOARD BOARD_BTT_SKR_V1_4_TURBO
C
#define SERIAL_PORT 3
E
#define SERIAL_PORT_2 -1
E&C
#define SERIAL_PORT_3 0
E&C
#define CUSTOM_MACHINE_NAME "MaybeCube"
E
#define PIDTEMPBED
C
#define EXTRUDE_MAXLENGTH 600
E
#define COREXY
D
//#define USE_ZMIN_PLUG
E
#define USE_ZMAX_PLUG
C
#define X_DRIVER_TYPE  TMC2209
#define Y_DRIVER_TYPE  TMC2209
#define Z_DRIVER_TYPE  TMC2209
#define E0_DRIVER_TYPE TMC2209
C
#define DEFAULT_AXIS_STEPS_PER_UNIT   { 80, 80, 400, 148 }
D
//#define Z_MIN_PROBE_USES_Z_MIN_ENDSTOP_PIN
E
#define PROBE_MANUALLY
C
#define INVERT_Y_DIR false
#define INVERT_Z_DIR true
#define INVERT_E0_DIR true
C
#define Z_HOME_DIR 1
C
#define X_BED_SIZE 184
#define Y_BED_SIZE 184
C
#define Z_MAX_POS 202.61
E
#define FILAMENT_RUNOUT_SENSOR
E
#define AUTO_BED_LEVELING_3POINT
E
#define RESTORE_LEVELING_AFTER_G28
C
#define HOMING_FEEDRATE_MM_M { (20*60), (20*60), (2*60) }
E
#define EEPROM_SETTINGS
E
#define EEPROM_AUTO_INIT    // Init EEPROM automatically on any errors.
E
#define PREHEAT_1_FAN_SPEED   255 // Value from 0 to 255
E
#define PREHEAT_2_FAN_SPEED   255 // Value from 0 to 255
E
#define NOZZLE_PARK_FEATURE
E
#define SDSUPPORT
E
#define SD_CHECK_AND_RETRY
E
#define INDIVIDUAL_AXIS_HOMING_MENU
E
#define SPEAKER
E
#define REPRAP_DISCOUNT_FULL_GRAPHIC_SMART_CONTROLLER
```

## Configuration_adv.h

```h
C
#define PID_EXTRUSION_SCALING
C
#define E0_AUTO_FAN_PIN FAN1_PIN
E
#define SENSORLESS_BACKOFF_MM  { 2, 2, 0 }       // (mm) Backoff from endstops before sensorless homing
C
#define HOMING_BUMP_MM      { 0, 0, 0 }       // (mm) Backoff from endstops after first bump
C
#define HOMING_BACKOFF_POST_MM { 2, 2, 2 }    // (mm) Backoff from endstops after homing
E
#define HOME_Y_BEFORE_X                       // If G28 contains XY home Y before X
E
#define ADAPTIVE_STEP_SMOOTHING
E
#define LCD_INFO_MENU
E
#define SOUND_MENU_ITEM
E
#define STATUS_MESSAGE_SCROLLING
E
#define LCD_SET_PROGRESS_MANUALLY
C
#define EVENT_GCODE_SD_ABORT "G28XY\nM84" // G-code to run on SD Abort Print (e.g., "G28XY" or "G27")
E
#define LONG_FILENAME_HOST_SUPPORT
E
#define SCROLL_LONG_FILENAMES
E
#define BABYSTEPPING
E
#define BABYSTEP_WITHOUT_HOMING
E
#define BABYSTEP_ALWAYS_AVAILABLE         // Allow babystepping at all times (not just during movement).
E
#define BABYSTEP_DISPLAY_TOTAL            // Display total babysteps since last G28
E
#define BABYSTEP_ZPROBE_OFFSET            // Combine M851 Z and Babystepping
E
#define LIN_ADVANCE
C
#define LIN_ADVANCE_K 0.0     // Unit: mm compression per 1mm/s extruder speed
E
#define ADVANCED_PAUSE_FEATURE
E
#define FILAMENT_LOAD_UNLOAD_GCODES             // Add M701/M702 Load/Unload G-codes, plus Load/Unload in the LCD Prepare menu.
D
//#define STEALTHCHOP_Z
D
//#define STEALTHCHOP_E
C
#define CHOPPER_TIMING CHOPPER_DEFAULT_24V        // All axes (override below)
E
#define HYBRID_THRESHOLD
E
#define SENSORLESS_HOMING // StallGuard capable drivers only
C
#define X_STALL_SENSITIVITY  30
C
#define Y_STALL_SENSITIVITY  60
C
#define Z_STALL_SENSITIVITY  32
E
#define IMPROVE_HOMING_RELIABILITY
E
#define HOST_ACTION_COMMANDS
E
#define CANCEL_OBJECTS
```
