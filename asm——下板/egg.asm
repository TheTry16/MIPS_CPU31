.text
main:
    sll $zero,$zero,0
    addi $s1,$zero,0x1    # L=1
    addi $s2,$zero,0x64  # R=100
    addi $s3,$zero,0x31   # value=49
    addi $s4,$zero,0    # break_time=0
    addi $s5,$zero,0    # trial_time=0
    addi $s6,$zero,0    # last_break=0
    addi $t5,$zero,1    # 临时变量，值为1
loop:
    sltu $t3,$s2,$s1    # $t3 = (right < left)
    bne $zero, $t3, loop_end  # 如果 right < left 则跳出循环
    add $s7,$s1,$s2     # mid = L + R
    sra $s7,$s7,1       # mid = mid / 2
    addi $s5,$s5,1      # trial_time++
    sltu $t1,$s3,$s7    # $t1 = (value < mid)
    beq $zero,$t1,not_equal  # 不相等 mid > value 跳转
    addi $s4,$s4,1      # break_time++
    sub $s2,$s7,$t5     # R = mid - 1
    addi $s6,$zero,1    # last_break = 1
    j loop
not_equal:
    addi $s1,$s7,1      # L = mid + 1
    addi $s6,$zero,0    # last_break = 0
    j loop
loop_end:
    addi $t2,$s4,0      # eggs = break_time
    bne $zero,$s6,not_break  
    addi $t2,$t2,1      # eggs = eggs + 1
not_break:
    j not_break
    # 100层，耐摔49，
    # 最终的结果 trial_time $s5
    # 最终的结果 eggs $t2
    # 最终的结果 last_break $s6
