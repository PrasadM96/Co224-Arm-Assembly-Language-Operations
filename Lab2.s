@ ARM Assembly - lab 2
@ 
@ Roshan Ragel - roshanr@pdn.ac.lk
@ Hasindu Gamaarachchi - hasindu@ce.pdn.ac.lk

	.text 	@ instruction memory
	.global main
main:
	@ stack handling, will discuss later
	@ push (store) lr to the stack
	sub sp, sp, #4
	str lr, [sp, #0]

	@ load values
	mov r0, #10
	mov r1, #5 @j
	mov r2, #7
	mov r3, #-8

	
	@ Write YOUR CODE HERE to perform the following task.
	
	@	Sum = 0;
	@	for (i=0;i<10;i++){
	@			for(j=5;j<15;j++){
	@				if(i+j<10) sum+=i*2
	@				else sum+=(i&j);	
	@			}	
	@	} 
	@ Put final sum to r5


	@ ---------------------
	mov r0,#0
	mov r5,#0
	mov r8,#2
loop1: cmp r0,#10
	   bge exit
loop2: 
		cmp r1,#15
		
		bge loop1End
		
		add r3,r0,r1					@ i+j
		
	    cmp r3,#10
	    blt if                    	@i+j<10
	    bge else						@i+j>=10
	  						
if:     mul r6,r0,r8	@i*2
		add r5,r5,r6
		b temp
		
else:  and r7,r0,r1
		add r5,r5,r7
		b temp
			
temp: 
 	    add r1,r1,#1				@ iterate j by 1
	 	b loop2
loop1End:  add r0,r0,#1                @ iterate i by 1
			mov r1,#5		
			b loop1
	
	
	@ ---------------------
	
	
exit:	@ load aguments and print
	ldr r0, =format
	mov r1, r5
	bl printf

	@ stack handling (pop lr from the stack) and return
	ldr lr, [sp, #0]
	add sp, sp, #4
	mov pc, lr

	.data	@ data memory
format: .asciz "The Answer is %d (Expect 300 if correct)\n"

