; ===========================================================================
; Main Integration File for Sonic 2 Ultimate Complete
; This file includes all the new features and provides a central point for integration.
; ===========================================================================

; Include Constants
include "S2UC_Constants.asm"

; Include Control Moves
include "InstaShield.asm"
include "DropDash.asm"
include "SuperPeelOut.asm"
include "AirRecurl.asm"

; Include Elemental Shields
include "FireShield.asm"
include "BubbleShield.asm"
include "LightningShield.asm"

; Include Playable Characters
include "Knuckles.asm"
include "Amy.asm"

; ===========================================================================
; Main Update Loop for Sonic 2 Ultimate Complete
; Call this from the player update routine in the main disassembly.
; ===========================================================================

Sonic2UltimateComplete_Update:
    ; Update Control Moves
    jsr     InstaShield_Main
    jsr     DropDash_Main
    jsr     SuperPeelOut_Main
    jsr     AirRecurl_Main
    
    ; Update Elemental Shields
    jsr     FireShield_Main
    jsr     BubbleShield_Main
    jsr     LightningShield_Main
    
    ; Update Playable Characters
    jsr     Knuckles_Main
    jsr     Amy_Main
    
    rts
