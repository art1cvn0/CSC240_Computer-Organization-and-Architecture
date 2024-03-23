;Write a TASM program to find the second largest number in any given list of positive numbers (sentinel 0)
;Program explanation:
;1) Finding LArgest number
;2) Finding the differences between the largest number and other numbers in the array
;3) Whichever number has the smallest difference greater than 0 => second largest number
; Ex: Array: 10,20,40,50,0
; Largest Number = 50
; 50-10 = 40  ;50-20=30; 50-40=10;  Therefore, 40 is the second largest number since 10<30<40

.model small
.stack 
.data
SLN DB 'Second largest number:$'
SecLargestNum DW ' $',' $' 
Numbers DW 14,30,32,86,89,52,0       ;0 is the sentinel
largest DW 0
seclargest DW 0
.code

Start:
mov ax,@data
mov ds,ax
cld
mov si,offset Numbers
mov bx,0

;Part 1:

next:
lodsw
or ax,ax
jz Part2
cmp ax,bx 
jge next2
jmp next

next2:
mov bx,ax
jmp next
; => We've found the largest number
;--------------------------------
Part2:
cld
mov [largest],bx 
mov dx,bx
mov si,offset Numbers

nextpt2:
lodsw
or ax,ax
jz exit
mov bx,[largest]
sub bx,ax ;ex 89-14  => bx=75
jnz comp
jz nextpt2

comp: 
cmp bx,dx   ;75 with 89    
jl next2pt2
jmp nextpt2

next2pt2:
mov dx,bx
mov [seclargest], ax
jmp nextpt2

jmp exit
;--------------------------------

exit:
mov dx,offset SLN
mov ah,9
int 21h
mov ax,[seclargest]
aam
or ax,3030h
xchg ah,al
mov [SecLargestNum], ax
mov dx,offset SecLargestNum
mov ah,9
int 21h
mov ah,4ch
int 21h
end Start