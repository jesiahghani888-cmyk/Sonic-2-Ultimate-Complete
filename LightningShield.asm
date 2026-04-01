; ===========================================================================
; Lightning Shield Implementation for Sonic 2
; Ported from Sonic 3 & Knuckles
; ===========================================================================

LightningShield_Main:
    cmpi.b  #4,(v_shield).w         ; Does Sonic have a Lightning Shield?
    bne.s   LightningShield_Return  ; If no, return
    
    tst.b   (v_air).w               ; Is Sonic in the air?
    beq.s   LightningShield_Reset   ; If no, reset double jump flag
    
    tst.b   (f_doublejump).w        ; Already double jumped?
    bne.s   LightningShield_Return  ; If yes, don't jump again
    
    move.b  (v_jpadpress1).w,d0     ; Get button press
    andi.b  #btnABC,d0              ; Check for A, B, or C
    beq.s   LightningShield_Return  ; If not pressed, return
    
    ; Perform Lightning Double Jump
    move.b  #1,(f_doublejump).w     ; Set double jump flag
    move.w  #$BB,d0                 ; Sound ID for Lightning Jump
    jsr     (PlaySound).l
    
    move.w  #-$600,(v_yvel).w       ; Set vertical velocity (upward)
    clr.w   (v_xvel).w              ; Zero horizontal velocity

LightningShield_Reset:
    tst.b   (v_air).w
    bne.s   LightningShield_Return
    clr.b   (f_doublejump).w

LightningShield_Return:
    rts
