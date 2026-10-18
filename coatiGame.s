.data
table: 
.asciz "....C..BC..BC..BC..B...."

tableFormat:
.byte 10
.ascii "+-----+-----------+-----------+-----------+-----------+"
.byte 10
.ascii "|     |     1     |     2     |     3     |     4     |"
.byte 10
.ascii "+=====+===========+===========+===========+===========+"
.byte 10
.ascii "|     |           |           |           |           |"
.byte 10
rowA:.ascii "|  A  |           |           |           |           |"
.byte 10
.ascii "|     |           |           |           |           |"
.byte 10
.ascii "+-----+-----------+-----------+-----------+-----------+"
.byte 10
.ascii "|     |           |           |           |           |"
.byte 10
rowB: .ascii "|  B  |           |           |           |           |"
.byte 10
.ascii "|     |           |           |           |           |"
.byte 10
.ascii "+-----+-----------+-----------+-----------+-----------+"
.byte 10
.ascii "|     |           |           |           |           |"
.byte 10
rowC:.ascii "|  C  |           |           |           |           |"
.byte 10
.ascii "|     |           |           |           |           |"
.byte 10
.ascii "+-----+-----------+-----------+-----------+-----------+"
.byte 10
.ascii "|     |           |           |           |           |"
.byte 10
rowD:.ascii "|  D  |           |           |           |           |"
.byte 10
.ascii "|     |           |           |           |           |"
.byte 10
.ascii "+-----+-----------+-----------+-----------+-----------+"
.byte 10
.ascii "|     |           |           |           |           |"
.byte 10
rowE:.ascii "|  E  |           |           |           |           |"
.byte 10
.ascii "|     |           |           |           |           |"
.byte 10
.ascii "+-----+-----------+-----------+-----------+-----------+"
.byte 10
.ascii "|     |           |           |           |           |"
.byte 10
rowF:.ascii "|  F  |           |           |           |           |"
.byte 10
.ascii "|     |           |           |           |           |"
.byte 10
.ascii "+-----+-----------+-----------+-----------+-----------+"
.byte 10
.byte 10
.zero 1

format: .asciz "%3s" # We will only and exactly read three characters so we use %3s for safety

invalidCoatiMessage: .byte 10
.ascii "The requested cell does not contain 'C', a coati. It is team Coati's turn "
.byte 10
.zero 1
invalidBeeMessage: .byte 10
.ascii "The requested cell does not contain 'B', a bee. It is team Bees' turn."
.byte 10
.zero 1
invalidMoveMessage: .byte 10
.ascii "This move is illegal because the target cell is occupied. Nice try!"
.byte 10
.zero 1
invalidRowMessage: .byte 10
.ascii "The first letter expects a row among [A, B, C, D, E, F]. Are you testing whether you can break it? Nice try!"
.byte 10
.zero 1
outOfBoundsMessage:
.byte 10
.ascii "This move goes out of the bounds of the table. Nice try!"
.byte 10
.zero 1
invalidCommandLetterMessage:
.byte 10
.ascii "The third letter of your prompt is not a valid command among [F, U, D]"
.byte 10
.zero 1
invalidColumnInputMessage:
.byte 10
.ascii "The column you provided is >4 which is illegal. Nice try!"
.byte 10
.zero 1
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

coatiWinMessage: .ascii "After a painstaking battle, despite numerous difficulties, the Coatis prevail. "
.byte 10
.ascii "Their Overlord perhaps had to demonstrate mastery of IEEE-754, "
.byte 10
.ascii "physical strength and strategic thinking, among other tests of Greatness. "
.byte 10
.ascii "For that we commend him. Congratulations, team Coati!"
.byte 10
.zero 1
beeWinMessage: .ascii "After a painstaking battle, despite numerous difficulties, the Bees prevail. "
.byte 10
.ascii "Their Overlord perhaps had to demonstrate mastery of IEEE-754, "
.byte 10
.ascii "physical strength and strategic thinking, among other tests of Greatness. "
.byte 10
.ascii "For that we commend him. Congratulations, team Bees!"
.byte 10
.zero 1

seed:
    .skip 4

RNTest:
    .asciz "state = %u, roll = %u\n"

fF1Format:
    .asciz "This turn's FEARDFORFIET: BETRAYAL \n\t The team leaders swap places to the enemies' side\n"
fF2Format:
    .asciz "This turn's FEARDFORFIET: FF2"
fF3Format:
    .asciz "This turn's FEARDFORFIET: FF3"
fF4Format:
    .asciz "This turn's FEARDFORFIET: FF4"

waitForEnter:
    .asciz " %c"
continuePrompt:
    .asciz "\nType y and press Enter to continue: "

comebackPrompt:
    .ascii "\nCOMEBACK CHALLENGE!\n"
    .ascii "The loser has a chance to steal the win if they manage to complete the Kingdom's Milenium Problem (without AI):\n"
    .ascii "Convert 8-bit two's complement 00010011 to BSSS-777,\n"
    .ascii "then multiply by 4 in that representation.\n"
    .ascii "Format: inverted sign, 8-bit exponent with Excess-69,\n"
    .ascii "10 bit mantissa and a hidden bit.\n"
    .asciz "Enter the final 19 bits without spaces: "


comebackAnswer:
    .asciz "1010010110011000000"

answerInputFormat:
    .asciz "%31s"
answerBuffer:
    .zero 32

defencePrompt:
    .ascii "\nBut to be fair, the winners have one last line of defense!\n"
    .ascii "Enter the correct answer to keep your title.\n"
    .asciz " 1+1=? "

defenceAnswer:
    .asciz "1" #the correct answer is 1 :)))))

.text
.globl main
main:
pushq %rbp
movq %rsp, %rbp

pushq %r12
pushq %r12 #push a random value for stack alignment. Just a second r12 to be sure.

movq $0, %r12 #r12 will store whose turn it is - 0 means coati, 1 means bees


#Another printing test for RNG
#call randomNumberGen
#movq %rax, %rdx
#movl seed, %esi
#movq $RNTest, %rdi
#movq $0, %rax
#call printf


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

formatTable:
#move each true table cell, incremented by 1 to each formated, incremented by 12
    movb (%rdi), %al
    movb %al, rowA+12
    movb 1(%rdi), %al
    movb %al, rowA+24
    movb 2(%rdi), %al
    movb %al, rowA+36
    movb 3(%rdi), %al
    movb %al, rowA+48

    movb 4(%rdi), %al
    movb %al, rowB+12
    movb 5(%rdi), %al
    movb %al, rowB+24
    movb 6(%rdi), %al
    movb %al, rowB+36
    movb 7(%rdi), %al
    movb %al, rowB+48

    movb 8(%rdi), %al
    movb %al, rowC+12
    movb 9(%rdi), %al
    movb %al, rowC+24
    movb 10(%rdi), %al
    movb %al, rowC+36
    movb 11(%rdi), %al
    movb %al, rowC+48

    movb 12(%rdi), %al
    movb %al, rowD+12
    movb 13(%rdi), %al
    movb %al, rowD+24
    movb 14(%rdi), %al
    movb %al, rowD+36
    movb 15(%rdi), %al
    movb %al, rowD+48

    movb 16(%rdi), %al
    movb %al, rowE+12
    movb 17(%rdi), %al
    movb %al, rowE+24
    movb 18(%rdi), %al
    movb %al, rowE+36
    movb 19(%rdi), %al
    movb %al, rowE+48

    movb 20(%rdi), %al
    movb %al, rowF+12
    movb 21(%rdi), %al
    movb %al, rowF+24
    movb 22(%rdi), %al
    movb %al, rowF+36
    movb 23(%rdi), %al
    movb %al, rowF+48

    movq $generalFormat, %rdi
    movq $tableFormat, %rsi
    movq $0, %rax
    call printf
    jmp checkTurn

gameInputLoop:
    #print the current table
    movq $table, %rdi #provide the working table as an argument to the formatTable subroutine
    jmp formatTable

    checkTurn:
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
    jg outOfBoundsError
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
    pushq %rax #saving the the value of %rax and keeping stack aligned
    pushq $67

    #generate forfiet
    call randomNumberGen #roll dice
    movq %rax, %rdi 
    call feardForfiets

    popq %rax
    popq %rax #restore the value of %rax


    winCheck:#check win condition - if the coati is in the last column, or rcx mod 4 = 3 call the coatiWin subroutine
    andq $3, %rax #preserve only the last 2 bits because they decide mod 4. Works cause 3=...011.
    cmpq $3, %rax # if they are still equal to 3, we are in the last row
    je provisionalWinner #go to comeback

    movq $1, %r12 #next time it will be the Bees' turn

    jmp gameInputLoop

    coatiWin:
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
    cmpb $'B', table(%rcx) #Check if the requested cell indeed has a bee
    jne invalidBee

    movq %rcx, %rax #let rax store the address of the input cell
    decq %rax #after DECREMENT this time, rax is now the cell forward from rcx. We know we don't get column overflow because of the win condition.

    cmpb $'F', %dl #check if the command is F, forward
    je beeForward

    cmpb $'D', %dl #check if the command is D, forward and down
    je beeDown

    cmpb $'U', %dl #check if the command is U, forward and up
    je beeUp

    jmp invalidCommand

    beeDown:
    addq $4, %rax #move the nextMove pointer down into the next row to prepare for a potential D move
    cmpq $23, %rax # check if this is outside the cell range
    jge outOfBoundsError
    jmp beeForward #recycle the forward code

    beeUp:
    cmpq $4, %rax
    jl outOfBoundsError #If rax is in the first row and you move up, this is an illegal move
    subq $4, %rax #move the nextMove pointer up into the above row to prepare the move
    jmp beeForward
    

    beeForward:
    cmpb $'.' , table(%rax) #check if the target cell is empty
    jne invalidForwardCellBee

    movb $'.' , table(%rcx) #delete the bee from its current cell
    movb $'B' , table(%rax) #place the Bee in the cell in front

    cmpb $'C' , table+1(%rax) #check the taking condition
    jne winCheckBee
    movb $'.' , table+1(%rax) #delete the enemy behind
    #TODO<---------------------------------------------------------------------------------------THIS IS THE EXECUTION OF TAKING. RANDOM NUMBER GENERATION JMP SHOULD HAPPEN HERE.

    pushq %rax #saving the the value of %rax and keeping stack aligned
    pushq $67

    #generate forfiet
    call randomNumberGen #roll dice
    movq %rax, %rdi 
    call feardForfiets

    popq %rax
    popq %rax #restore the value of %rax

    winCheckBee:#check win condition - if the bee is in the last column, or rax mod 4 = 0 call the coatiWin subroutine
    andq $3, %rax #preserve only the last 2 bits because they decide mod 4. Works cause 3=...011.
    cmpq $0, %rax # if they are still equal to 0, we are in the last row
    je provisionalWinner #go to comeback

    movq $0, %r12 #next time it will be the Coati's turn

    jmp gameInputLoop

    beeWin:
    #Win Message
    movq $errorFormat, %rdi #print a specific message. We recycle the errorFormat
    movq $beeWinMessage, %rsi
    movq $0, %rax
    call printf

    jmp epilogue

    invalidBee:
    movq $errorFormat, %rdi #print a specific error message
    movq $invalidBeeMessage, %rsi
    movq $0, %rax
    call printf

    jmp gameInputLoop

    invalidForwardCellBee:
    movq $errorFormat, %rdi #print a specific error message
    movq $invalidMoveMessage, %rsi
    movq $0, %rax
    call printf

    jmp gameInputLoop

randomNumberGen: #result returned in %rax
    pushq %rbp #prologue
    movq %rsp, %rbp

    #update seed
    movl seed, %eax #get the new seed from memory
    movq $1664525, %r8 #prepare for multiplication and addition with useful constants as suggested in
    mulq %r8
    addq $1013904223, %rax  # Linear congruential pseudorandom number generator.
                            # Parameters from:
                            # W. H. Press, S. A. Teukolsky, W. T. Vetterling, B. P. Flannery,
                            # Numerical Recipes in C: The Art of Scientific Computing,
                            # 2nd edition, Cambridge University Press, 1992,
                            # Section 7.1, p. 284 ("An Even Quicker Generator").
                            #
                            # State update: state = (1664525 * state + 1013904223) mod 2^32.
                            # Assembly implementation written by us.
    movl %eax, seed #store the last 32 bits of the updated seed equivalent to seed % 2^32

    #dice roll
    movq $0, %rdx #prepare for devision
    movq $100, %r8 #we mod by 100 and add 1 to get values 1-100
    divl %r8d
    addq $1, %rdx
    movq %rdx, %rax

    movq %rbp, %rsp #epilogue
    popq %rbp 
    ret

feardForfiets:
    pushq %rbp #prologue
    movq %rsp, %rbp

    fF1:#1-25
        cmpq $25, %rdi #check the result of the dice roll
        jg fF2

        movq $fF1Format, %rdi
        movq $0, %rax
        call printf

        #movq $waitForEnter, %rdi
        #subq $16, %rsp
        #leaq 8(%rbp), %rsi
        #movq $0, %rax
        #call scanf
        jmp fFend

    fF2:#26-50    
        cmpq $50, %rdi 
        jg fF3

        movq $fF2Format, %rdi
        movq $0, %rax
        call printf

        jmp fFend

    fF3:#51-75
        cmpq $75, %rdi 
        jg fF4

        movq $fF3Format, %rdi
        movq $0, %rax
        call printf

        jmp fFend

    fF4:#76-100
        movq $fF4Format, %rdi
        movq $0, %rax
        call printf

       jmp fFend

    fFend:
        subq $16, %rsp#space for the input character

        movq $continuePrompt, %rdi
        movq $0, %rax
        call printf

        movq $waitForEnter, %rdi
        leaq (%rsp), %rsi#destination inside allocated space
        movq $0, %rax
        call scanf

        movq %rbp, %rsp #epilogue
        popq %rbp 
        ret

provisionalWinner:
    #Print the final board:


    movq $generalFormat, %rdi #final challenge to the looser
    movq $comebackPrompt, %rsi
    movq $0, %rax
    call printf

    # Read the answer
    movq $answerInputFormat, %rdi
    movq $answerBuffer, %rsi
    movl $0, %eax
    call scanf

    cmpl $1, %eax
    jne finalWinner #make sure an imput was read else go to final winner
    
    movq $answerBuffer, %rdi #compare the answers
    movq $comebackAnswer, %rsi
    call strcmp

    cmpl $0, %eax #if RAX is 0 they are equal and the answer is correct
    jne finalWinner #if it's wrong current winner wins

    movq $generalFormat, %rdi
    movq $defencePrompt, %rsi
    movq $0, %rax
    call printf

    #Read and check the winner's answer
    movq $answerInputFormat, %rdi
    movq $answerBuffer, %rsi
    movq $0, %rax
    call scanf

    cmpl $1, %eax #
    jne defenceFailed

    movq $answerBuffer, %rdi
    movq $defenceAnswer, %rsi
    call strcmp

    cmpl $0, %eax             # Zero means the answer matches
    jne defenceFailed
    jmp finalWinner          # Correct: keep the win

defenceFailed:
    xorq $1, %r12            # Wrong: swap the winner
    jmp finalWinner


finalWinner:
    #check the value of r12 and jump to bee win or coati win 
    cmpq $0, %r12
    je coatiWin
    jmp beeWin


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
