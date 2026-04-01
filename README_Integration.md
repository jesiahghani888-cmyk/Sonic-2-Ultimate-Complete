# Sonic 2 Ultimate Complete - Integration Guide

This guide provides instructions on how to integrate the new features into your Sonic 2 ROM hack.

## New Features

### Control Moves
- **Insta-Shield**: Press A, B, or C in the air to trigger a brief shield that protects you from enemies and projectiles.
- **Drop Dash**: Hold A, B, or C in the air to charge a dash that triggers upon landing.
- **Super Peel-Out**: Hold Up and press A, B, or C while stationary to charge a high-speed dash.
- **Air Recurl**: Press A, B, or C in the air to recurl into a ball, allowing you to attack enemies while falling.

### Elemental Shields
- **Fire Shield**: Press A, B, or C in the air to perform a horizontal dash.
- **Bubble Shield**: Press A, B, or C in the air to bounce down and jump higher.
- **Lightning Shield**: Press A, B, or C in the air to perform a double jump.

### Playable Characters
- **Knuckles**: Glide through the air and climb walls.
- **Amy Rose**: Use her hammer to attack enemies and jump higher.

## Integration Steps

1. **Include the Main Integration File**:
   In your main disassembly file (usually `s2.asm`), add the following line at the end of the file:
   ```asm
   include "MainIntegration.asm"
   ```

2. **Call the Update Routine**:
   In your player update routine (usually `Sonic_Update`), add the following line:
   ```asm
   jsr     Sonic2UltimateComplete_Update
   ```

3. **Define Constants**:
   Ensure that the following constants are defined in your `s2.constants.asm` file:
   ```asm
   v_shield:          equ $FFFFF640
   v_invinc:          equ $FFFFF641
   v_jpadpress1:      equ $FFFFF605
   v_jpadhold1:       equ $FFFFF604
   f_instashield:     equ $FFFFF642
   f_dropdash:        equ $FFFFF643
   v_dropdash_charge: equ $FFFFF644
   f_peelout:         equ $FFFFF645
   v_air:             equ $FFFFF646
   v_xvel:            equ $FFFFF610
   v_yvel:            equ $FFFFF612
   v_flip:            equ $FFFFF614
   v_player:          equ $FFFFF616
   f_firedash:        equ $FFFFF647
   f_bubblebounce:    equ $FFFFF648
   f_doublejump:      equ $FFFFF649
   f_glide:           equ $FFFFF64A
   f_hammer:          equ $FFFFF64B
   ```

4. **Add Object IDs**:
   Ensure that the following object IDs are defined in your `s2.constants.asm` file:
   ```asm
   id_InstaShield:    equ $80
   id_FireShield:     equ $81
   id_BubbleShield:   equ $82
   id_LightningShield: equ $83
   id_Knuckles:       equ $84
   id_Amy:            equ $85
   id_Hammer:         equ $86
   id_Roll:           equ $02
   id_Run:            equ $03
   ```

5. **Build the ROM**:
   Run your build script (usually `build.bat` or `build.lua`) to compile the ROM with the new features.

## Support

If you encounter any issues or have questions, please refer to the [Sonic Retro](https://info.sonicretro.org/Main_Page) or [Sonic Research](https://sonicresearch.org/community/index.php) communities for assistance.
