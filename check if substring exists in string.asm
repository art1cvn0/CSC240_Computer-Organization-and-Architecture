.model small
.stack 100h

.data
maximum_string_length EQU 1000
sublen equ 2

string DB maximum_string_length DUP(?)
substring DB sublen

False DB "Substring doesnt exist in the string. $"
True DB "Substring exists in the string. $"

.code
 
Start:
mov ax,@data
mov ds,ax   

;getting string
mov  ah,3fh                      
mov  bx,0                        
mov  cx,MAXIMUM_STRING_LENGTH    
mov  dx,OFFSET string
int  21h                         
mov  cx,ax                                                
push cx   

;getting substring
mov  ah,3fh                      
mov  bx,0                        
mov  dx,OFFSET substring  
int  21h                         
  

mov bx, offset string
mov si, offset substring
 
check:
   mov al,[bx]                     
   mov ah,[si] 
   cmp al,ah
   jz check2
   inc bx
   loop check
  
jmp nExist   

check2: 
inc bx
inc si
mov al,[bx]                     
mov ah,[si] 
cmp al,ah
jz exists
jnz mismatch

mismatch:
mov si, offset substring
mov ah,[si] 
jmp check

exists:
mov dx,offset True
mov ah,9
int 21h
jmp endprog

nExist:
mov dx,offset False
mov ah,9
int 21h
jmp endprog

 
endprog:
mov ah,4ch
int 21h
end Start