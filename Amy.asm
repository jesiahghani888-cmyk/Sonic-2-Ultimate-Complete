; ===========================================================================
; Amy Rose Playable Character Implementation for Sonic 2
; Ported from Sonic Superstars
; ===========================================================================

Amy_Main:
    cmpi.b  #id_Amy,(v_player).w    ; Is the player Amy?
    bne.s   Amy_Return              ; If not, return
    
    move.b  (v_jpadpress1).w,d0     ; Get button press
    andi.b  #btnABC,d0              ; Check for A, B, or C
    beq.s   Amy_Return              ; If not pressed, return
    
    ; Trigger Hammer Attack
    move.b  #1,(f_hammer).w         ; Set Hammer flag
    move.w  #$BD,d0                 ; Sound ID for Hammer
    jsr     (PlaySound).l           ; Play sound
    
    ; Execute Hammer Attack
    move.b  #id_Hammer,0(a0)        ; Set Amy to hammer state
    move.w  #$400,d0                ; Hammer speed
    tst.b   (v_flip).w              ; Facing left?
    beq.s   Amy_Right
    neg.w   d0                      ; Reverse speed
Amy_Right:
    move.w  d0,(v_xvel).w           ; Set X velocity
    move.w  #-$400,(v_yvel).w       ; Set Y velocity to jump up

Amy_Return:
    rts
