[org 0x0100]



	jmp start


    top1: 	dw 5             ;Starting Row
    bottom1: dw 10		     ;Ending   Row
    left1:	dw 15			 ;Starting Column
    right1:	dw 30		     ;Ending Column

    top2: 	dw 10             ;Starting Row
    bottom2: dw 18		     ;Ending   Row
    left2:	dw 32			 ;Starting Column
    right2:	dw 53		     ;Ending Column

    top3: 	dw 19             ;Starting Row
    bottom3: dw 24		     ;Ending   Row
    left3:	dw 6			 ;Starting Column
    right3:	dw 32		     ;Ending Column


start:		
            call clrscr

            mov ax, 0x1 ; color
            push ax
			push word [top1]
			push word [bottom1]
			push word [left1]
			push word [right1]
			call drawrect
            call sleep
            call sleep
            call sleep
            call sleep
            call sleep
            call sleep
             call sleep
            call sleep
            call sleep
            call sleep
            call sleep
            call sleep
             call sleep
            call sleep
            call sleep
            call sleep
            call sleep
            call sleep

            mov ax, 0x2 ; color
            push ax
            push word [top2]
			push word [bottom2]
			push word [left2]
			push word [right2]
            
			call drawrect
            
            call sleep
            call sleep
            call sleep
            call sleep
            call sleep
            call sleep
            call sleep
            call sleep
            call sleep
            call sleep
            call sleep
            call sleep
            call sleep
            call sleep
            call sleep
            call sleep
            call sleep
            call sleep
            
            mov ax, 0x4 ; color
            push ax
        	push word [top3]
			push word [bottom3]
			push word [left3]
			push word [right3]
            

			call drawrect



end:		mov ax, 0x4c00
			int 21h



sleep: 
    push cx
    mov cx, 0xFFFF
delay: 
    loop delay
    pop cx
    ret




clrscr:			mov ax, 0xb800
				mov es, ax

				xor di,di

				mov ax,0x0720
				mov cx,2000

				cld
				rep stosw
			
				ret


drawrect:		
                push bp
				mov  bp, sp
				pusha


				; bp + 4  =  right
				; bp + 6  =  left
				; bp + 8  =  bottom
				; bp + 10 =  top


				;Calculating the top left position of the rectangle

				mov al, 80
				mul byte [bp + 10] 
				add ax,  [bp + 6]		 
				shl ax, 1
				mov di, ax

				push di					;Saving for later use


				mov ah, [bp+12] 			;Storing the attribute


				;Calculating the width of the rectangle

				mov cx, [bp + 4]
				sub cx, [bp + 6]

				push cx 				;Saving for later use

				mov al, '-'

loop1:			
                rep stosw
				pop bx

				pop di

				push bx

				dec bx	
				shl bx, 1

				add di, 160


				;Calculating the height of the rectangle

				mov cx, [bp + 8]
				sub cx, [bp + 10] 

				sub cx, 2 				;Excluding the top and bottom row
				
				mov al, '|' 

loop2:			
                mov si, di
				mov word [es:si], ax

				add si, bx

				mov word [es:si], ax

				sub si, bx

				add di, 160

				loop loop2


				pop cx

				mov al, '-'

loop3:			
                rep stosw



return:			popa
				pop bp
				ret 8