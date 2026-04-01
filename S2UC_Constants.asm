; ===========================================================================
; Sonic 2 Ultimate Complete - Constants and RAM Addresses
; ===========================================================================

; --- RAM Addresses (Standard Sonic 2 Disassembly) ---
v_shield:          equ $FFFFF640    ; Shield type (0=None, 1=Blue, 2=Fire, 3=Bubble, 4=Lightning)
v_invinc:          equ $FFFFF641    ; Invincibility flag
v_jpadpress1:      equ $FFFFF605    ; Buttons pressed this frame
v_jpadhold1:       equ $FFFFF604    ; Buttons held this frame
v_air:             equ $FFFFF646    ; Airborne flag (0=Ground, 1=Air)
v_xvel:            equ $FFFFF610    ; Horizontal velocity
v_yvel:            equ $FFFFF612    ; Vertical velocity
v_flip:            equ $FFFFF614    ; Facing direction (0=Right, 1=Left)
v_player:          equ $FFFFF616    ; Player character ID (0=Sonic, 1=Tails, 2=Knuckles, 3=Amy)

; --- New Feature Flags and Variables ---
f_instashield:     equ $FFFFF642    ; Insta-Shield active flag
f_dropdash:        equ $FFFFF643    ; Drop Dash active flag
v_dropdash_charge: equ $FFFFF644    ; Drop Dash charge counter
f_peelout:         equ $FFFFF645    ; Super Peel-Out active flag
f_firedash:        equ $FFFFF647    ; Fire Shield dash flag
f_bubblebounce:    equ $FFFFF648    ; Bubble Shield bounce flag
f_doublejump:      equ $FFFFF649    ; Lightning Shield double jump flag
f_glide:           equ $FFFFF64A    ; Knuckles glide flag
f_hammer:          equ $FFFFF64B    ; Amy hammer attack flag

; --- Object IDs ---
id_InstaShield:    equ $80
id_FireShield:     equ $81
id_BubbleShield:   equ $82
id_LightningShield: equ $83
id_Knuckles:       equ $84
id_Amy:            equ $85
id_Hammer:         equ $86
id_Roll:           equ $02
id_Run:            equ $03

; --- Button Bitmasks ---
btnABC:            equ %01110000    ; A, B, or C buttons
btnUp:             equ %00000001    ; Up button
btnDown:           equ %00000010    ; Down button
btnLeft:           equ %00000100    ; Left button
btnRight:          equ %00001000    ; Right button
