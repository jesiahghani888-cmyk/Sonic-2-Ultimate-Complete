; ===========================================================================
; Fire Shield Implementation for Sonic 2
; Ported from Sonic 3 & Knuckles
; ===========================================================================

FireShield_Main:
    cmpi.b  #2,(v_shield).w         ; Does Sonic have a Fire Shield?
    bne.s   FireShield_Return       ; If no, return
    
    tst.b   (v_air).w               ; Is Sonic in the air?
    beq.s   FireShield_Reset        ; If no, reset dash flag
    
    tst.b   (f_firedash).w          ; Already dashed?
    bne.s   FireShield_Return       ; If yes, don't dash again
    
    move.b  (v_jpadpress1).w,d0     ; Get button press
    andi.b  #btnABC,d0              ; Check for A, B, or C
    beq.s   FireShield_Return       ; If not pressed, return
    
    ; Perform Fire Dash
    move.b  #1,(f_firedash).w       ; Set dash flag
    move.w  #$B9,d0                 ; Sound ID for Fire Dash
    jsr     (PlaySound).l
    
    move.w  #$800,d0                ; Dash speed
    tst.b   (v_flip).w              ; Facing left?
    beq.s   @facingRight
    neg.w   d0                      ; Reverse speed
@facingRight:
    move.w  d0,(v_xvel).w           ; Set horizontal velocity
    clr.w   (v_yvel).w              ; Zero vertical velocity

FireShield_Reset:
    tst.b   (v_air).w
    bne.s   FireShield_Return
    clr.b   (f_firedash).w

FireShield_Return:
    rts
