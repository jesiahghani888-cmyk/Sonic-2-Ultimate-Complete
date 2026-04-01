; ===========================================================================
; Amy Rose Playable Character Implementation for Sonic 2
; Ported from Sonic Superstars
; ===========================================================================

Amy_Main:
    cmpi.b  #3,(v_player).w         ; Is the player Amy?
    bne.s   Amy_Return              ; If no, return
    
    tst.b   (v_air).w               ; Is Amy in the air?
    beq.s   Amy_Reset               ; If no, reset hammer flag
    
    tst.b   (f_hammer).w            ; Already using hammer?
    bne.s   Amy_Return              ; If yes, don't use again
    
    move.b  (v_jpadpress1).w,d0     ; Get button press
    andi.b  #btnABC,d0              ; Check for A, B, or C
    beq.s   Amy_Return              ; If not pressed, return
    
    ; Perform Hammer Attack
    move.b  #1,(f_hammer).w         ; Set hammer flag
    move.w  #$BD,d0                 ; Sound ID for Hammer Attack
    jsr     (PlaySound).l
    
    move.b  #id_Hammer,0(a0)        ; Set state to hammer attack
    move.w  #$400,d0                ; Attack speed
    tst.b   (v_flip).w              ; Facing left?
    beq.s   @facingRight
    neg.w   d0                      ; Reverse speed
@facingRight:
    move.w  d0,(v_xvel).w           ; Set horizontal velocity
    move.w  #-$400,(v_yvel).w       ; Set vertical velocity (upward jump)

Amy_Reset:
    tst.b   (v_air).w
    bne.s   Amy_Return
    clr.b   (f_hammer).w

Amy_Return:
    rts
