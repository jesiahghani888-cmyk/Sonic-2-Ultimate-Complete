; ===========================================================================
; Bubble Shield Implementation for Sonic 2
; Ported from Sonic 3 & Knuckles
; ===========================================================================

BubbleShield_Main:
    cmpi.b  #3,(v_shield).w         ; Does Sonic have a Bubble Shield?
    bne.s   BubbleShield_Return     ; If no, return
    
    tst.b   (v_air).w               ; Is Sonic in the air?
    beq.s   BubbleShield_Reset      ; If no, reset bounce flag
    
    tst.b   (f_bubblebounce).w      ; Already bouncing?
    bne.s   BubbleShield_Return     ; If yes, don't bounce again
    
    move.b  (v_jpadpress1).w,d0     ; Get button press
    andi.b  #btnABC,d0              ; Check for A, B, or C
    beq.s   BubbleShield_Return     ; If not pressed, return
    
    ; Perform Bubble Bounce
    move.b  #1,(f_bubblebounce).w   ; Set bounce flag
    move.w  #$BA,d0                 ; Sound ID for Bubble Bounce
    jsr     (PlaySound).l
    
    move.w  #$800,(v_yvel).w        ; Set vertical velocity (downward)
    clr.w   (v_xvel).w              ; Zero horizontal velocity

BubbleShield_Reset:
    tst.b   (v_air).w
    bne.s   BubbleShield_Return
    clr.b   (f_bubblebounce).w

BubbleShield_Return:
    rts
