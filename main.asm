;assignment 3
INCLUDE Irvine32.inc
.data
stringSize = 80d
stringInput BYTE stringSize+1 DUP (?)
comparisonHex BYTE 'h'
hexDigits BYTE "0123456789ABCDEFabcdef"
hexSize = 22d
count dword ?
noH BYTE "There is no h at the end of the number"
isHex BYTE "Congrats, the number you entered is in the correct format"
notHex BYTE "This entry is not in the correct format"

.code
main PROC
StateA:                        ;check if number is hex
    call getString            ;calls function to get the string from a user
    call checkHex            ;move the last character into the al
main ENDP

;======================================================================;
;= Runs through the function to determine if each char is a hex digit =;
;=                                                                      =;
;======================================================================;
checkHex Proc
    
    mov esi, 0                    ;set string pointer to zero
    mov edi, 0                    ;set string pointer to zero    
    mov ecx, sizeof stringInput
    loop1:
    mov count, ecx      ;save outer loop size
    mov ecx, hexSize    ;set inner loop size
    mov ah, stringInput[edi]
		InnerLoop:
			mov al, hexDigits[esi]        
			.IF al == ah
			inc esi 
			.ELSEIF ah == 'h'
			call stateC
			.ENDIF      
        loop InnerLoop
        mov ecx,count
        inc edi
    loop Loop1
	call stateB          
    
ret
checkHex ENDP



;=====================================================================;
;= Gets a string from the user                                       =;
;=                                                                   =;
;=====================================================================;
getString Proc
    mov edx, OFFSET StringInput
    mov ecx,stringSize
    call ReadString
ret
getString ENDP

;=====================================================================;
;= If there is no H at the end of the number jump here				 =;
;=                                                                   =;
;=====================================================================;    
StateB Proc
	mov edx, OFFSET noH
	call WriteString
    exit  
StateB ENDP
;=====================================================================;
;=	This is a hex number											 =;
;=																	 =;
;=====================================================================;
StateC Proc
	mov edx, OFFSET isHex
	call WriteString
	exit
StateC ENDP
;=====================================================================;
;= Not a hex number													 =;
;=																	 =;
;=====================================================================;
StateD Proc
	mov edx, OFFSET notHex
	call WriteString
	exit
StateD ENDP

END main

