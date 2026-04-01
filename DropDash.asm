; ===========================================================================
; Drop Dash Implementation for Sonic 2
; Ported from Sonic Mania
; ===========================================================================

DropDash_Main:
    tst.b   (f_dropdash).w          ; Is Drop Dash already active?
    bne.s   DropDash_CheckRelease   ; If yes, check for release
    
    move.b  (v_jpadhold1).w,d0      ; Get button hold
    andi.b  #btnABC,d0              ; Check for A, B, or C
    beq.s   DropDash_Return         ; If not held, return
    
    ; Check if Sonic is in the air and falling
    tst.b   (v_air).w               ; Is Sonic in the air?
    beq.s   DropDash_Return         ; If not, return
    move.w  (v_yvel).w,d1           ; Get Y velocity
    bmi.s   DropDash_Return         ; If moving up, return
    
    ; Charge Drop Dash
    addq.b  #1,(v_dropdash_charge).w ; Increment charge
    cmpi.b  #20,(v_dropdash_charge).w ; Max charge?
    blo.s   DropDash_Return
    
    move.b  #1,(f_dropdash).w       ; Set Drop Dash flag
    move.w  #$B4,d0                 ; Sound ID for Drop Dash charge
    jsr     (PlaySound).l           ; Play sound
    
DropDash_CheckRelease:
    move.b  (v_jpadhold1).w,d0      ; Get button hold
    andi.b  #btnABC,d0              ; Check for A, B, or C
    bne.s   DropDash_Return         ; If still held, return
    
    ; Release Drop Dash
    clr.b   (f_dropdash).w          ; Clear Drop Dash flag
    clr.b   (v_dropdash_charge).w   ; Clear charge
    
    ; Check for landing
    tst.b   (v_air).w               ; Is Sonic on the ground?
    bne.s   DropDash_Return         ; If not, return
    
    ; Execute Dash
    move.w  #$800,d0                ; Dash speed
    tst.b   (v_flip).w              ; Facing left?
    beq.s   DropDash_Right
    neg.w   d0                      ; Reverse speed
DropDash_Right:
    move.w  d0,(v_xvel).w           ; Set X velocity
    move.b  #id_Roll,0(a0)          ; Set Sonic to rolling state
    move.w  #$B5,d0                 ; Sound ID for Drop Dash release
    jsr     (PlaySound).l           ; Play sound

DropDash_Return:
    rts
