; ===========================================================================
; Air Recurl Implementation for Sonic 2
; Ported from Sonic Triple Trouble
; ===========================================================================

AirRecurl_Main:
    tst.b   (v_air).w               ; Is Sonic in the air?
    beq.s   AirRecurl_Return        ; If not, return
    
    move.b  (v_jpadpress1).w,d0     ; Get button press
    andi.b  #btnABC,d0              ; Check for A, B, or C
    beq.s   AirRecurl_Return        ; If not pressed, return
    
    ; Check if Sonic is in a non-rolling state
    cmpi.b  #id_Roll,0(a0)          ; Is Sonic already rolling?
    beq.s   AirRecurl_Return        ; If yes, return
    
    ; Recurl into ball
    move.b  #id_Roll,0(a0)          ; Set Sonic to rolling state
    move.w  #$B8,d0                 ; Sound ID for Air Recurl
    jsr     (PlaySound).l           ; Play sound
    
    ; Adjust collision box
    move.b  #$E,14(a0)              ; Set height to 14 pixels
    move.b  #7,15(a0)               ; Set width to 7 pixels

AirRecurl_Return:
    rts
