      andi $0,$0,0
      andi $1,$1,0
      andi $2,$2,0
      addi $0,$0,7
      addi $1,$1,1
loop: addi $2,$2,1
      sll $1,$1,1
      bne $0,$2,loop
      andi$2,$2,0
      srl $1,$1,7
      j loop
