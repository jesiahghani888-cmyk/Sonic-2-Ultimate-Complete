; ===========================================================================
; Lightning Shield Implementation for Sonic 2
; Ported from Sonic 3 & Knuckles
; ===========================================================================

LightningShield_Main:
    cmpi.b  #id_LightningShield,(v_shield).w ; Does Sonic have a Lightning Shield?
    bne.s   LightningShield_Return  ; If not, return
    
    move.b  (v_jpadpress1).w,d0     ; Get button press
    andi.b  #btnABC,d0              ; Check for A, B, or C
    beq.s   LightningShield_Return  ; If not pressed, return
    
    ; Trigger Double Jump
    move.b  #1,(f_doublejump).w     ; Set Double Jump flag
    move.w  #$BB,d0                 ; Sound ID for Double Jump
    jsr     (PlaySound).l           ; Play sound
    
    ; Execute Jump
    move.w  #-$600,(v_yvel).w       ; Set Y velocity to jump up
    move.w  #0,(v_xvel).w           ; Stop horizontal movement

LightningShield_Return:
    rts
