; ===========================================================================
; Insta-Shield Implementation for Sonic 2
; Ported from Sonic 3 & Knuckles
; ===========================================================================

InstaShield_Main:
    tst.b   (v_shield).w            ; Does Sonic have a shield?
    bne.s   InstaShield_Return      ; If yes, don't do Insta-Shield
    tst.b   (v_invinc).w            ; Is Sonic invincible?
    bne.s   InstaShield_Return      ; If yes, don't do Insta-Shield
    
    move.b  (v_jpadpress1).w,d0     ; Get button press
    andi.b  #btnABC,d0              ; Check for A, B, or C
    beq.s   InstaShield_Return      ; If not pressed, return
    
    ; Trigger Insta-Shield
    move.b  #1,(f_instashield).w    ; Set Insta-Shield flag
    move.w  #$BC,d0                 ; Sound ID for Insta-Shield
    jsr     (PlaySound).l           ; Play sound
    
    ; Create Insta-Shield Object
    jsr     (SingleObjLoad).l
    bne.s   InstaShield_Return
    move.b  #id_InstaShield,0(a1)   ; Set object ID
    move.w  8(a0),8(a1)             ; Copy X position
    move.w  12(a0),12(a1)           ; Copy Y position
    move.l  a0,24(a1)               ; Link to Sonic

InstaShield_Return:
    rts

; Note: This requires id_InstaShield to be defined in constants.asm
; and the object code to be included in the object pointers table.
