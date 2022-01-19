INCLUDE Irvine32.inc

.data
Welcome BYTE "Welcome To FBL", 0
Welcome2 BYTE "Welcome to Bills' Portal ", 0
P_W BYTE "Please wait....", 0

;Pin is 1234
Enter_Pin BYTE "Enter PIN: ", 0
Err BYTE "Wrong PIN", 0
Err2 BYTE "Invalid Choice...", 0
Balance DWORD 69420d
Inv BYTE "Insufficient Balance...", 0
Msg1 BYTE "Remaining Balance: ", 0
Msg2 BYTE "Enter Amount to withdraw: ", 0
Msg3 BYTE "Enter Amount to deposit: ", 0
Msg4 BYTE "Enter Account Number: ", 0
Msg5 BYTE "Enter Amount: ", 0
Msg6 BYTE "Amount Paid...", 0

S1 BYTE "1. Check Balance", 0
S2 BYTE "2. Withdraw Cash", 0
S3 BYTE "3. Deposit Cash", 0
S4 BYTE "4. Pay Utility Bills", 0

U1 BYTE "1. Gas Bill", 0
U2 BYTE "2. Electric Bill", 0
U3 BYTE "3. Water Tax", 0
U4 BYTE "4. ISP Bill", 0

Cont_Msg BYTE "Continue Transaction?", 0
Cont_Title BYTE "FBL", 0

.code 
main PROC

	call Clear_Reg

	mov dh, 13
	mov dl, 46
	call Gotoxy
	mov EDX, offset Welcome
	call WriteString
	mov dh, 14
	mov dl, 46
	call Gotoxy
	mov EDX, offset P_W
	call WriteString
	mov EAX, 2000
	call Delay

	call clrscr

	mov EDX, offset Enter_Pin
	call WriteString
	call ReadDec

	cmp EAX, 1234
	JE MainMenu

	mov EDX, offset Err
	call WriteString
	exit

	MainMenu:
		call Menu

main endp

Menu PROC
	
	Main_Menu:
		
		call clrscr

		mov EDX, offset S1
		call WriteString
		call crlf
		mov EDX, offset S2
		call WriteString
		call crlf
		mov EDX, offset S3
		call WriteString
		call crlf
		mov EDX, offset S4
		call WriteString
		call crlf
		call ReadDec

		cmp EAX, 1
		JE Bal
		cmp EAX, 2
		JE With
		cmp EAX, 3
		JE Dep
		cmp EAX, 4
		JE Bills
		mov EDX, offset Err2
		call WriteString
		exit

		Bal:
			
			call crlf
			mov EAX, Balance
			mov EDX, offset Msg1
			call WriteString
			call WriteDec
			call Cont

		With:
				
			call clrscr
			call Clear_Reg
			
			mov EDX, offset Msg2
			call WriteString
			call ReadDec
			mov ECX, Balance
			
			cmp ECX, EAX
			JL Invalid

			SUB ECX, EAX
			mov Balance, ECX

			jmp Bal

			call Cont

		Dep:
				
			call clrscr
			call Clear_Reg
			
			mov EDX, offset Msg3
			call WriteString
			call ReadDec

			mov ECX, Balance
			ADD EAX, ECX
			mov Balance, EAX			

			jmp Bal

			call Cont

		Bills:
				
			call clrscr
			call Clear_Reg

			call crlf
			mov EDX, offset U1
			call WriteString
			call crlf
			mov EDX, offset U2
			call WriteString
			call crlf
			mov EDX, offset U3
			call WriteString
			call crlf
			mov EDX, offset U4
			call WriteString
			call ReadDec
			
			cmp EAX, 1
			JE SG
			cmp EAX, 2
			JE KE
			cmp EAX, 3
			JE KWSB
			cmp EAX, 4
			JE PTCL
			mov EDX, offset Err2
			call WriteString
			exit

			SG:

				mov EDX, offset Msg4
				call WriteString
				call ReadDec
				call crlf

				mov EDX, offset Welcome2
				call WriteString
				call WriteDec
				call crlf

				mov EDX, offset Msg5
				call WriteString
				call ReadDec
				
				mov ECX, Balance
				cmp ECX, EAX
				JL Invalid

				SUB ECX, EAX
				mov Balance, ECX

				mov EDX, offset Msg6
				call WriteString

				jmp Bal

				call Cont
				
			KE:		

				mov EDX, offset Msg4
				call WriteString
				call ReadDec
				call crlf

				mov EDX, offset Welcome2
				call WriteString
				call WriteDec
				call crlf

				mov EDX, offset Msg5
				call WriteString
				call ReadDec
				
				mov ECX, Balance
				cmp ECX, EAX
				JL Invalid

				SUB ECX, EAX
				mov Balance, ECX

				mov EDX, offset Msg6
				call WriteString

				jmp Bal

				call Cont

			KWSB:			

				mov EDX, offset Msg4
				call WriteString
				call ReadDec
				call crlf

				mov EDX, offset Welcome2
				call WriteString
				call WriteDec
				call crlf

				mov EDX, offset Msg5
				call WriteString
				call ReadDec
				
				mov ECX, Balance
				cmp ECX, EAX
				JL Invalid

				SUB ECX, EAX
				mov Balance, ECX

				mov EDX, offset Msg6
				call WriteString

				jmp Bal

				call Cont

			PTCL:

				mov EDX, offset Msg4
				call WriteString
				call ReadDec
				call crlf

				mov EDX, offset Welcome2
				call WriteString
				call WriteDec
				call crlf

				mov EDX, offset Msg5
				call WriteString
				call ReadDec
				
				mov ECX, Balance
				cmp ECX, EAX
				JL Invalid

				SUB ECX, EAX
				mov Balance, ECX

				mov EDX, offset Msg6
				call WriteString

				jmp Bal

				call Cont
		
		Invalid: 
			mov EDX, offset Inv
			call WriteString
			exit

Menu ENDP

Clear_Reg PROC

	mov EAX, 0
	mov EBX, 0
	mov EDX, 0
	mov ECX, 0
	mov EDX, 0
	ret

Clear_Reg ENDP

Cont PROC

	mov EBX, offset Cont_Title
	mov EDX, offset Cont_Msg
	call MsgBoxAsk
	cmp EAX, 6
	JNE Exitt
	call Menu

	Exitt:
		exit

Cont ENDP

end main