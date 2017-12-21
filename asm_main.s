SIM_SCGC5 EQU 0x40048038


PORTB_PCR0 EQU 0x4004A000; RED_W
PORTB_PCR1 EQU 0x4004A004; YELLOW_W
PORTB_PCR2 EQU 0x4004A008; GREEN_W

PORTC_PCR0 EQU 0x4004B000; RED_N
PORTC_PCR1 EQU 0x4004B004; YELLOW_N
PORTC_PCR2 EQU 0x4004B008; GREEN_N

GPIOB_PDDR EQU 0x400FF054; Direction of Data W
GPIOB_PSOR EQU 0x400FF044; Set Bits W
GPIOB_PCOR EQU 0x400FF048; Clear Bits W

GPIOC_PSOR EQU 0x400FF084; Set BitsN
GPIOC_PCOR EQU 0x400FF088; Clear Bits N
GPIOC_PDDR EQU 0x400FF094; Direction of Data N

RED_MASK EQU 0x00000001 ; 2^0
YELLOW_MASK EQU 0x00000002 ; 2^1
GREEN_MASK EQU 0x00000004 ; 2^2

DELAY_CNT EQU 0x02DC6C00 ; 3 sec delay
DELAY_CNTY EQU 0x01E84800 ; 2 sec delay
	
	AREA asm_area, CODE, READONLY
	EXPORT  asm_main

asm_main  
	
	BL init_gpio
loop
	BL redon_W
	BL redon_N
	LDR r0,=DELAY_CNTY
	BL delay
	BL redoff_W
	
	BL greenon_W
	LDR r0,=DELAY_CNT
	BL delay
	
	BL greenoff_W
	BL yellowon_W
	LDR r0,=DELAY_CNTY
	BL delay
	BL yellowoff_W
	
	BL redon_W
	LDR r0,=DELAY_CNTY
	BL delay
	BL redoff_N
	BL greenon_N
	
	LDR r0,=DELAY_CNT
	BL delay
	BL greenoff_N
	BL yellowon_N
	LDR r0,=DELAY_CNTY
	BL delay
	BL yellowoff_N
	BL redon_N
	B loop
redon_W
	LDR r0,=GPIOB_PSOR
	LDR r1,[r0]
	LDR r2,=RED_MASK
	ORRS r1, r2
	STR r1,[r0]
	BX LR
redon_N
	LDR r0,=GPIOC_PSOR
	LDR r1,[r0]
	LDR r2,=RED_MASK
	ORRS r1, r2
	STR r1,[r0]
	BX LR
redoff_W
	LDR r0,=GPIOB_PCOR
	LDR r1,[r0]
	LDR r2,=RED_MASK
	ORRS r1, r2
	STR r1,[r0]
	BX LR
redoff_N
	LDR r0,=GPIOC_PCOR
	LDR r1,[r0]
	LDR r2,=RED_MASK
	ORRS r1, r2
	STR r1,[r0]
	BX LR
yellowon_W
	LDR r0,=GPIOB_PSOR
	LDR r1, [r0]
	LDR r2,=YELLOW_MASK
	ORRS r1,r2
	STR r1,[r0]
	BX LR
yellowon_N
	LDR r0,=GPIOC_PSOR
	LDR r1, [r0]
	LDR r2,=YELLOW_MASK
	ORRS r1,r2
	STR r1,[r0]
	BX LR
yellowoff_W
	LDR r0,=GPIOB_PCOR
	LDR r1,[r0]
	LDR r2,=YELLOW_MASK
	ORRS r1,r2
	STR r1,[r0]
	BX LR
yellowoff_N
	LDR r0,=GPIOC_PCOR
	LDR r1,[r0]
	LDR r2,=YELLOW_MASK
	ORRS r1,r2
	STR r1,[r0]
	BX LR
greenon_W
	LDR r0,=GPIOB_PSOR
	LDR r1,[r0]
	LDR r2,=GREEN_MASK
	ORRS r1,r2
	STR r1,[r0]
	BX LR
greenon_N
	LDR r0,=GPIOC_PSOR
	LDR r1,[r0]
	LDR r2,=GREEN_MASK
	ORRS r1,r2
	STR r1,[r0]
	BX LR
greenoff_W
	LDR r0,=GPIOB_PCOR
	LDR r1,[r0]
	LDR r2,=GREEN_MASK
	ORRS r1,r2
	STR r1,[r0]
	BX LR
greenoff_N
	LDR r0,=GPIOC_PCOR
	LDR r1,[r0]
	LDR r2,=GREEN_MASK
	ORRS r1,r2
	STR r1,[r0]
	BX LR
delay 
	SUBS r0, #1
	BNE delay
	BX LR
init_gpio

	
	LDR r0,=SIM_SCGC5 ; Turns on clock
	LDR r1,[r0]
	LDR r2,=0x00003E00
	ORRS r1,r2
	STR r1,[r0]
	
	
	LDR r0,=PORTB_PCR0 ; Output Red_W
	LDR r1,=0x00000100
	STR r1,[r0]
	
	LDR r0,=GPIOB_PDDR
	LDR r1,[r0]
	LDR r2,=RED_MASK
	ORRS r1,r2
	STR r1,[r0]
	
	LDR r0,=PORTB_PCR1 ; Output Yellow_W
	LDR r1,=0x00000100
	STR r1,[r0]
	
	LDR r0,=GPIOB_PDDR
	LDR r1,[r0]
	LDR r2,=YELLOW_MASK
	ORRS r1,r2
	STR r1,[r0]
	
	LDR r0,=PORTB_PCR2 ; Output Green_W
	LDR r1,=0x00000100
	STR r1,[r0]
	
	LDR r0,=GPIOB_PDDR 
	LDR r1,[r0]
	LDR r2,=GREEN_MASK
	ORRS r1,r2
	STR r1,[r0]
	
	LDR r0,=PORTC_PCR0 ; Output Red_N
	LDR r1,=0x00000100
	STR r1,[r0]
	
	LDR r0,=GPIOC_PDDR
	LDR r1,[r0]
	LDR r2,=RED_MASK
	ORRS r1,r2
	STR r1,[r0]

	LDR r0,=PORTC_PCR1 ; Output YELLOW_N
	LDR r1,=0x00000100
	STR r1,[r0]
	
	LDR r0,=GPIOC_PDDR
	LDR r1,[r0]
	LDR r2,=YELLOW_MASK
	ORRS r1,r2
	STR r1,[r0]
	
	LDR r0,=PORTC_PCR2 ; Output GREEN_N
	LDR r1,=0x00000100
	STR r1,[r0]
	
	LDR r0,=GPIOC_PDDR
	LDR r1,[r0]
	LDR r2,=GREEN_MASK
	ORRS r1,r2
	STR r1,[r0]
	
	BX LR
	
	END