; ===========================================================================
; Knuckles Playable Character Implementation for Sonic 2
; Ported from Sonic 3 & Knuckles
; ===========================================================================

Knuckles_Main:
    cmpi.b  #id_Knuckles,(v_player).w ; Is the player Knuckles?
    bne.s   Knuckles_Return         ; If not, return
    
    move.b  (v_jpadpress1).w,d0     ; Get button press
    andi.b  #btnABC,d0              ; Check for A, B, or C
    beq.s   Knuckles_Return         ; If not pressed, return
    
    ; Trigger Glide
    move.b  #1,(f_glide).w          ; Set Glide flag
    move.w  #$BC,d0                 ; Sound ID for Glide
    jsr     (PlaySound).l           ; Play sound
    
    ; Execute Glide
    move.w  #$400,d0                ; Glide speed
    tst.b   (v_flip).w              ; Facing left?
    beq.s   Knuckles_Right
    neg.w   d0                      ; Reverse speed
Knuckles_Right:
    move.w  d0,(v_xvel).w           ; Set X velocity
    move.w  #$80,(v_yvel).w         ; Set Y velocity to slow fall

Knuckles_Return:
    rts
