; ===========================================================================
; Insta-Shield Implementation for Sonic 2
; Ported from Sonic 3 & Knuckles
; ===========================================================================

InstaShield_Main:
    tst.b   (v_shield).w            ; Does Sonic have a shield?
    bne.s   InstaShield_Return      ; If yes, don't do Insta-Shield
    tst.b   (v_invinc).w            ; Is Sonic invincible?
    bne.s   InstaShield_Return      ; If yes, don't do Insta-Shield
    tst.b   (v_air).w               ; Is Sonic in the air?
    beq.s   InstaShield_Return      ; If no, don't do Insta-Shield
    
    ; Check if already used in this jump
    tst.b   (f_instashield).w
    bne.s   InstaShield_Return
    
    move.b  (v_jpadpress1).w,d0     ; Get button press
    andi.b  #btnABC,d0              ; Check for A, B, or C
    beq.s   InstaShield_Return      ; If not pressed, return
    
    ; Trigger Insta-Shield
    move.b  #1,(f_instashield).w    ; Set Insta-Shield flag
    move.w  #$BC,d0                 ; Sound ID for Insta-Shield (S3K value, adjust if needed)
    jsr     (PlaySound).l           ; Play sound
    
    ; Create Insta-Shield Object
    jsr     (SingleObjLoad).l
    bne.s   InstaShield_Return
    move.b  #id_InstaShield,0(a1)   ; Set object ID
    move.w  8(a0),8(a1)             ; Copy X position
    move.w  12(a0),12(a1)           ; Copy Y position
    move.l  a0,24(a1)               ; Link to Sonic

InstaShield_Return:
    ; Reset flag when grounded
    tst.b   (v_air).w
    bne.s   @exit
    clr.b   (f_instashield).w
@exit:
    rts
