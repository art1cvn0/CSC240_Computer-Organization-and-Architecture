.model small
.stack 
.data
maximum_string_length EQU 1000
string1 DB maximum_string_length DUP(?)
string2 DB maximum_string_length DUP(?)
notIdentical DB 'The two strings are not identical$'
identical DB 'The two strings are identical$'

.code

Start:
mov ax,@data
mov ds,ax    

;getting string1
mov  ah,3fh                      
mov  bx,0                        
mov  cx,MAXIMUM_STRING_LENGTH    
mov  dx,OFFSET string1  
int  21h                         
mov  cx,ax                                                
push cx         
  
;getting string2
mov  ah,3fh                      
mov  bx,0                        
mov  cx,MAXIMUM_STRING_LENGTH    
mov  dx,OFFSET string2  
int  21h                         
mov  cx,ax                                                
push cx 

lenNotEqual:
    pop bx
    pop cx
    cmp bx,cx
    jnz nIdentical

mov bx, offset string1
mov si, offset string2

check:
   mov  al,[bx]                     
   mov  ah,[si]    
   cmp al,ah
   jnz nIdentical   
   inc  bx                          
   inc  si                          
   loop check               


isIdentical:
mov dx,offset identical
mov ah,9
int 21h
mov ah,4ch
int 21h 

nIdentical:
mov dx,offset notIdentical
mov ah,9
int 21h
mov ah,4ch
int 21h

             
end Start