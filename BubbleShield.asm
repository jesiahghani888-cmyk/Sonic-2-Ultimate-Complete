; ===========================================================================
; Bubble Shield Implementation for Sonic 2
; Ported from Sonic 3 & Knuckles
; ===========================================================================

BubbleShield_Main:
    cmpi.b  #id_BubbleShield,(v_shield).w ; Does Sonic have a Bubble Shield?
    bne.s   BubbleShield_Return     ; If not, return
    
    move.b  (v_jpadpress1).w,d0     ; Get button press
    andi.b  #btnABC,d0              ; Check for A, B, or C
    beq.s   BubbleShield_Return     ; If not pressed, return
    
    ; Trigger Bubble Bounce
    move.b  #1,(f_bubblebounce).w   ; Set Bubble Bounce flag
    move.w  #$BA,d0                 ; Sound ID for Bubble Bounce
    jsr     (PlaySound).l           ; Play sound
    
    ; Execute Bounce
    move.w  #$800,(v_yvel).w        ; Set Y velocity to bounce down
    move.w  #0,(v_xvel).w           ; Stop horizontal movement

BubbleShield_Return:
    rts
