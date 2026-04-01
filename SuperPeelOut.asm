; ===========================================================================
; Super Peel-Out Implementation for Sonic 2
; Ported from Sonic CD
; ===========================================================================

SuperPeelOut_Main:
    tst.b   (v_air).w               ; Is Sonic in the air?
    bne.s   SuperPeelOut_Reset      ; If yes, reset Peel-Out
    
    tst.b   (f_peelout).w           ; Already charging?
    bne.s   SuperPeelOut_Charging   ; If yes, handle charging
    
    ; Check for start of Peel-Out
    move.b  (v_jpadhold1).w,d0      ; Get held buttons
    andi.b  #btnUp,d0               ; Holding Up?
    beq.s   SuperPeelOut_Return     ; If no, return
    
    move.b  (v_jpadpress1).w,d0     ; Get pressed buttons
    andi.b  #btnABC,d0              ; Pressed A, B, or C?
    beq.s   SuperPeelOut_Return     ; If no, return
    
    tst.w   (v_xvel).w              ; Stationary?
    bne.s   SuperPeelOut_Return     ; If no, return
    
    ; Start Peel-Out
    move.b  #1,(f_peelout).w        ; Set Peel-Out flag
    move.w  #$B6,d0                 ; Sound ID for Peel-Out charge
    jsr     (PlaySound).l
    bra.s   SuperPeelOut_Return

SuperPeelOut_Charging:
    move.b  (v_jpadhold1).w,d0      ; Get held buttons
    andi.b  #btnUp,d0               ; Still holding Up?
    beq.s   SuperPeelOut_Release    ; If no, release Peel-Out
    
    ; Increment charge
    addq.b  #1,(v_dropdash_charge).w ; Reuse charge counter
    cmpi.b  #30,(v_dropdash_charge).w ; Fully charged?
    blo.s   SuperPeelOut_Return
    
    ; Max charge reached
    move.b  #30,(v_dropdash_charge).w
    bra.s   SuperPeelOut_Return

SuperPeelOut_Release:
    ; Perform Peel-Out
    clr.b   (f_peelout).w
    clr.b   (v_dropdash_charge).w
    
    move.w  #$C00,d0                ; Base speed
    tst.b   (v_flip).w              ; Facing left?
    beq.s   @facingRight
    neg.w   d0                      ; Reverse speed
@facingRight:
    move.w  d0,(v_xvel).w           ; Set horizontal velocity
    
    move.b  #id_Run,0(a0)           ; Set state to running
    move.w  #$B7,d0                 ; Sound ID for Peel-Out release
    jsr     (PlaySound).l
    bra.s   SuperPeelOut_Return

SuperPeelOut_Reset:
    clr.b   (f_peelout).w
    clr.b   (v_dropdash_charge).w

SuperPeelOut_Return:
    rts
