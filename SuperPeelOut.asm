; ===========================================================================
; Super Peel-Out Implementation for Sonic 2
; Ported from Sonic CD
; ===========================================================================

SuperPeelOut_Main:
    tst.b   (f_peelout).w           ; Is Super Peel-Out already active?
    bne.s   SuperPeelOut_CheckRelease ; If yes, check for release
    
    move.b  (v_jpadhold1).w,d0      ; Get button hold
    andi.b  #btnUp,d0               ; Check for Up
    beq.s   SuperPeelOut_Return     ; If not held, return
    
    move.b  (v_jpadpress1).w,d0     ; Get button press
    andi.b  #btnABC,d0              ; Check for A, B, or C
    beq.s   SuperPeelOut_Return     ; If not pressed, return
    
    ; Check if Sonic is on the ground and stationary
    tst.b   (v_air).w               ; Is Sonic in the air?
    bne.s   SuperPeelOut_Return     ; If yes, return
    tst.w   (v_xvel).w              ; Is Sonic moving?
    bne.s   SuperPeelOut_Return     ; If yes, return
    
    ; Charge Super Peel-Out
    move.b  #1,(f_peelout).w        ; Set Super Peel-Out flag
    move.w  #$B6,d0                 ; Sound ID for Super Peel-Out charge
    jsr     (PlaySound).l           ; Play sound
    
SuperPeelOut_CheckRelease:
    move.b  (v_jpadhold1).w,d0      ; Get button hold
    andi.b  #btnUp,d0               ; Check for Up
    bne.s   SuperPeelOut_Return     ; If still held, return
    
    ; Release Super Peel-Out
    clr.b   (f_peelout).w           ; Clear Super Peel-Out flag
    
    ; Execute Peel-Out
    move.w  #$C00,d0                ; Peel-Out speed
    tst.b   (v_flip).w              ; Facing left?
    beq.s   SuperPeelOut_Right
    neg.w   d0                      ; Reverse speed
SuperPeelOut_Right:
    move.w  d0,(v_xvel).w           ; Set X velocity
    move.b  #id_Run,0(a0)           ; Set Sonic to running state
    move.w  #$B7,d0                 ; Sound ID for Super Peel-Out release
    jsr     (PlaySound).l           ; Play sound

SuperPeelOut_Return:
    rts
