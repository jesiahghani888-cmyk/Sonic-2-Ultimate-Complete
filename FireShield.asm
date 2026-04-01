; ===========================================================================
; Fire Shield Implementation for Sonic 2
; Ported from Sonic 3 & Knuckles
; ===========================================================================

FireShield_Main:
    cmpi.b  #id_FireShield,(v_shield).w ; Does Sonic have a Fire Shield?
    bne.s   FireShield_Return       ; If not, return
    
    move.b  (v_jpadpress1).w,d0     ; Get button press
    andi.b  #btnABC,d0              ; Check for A, B, or C
    beq.s   FireShield_Return       ; If not pressed, return
    
    ; Trigger Fire Dash
    move.b  #1,(f_firedash).w       ; Set Fire Dash flag
    move.w  #$B9,d0                 ; Sound ID for Fire Dash
    jsr     (PlaySound).l           ; Play sound
    
    ; Execute Dash
    move.w  #$800,d0                ; Dash speed
    tst.b   (v_flip).w              ; Facing left?
    beq.s   FireShield_Right
    neg.w   d0                      ; Reverse speed
FireShield_Right:
    move.w  d0,(v_xvel).w           ; Set X velocity
    move.w  #0,(v_yvel).w           ; Stop vertical movement

FireShield_Return:
    rts
