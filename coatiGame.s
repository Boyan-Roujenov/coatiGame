.data
table: 
.byte 10
.byte 10
.asciz "....C..BC..BC..BC..B...."
format: .asciz "%3s" # We will only and exactly read three characters so we use %3s for safety

invalidCoatiMessage: .byte 10
.asciz "The requested cell does not contain 'C', a coati. It is team Coati's turn "
.byte 10
invalidBeeMessage: .byte 10
.asciz "The requested cell does not contain 'B', a bee. It is team Bees' turn."
.byte 10
invalidMoveMessage: .byte 10
.asciz "This move is illegal because the target cell is occupied. Nice try!"
.byte 10
invalidRowMessage: .byte 10
.asciz "The first letter expects a row among [A, B, C, D, E, F]. Are you testing whether you can break it? Nice try!"
.byte 10
outOfBoundsMessage:
.byte 10
.asciz "This move goes out of the bounds of the table. Nice try!"
.byte 10
invalidCommandLetterMessage:
.byte 10
.asciz "The third letter of your prompt is not a valid command among [F, U, D]"
.byte 10
invalidColumnInputMessage:
.byte 10
.asciz "The column you provided is >4 which is illegal. Nice try!"
.byte 10
errorFormat: .asciz "%s"

generalFormat: .asciz "%s"
coatiPrompt: 
.byte 10
.byte 10
.byte 10
.ascii "-------------- TEAM C'S TURN ---------------"
.byte 10
.byte 10
.ascii "Coati Overlord, please enter your move in format:"
.byte 10
.byte 10
.ascii "            [row][column][F/U/D]"
.byte 10
.byte 10
.ascii "(e.g. B1F)"
.byte 10
.byte 10
.asciz "YOUR ATTACK: "
.byte 10
beePrompt: 
.byte 10
.byte 10
.byte 10
.ascii "-------------- TEAM B'S TURN ---------------"
.byte 10
.byte 10
.ascii "Bee Overlord, please enter your move in format:"
.byte 10
.byte 10
.ascii "            [row][column][F/U/D]"
.byte 10
.byte 10
.ascii "(e.g. B4F)"
.byte 10
.byte 10
.asciz "YOUR ATTACK: "
.byte 10

coatiWinMessage: .asciz "After a painstaking battle, despite numerous difficulties, the Coatis prevail. Their Overlord perhaps had to demonstrate mastery of IEEE-754, physical strength and strategic thinking, among other tests of Greatness. For that we commend him. Congratulations, team Coati!"
beeWinMessage: .asciz "After a painstaking battle, despite numerous difficulties, the Bees prevail. Their Overlord perhaps had to demonstrate mastery of IEEE-754, physical strength and strategic thinking, among other tests of Greatness. For that we commend him. Congratulations, team Bees!"

.text
.globl main
main:
pushq %rbp
movq %rsp, %rbp

pushq %r12
pushq %r12 #push a random value for stack alignment. Just a second r12 to be sure.

movq $0, %r12 #r12 will store whose turn it is - 0 means coati, 1 means bees

jmp gameInputLoop

#Below is a printing test
#movq $format, %rdi
#movq %rsp, %rsi
#movq $0, %rax
#call printf

epilogue:
popq %r12
popq %r12
movq %rbp, %rsp
popq %rbp
ret

gameInputLoop:
    #print the current table
    movq $generalFormat, %rdi
    movq $table, %rsi
    movq $0, %rax
    call printf

    cmpq $0, %r12 #check if it is a Coati turn in order to prompt
    je promptCoatis
    jmp promptBees

    scanMove:
    movq $0, %rax #arguments for scanf. A move might look like "A2F" meaning move the piece at A2 forward.
    subq $16, %rsp
    movq $format, %rdi
    movq %rsp, %rsi
    call scanf

    movq $0, %rdi
    movb (%rsp), %dil #row
    movq $0, %rsi
    movb 1(%rsp), %sil #column
    movq $0, %rdx
    movb 2(%rsp), %dl #command, e.g. F for forward

    addq $16, %rsp #restore rsp

    jmp parseCommand

parseCommand:
movq $0, %rcx # zero rcx in order to use it as a position counter in the array
    checkA: cmpq $'A', %rdi 
    jne checkB
    addq $0, %rcx #rows are 4 symbols apart
    jmp addColumn
    checkB: cmpq $'B', %rdi 
    jne checkC
    addq $4, %rcx #rows are 4 symbols apart
    jmp addColumn
    checkC: cmpq $'C', %rdi 
    jne checkD
    addq $8, %rcx #rows are 4 symbols apart
    jmp addColumn
    checkD: cmpq $'D', %rdi 
    jne checkE
    addq $12, %rcx #rows are 4 symbols apart
    jmp addColumn
    checkE: cmpq $'E', %rdi 
    jne checkF
    addq $16, %rcx #rows are 4 symbols apart
    jmp addColumn
    checkF: cmpq $'F', %rdi 
    jne wrongFirstLetter
    addq $20, %rcx #rows are 4 symbols apart
    jmp addColumn

    addColumn:
    subq $'1', %rsi #convert the column from ascii to number BUT subtracting one because of 0-base indexing
    cmpq $4, %rsi #check for wrong column input
    jg invalidColumnInput
    addq %rsi, %rcx #after adding the column to the array counter we have the precise location of the character in the array

    cmpq $0,%r12     #check if it is team coati's turn
    je coatiTurn
    jmp beeTurn


coatiTurn:
    cmpb $'C', table(%rcx) #Check if the requested cell indeed has a coati
    jne invalidCoati

    movq %rcx, %rax #let rax store the address of the input cell
    incq %rax #after increment, rax is now the cell forward from rcx. We know we don't get column overflow because of the win condition.

    cmpb $'F', %dl #check if the command is F, forward
    je coatiForward

    cmpb $'D', %dl #check if the command is D, forward and down
    je coatiDown

    cmpb $'U', %dl #check if the command is U, forward and up
    je coatiUp

    jmp invalidCommand

    coatiDown:
    addq $4, %rax #move the nextMove pointer down into the next row to prepare for a potential D move
    cmpq $23, %rax # check if this is outside the cell range
    jge outOfBoundsError
    jmp coatiForward #recycle the forward code

    coatiUp:
    cmpq $4, %rax
    jl outOfBoundsError #If rax is in the first row and you move up, this is an illegal move
    subq $4, %rax #move the nextMove pointer up into the above row to prepare the move
    jmp coatiForward
    

    coatiForward:
    cmpb $'.' , table(%rax) #check if the target cell is empty
    jne invalidForwardCell

    movb $'.' , table(%rcx) #delete the coati from its current cell
    movb $'C' , table(%rax) #place the Coati in the cell in front

    cmpb $'B' , table-1(%rax) #check the taking condition
    jne winCheck
    movb $'.' , table-1(%rax) #delete the enemy behind
    #TODO<---------------------------------------------------------------------------------------THIS IS THE EXECUTION OF TAKING. RANDOM NUMBER GENERATION JMP SHOULD HAPPEN HERE.

    winCheck:#check win condition - if the coati is in the last column, or rcx mod 4 = 3 call the coatiWin subroutine
    andq $3, %rax #preserve only the last 2 bits because they decide mod 4. Works cause 3=...011.
    cmpq $3, %rax # if they are still equal to 3, we are in the last row
    je coatiWin

    movq $1, %r12 #next time it will be the Bees' turn

    jmp gameInputLoop

    coatiWin:
    #Print the final board:

    #Win Message
    movq $errorFormat, %rdi #print a specific message. We recycle the errorFormat
    movq $coatiWinMessage, %rsi
    movq $0, %rax
    call printf

    jmp epilogue

    invalidCoati:
    movq $errorFormat, %rdi #print a specific error message
    movq $invalidCoatiMessage, %rsi
    movq $0, %rax
    call printf

    jmp gameInputLoop

    invalidForwardCell:
    movq $errorFormat, %rdi #print a specific error message
    movq $invalidMoveMessage, %rsi
    movq $0, %rax
    call printf

    jmp gameInputLoop

beeTurn:
movq $0, %r12 #for now we just test coatis
jmp gameInputLoop

promptCoatis:
movq $generalFormat, %rdi
movq $coatiPrompt, %rsi
movq $0, %rax
call printf
jmp scanMove

promptBees:
movq $generalFormat, %rdi
movq $beePrompt, %rsi
movq $0, %rax
call printf
jmp scanMove

wrongFirstLetter:
movq $errorFormat, %rdi
movq $invalidRowMessage, %rsi
movq $0, %rax
call printf
jmp gameInputLoop

outOfBoundsError:
movq $errorFormat, %rdi
movq $outOfBoundsMessage, %rsi
movq $0, %rax
call printf
jmp gameInputLoop

invalidCommand:
movq $errorFormat, %rdi
movq $invalidCommandLetterMessage, %rsi
movq $0, %rax
call printf
jmp gameInputLoop

invalidColumnInput:
movq $errorFormat, %rdi
movq $invalidColumnInputMessage, %rsi
movq $0, %rax
call printf
jmp gameInputLoop
