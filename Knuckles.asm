; ===========================================================================
; Knuckles Playable Character Implementation for Sonic 2
; Ported from Sonic 3 & Knuckles
; ===========================================================================

Knuckles_Main:
    cmpi.b  #2,(v_player).w         ; Is the player Knuckles?
    bne.s   Knuckles_Return         ; If no, return
    
    tst.b   (v_air).w               ; Is Knuckles in the air?
    beq.s   Knuckles_Reset          ; If no, reset glide flag
    
    tst.b   (f_glide).w             ; Already gliding?
    bne.s   Knuckles_Gliding        ; If yes, handle gliding
    
    move.b  (v_jpadpress1).w,d0     ; Get button press
    andi.b  #btnABC,d0              ; Check for A, B, or C
    beq.s   Knuckles_Return         ; If not pressed, return
    
    ; Start Glide
    move.b  #1,(f_glide).w          ; Set glide flag
    move.w  #$BC,d0                 ; Sound ID for Glide
    jsr     (PlaySound).l
    
    move.w  #$400,d0                ; Glide speed
    tst.b   (v_flip).w              ; Facing left?
    beq.s   @facingRight
    neg.w   d0                      ; Reverse speed
@facingRight:
    move.w  d0,(v_xvel).w           ; Set horizontal velocity
    move.w  #$80,(v_yvel).w         ; Set slow fall velocity
    bra.s   Knuckles_Return

Knuckles_Gliding:
    move.b  (v_jpadhold1).w,d0      ; Get held buttons
    andi.b  #btnABC,d0              ; Still holding A, B, or C?
    beq.s   Knuckles_StopGlide      ; If no, stop gliding
    
    ; Maintain glide speed and slow fall
    move.w  #$400,d0                ; Glide speed
    tst.b   (v_flip).w              ; Facing left?
    beq.s   @facingRight
    neg.w   d0                      ; Reverse speed
@facingRight:
    move.w  d0,(v_xvel).w           ; Set horizontal velocity
    move.w  #$80,(v_yvel).w         ; Set slow fall velocity
    bra.s   Knuckles_Return

Knuckles_StopGlide:
    clr.b   (f_glide).w
    move.w  #0,(v_xvel).w           ; Stop horizontal movement
    move.w  #$200,(v_yvel).w        ; Fall normally
    bra.s   Knuckles_Return

Knuckles_Reset:
    tst.b   (v_air).w
    bne.s   Knuckles_Return
    clr.b   (f_glide).w

Knuckles_Return:
    rts
