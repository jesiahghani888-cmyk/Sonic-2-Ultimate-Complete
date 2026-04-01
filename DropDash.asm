; ===========================================================================
; Drop Dash Implementation for Sonic 2
; Ported from Sonic Mania
; ===========================================================================

DropDash_Main:
    tst.b   (v_air).w               ; Is Sonic in the air?
    beq.s   DropDash_OnGround       ; If no, handle landing
    
    ; Airborne handling
    tst.b   (f_dropdash).w          ; Already charged?
    bne.s   DropDash_Return
    
    move.b  (v_jpadhold1).w,d0      ; Get held buttons
    andi.b  #btnABC,d0              ; Check for A, B, or C
    beq.s   DropDash_ResetCharge    ; If not held, reset charge
    
    tst.w   (v_yvel).w              ; Falling or rising?
    bmi.s   DropDash_Return         ; Don't charge while rising
    
    addq.b  #1,(v_dropdash_charge).w ; Increment charge
    cmpi.b  #20,(v_dropdash_charge).w ; Fully charged? (approx 1/3 second)
    blo.s   DropDash_Return
    
    move.b  #1,(f_dropdash).w       ; Set charged flag
    move.w  #$B4,d0                 ; Sound ID for Drop Dash charge
    jsr     (PlaySound).l
    bra.s   DropDash_Return

DropDash_ResetCharge:
    clr.b   (v_dropdash_charge).w
    clr.b   (f_dropdash).w
    rts

DropDash_OnGround:
    tst.b   (f_dropdash).w          ; Was it charged?
    beq.s   DropDash_Return
    
    ; Perform Drop Dash
    clr.b   (f_dropdash).w
    clr.b   (v_dropdash_charge).w
    
    move.w  #$800,d0                ; Base speed
    tst.b   (v_flip).w              ; Facing left?
    beq.s   @facingRight
    neg.w   d0                      ; Reverse speed
@facingRight:
    move.w  d0,(v_xvel).w           ; Set horizontal velocity
    
    move.b  #id_Roll,0(a0)          ; Set state to rolling
    move.w  #$B5,d0                 ; Sound ID for Drop Dash release
    jsr     (PlaySound).l
    
DropDash_Return:
    rts
