BR main 
welcome:.ascii" You have activated the guessing robot.\n Now think of a number from 1-1000 in your head and I will guess it.\n Enter 1 if my guess is higher than your number;\n Enther -1 if my guess is lower than your number;\n Enter 0 is my guess is correct. \n Game starting:\n\x00"
att:.ascii"Is your number \x00"
ques:.ascii"?\x00"
endl:.ascii"\n\x00"
ans:.ascii"Your number is: \x00"
inva:.ascii"Invalid guess, check syntax\n\x00"
times:.ascii"I made \x00"
timeend:.ascii" guess(es) to be corrected!\n\x00"

count: .equate 8
guess: .equate 0
scope: .equate 4
out: .equate 6
Logic:   subsp 2, i 
         ldwa 1, i ;initialize the guess attempt
         stwa count, s
loop:    stro att, d ;Asking if Out has the right value
         deco out, sf
         stro ques, d
         stro endl, d
         deci guess, s ;Player judge
         ldwa guess, s
         cpwa 0, i
         breq end ;Correct return
         cpwa -1, i 
         breq low ;needs lower guess
         cpwa 1, i 
         breq high ;needs higher guess
         stro inva, d ;invalid guess (other than 1, 0, and -1)
         br loop
high:    ldwa out, sf ;load current guess
         adda scope, sf ;add the scope search to it
         stwa out, sf ;update the guess
         ldwa scope, sf
         cpwa 1, i
         breq skip ;check if scope is 1 
         ldwa scope, sf ;update the scope (halve it)
         asra
         stwa scope, sf
skip:    ldwa count, s ;increase guess attempts
         adda 1, i
         stwa count, s
         br loop
low:     ldwa out, sf ;Same principal with high but subtract the scope from the Current Guess
         suba scope, sf
         stwa out, sf
         ldwa scope, sf
         cpwa 1, i
         breq skip ;check if scope is 1 
         ldwa scope, sf
         asra
         stwa scope, sf
         ldwa count, s ;increase guess attempts
         adda 1, i
         stwa count, s
         br loop
end:     addsp 2, i ;Correct Guess 
         ret




cusea: .equate 2 ;Current Guess (500)
scopes:.equate 0 ;Scope Search (250)
c: .word 0
main:    subsp 4, i
         stro welcome, d
         ldwa 500, i ;
         stwa cusea, s
         ldwa 250, i
         stwa scopes, s ;initialize values
         movspa
         adda cusea, i
         stwa -4, s 
         movspa
         adda scopes, i
         stwa -6, s; Push parameters (CurrentGuess, Scopes)
         subsp 6, i
         call Logic ;Call logic function
         addsp 6, i
         stro ans, d
         deco cusea, s;Answer the guess
         stro endl, d
         stro times,d ;Number of guesses
         deco -2, s
         stro timeend, d
         addsp 4, i
         stop
.end

; The program take guess
; user judge
; Author: Bao Le (PCMakia)