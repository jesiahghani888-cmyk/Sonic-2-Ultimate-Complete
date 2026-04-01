; ===========================================================================
; Air Recurl Implementation for Sonic 2
; Ported from Sonic Triple Trouble
; ===========================================================================

AirRecurl_Main:
    tst.b   (v_air).w               ; Is Sonic in the air?
    beq.s   AirRecurl_Return        ; If no, return
    
    move.b  (v_jpadpress1).w,d0     ; Get button press
    andi.b  #btnABC,d0              ; Check for A, B, or C
    beq.s   AirRecurl_Return        ; If not pressed, return
    
    ; Check if already in ball form
    cmpi.b  #id_Roll,0(a0)          ; Already rolling?
    beq.s   AirRecurl_Return        ; If yes, don't recurl
    
    ; Perform Air Recurl
    move.b  #id_Roll,0(a0)          ; Set state to rolling
    move.w  #$B8,d0                 ; Sound ID for Air Recurl
    jsr     (PlaySound).l
    
    ; Adjust collision box for ball form
    move.b  #$E,14(a0)              ; Set height to 14
    move.b  #7,15(a0)               ; Set width to 7

AirRecurl_Return:
    rts
