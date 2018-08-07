#define __SFR_OFFSET	0

#include "avr/io.h"

.global	TIMER0_OVF_vect

#define b0	r31
#define b1	r30
#define b2	r29
#define b3	r28
#define b4	r30
#define b5	r30
#define b6	r30
#define b7	r0

TIMER0_OVF_vect:
; Y: pointer to unsigned char residue[5][5]
; Z: pointer to unsigned int  val[5][5]
	out	GPIOR1, r0
	in	r0, SREG
	out	GPIOR2, r0
	out	ADMUX, r1
	eor	r1, r1
	out	USIDR, r2
	out	EEDR, r3
	out	EEARL, r4
	out	DT1B, r5
	out	DT1A, r6
	out	OCR0B, r7
	out	OCR0A, r28
	out	OCR1B, r29
	out	OCR1C, r30
	out	OCR1A, r31


	ld	r0, Z+
	ld	r2, Y
	add	r2, r0
	st	Y+, r2
	ld	r2, Z+
	adc	r2, r1
	
	ld	r0, Z+
	ld	r3, Y
	add	r3, r0
	st	Y+, r3
	ld	r3, Z+
	adc	r3, r1
	
	ld	r0, Z+
	ld	r4, Y
	add	r4, r0
	st	Y+, r4
	ld	r4, Z+
	adc	r4, r1
	
	ld	r0, Z+
	ld	r5, Y
	add	r5, r0
	st	Y+, r5
	ld	r5, Z+
	adc	r5, r1
	
	ld	r0, Z+
	ld	r6, Y
	add	r6, r0
	st	Y+, r6
	ld	r6, Z+
	adc	r6, r1

	clr	b7		; Calculate bit 7
	lsl	r6
	rol	b7
	lsl	r5
	rol	b7
	lsl	r4
	rol	b7
	lsl	r3
	rol	b7
	lsl	r2
	rol	b7

	clr	b6		; Calculate bit 6
	lsl	r6
	rol	b6
	lsl	r5
	rol	b6
	lsl	r4
	rol	b6
	lsl	r3
	rol	b6
	lsl	r2
	rol	b6
	out	GPIOR0, b6

	clr	b5		; Calculate bit 5
	lsl	r6
	rol	b5
	lsl	r5
	rol	b5
	lsl	r4
	rol	b5
	lsl	r3
	rol	b5
	lsl	r2
	rol	b5
	out	DDRB, b5	; 32 bit 5. Now we can reuse b5.

	clr	b4		; 31 Calculate bit 4
	lsl	r6		; 30
	rol	b4		; 29
	lsl	r5		; 28
	rol	b4		; 27
	lsl	r4		; 26
	rol	b4		; 25
	lsl	r3		; 24
	rol	b4		; 23
	lsl	r2		; 22
	rol	b4		; 21

	clr	b3		; 20 Calculate bit 3
	lsl	r6		; 19
	rol	b3		; 18
	lsl	r5		; 17
	rol	b3		; 16
	lsl	r4		; 15
	rol	b3		; 14
	lsl	r3		; 13
	rol	b3		; 12
	lsl	r2		; 11
	rol	b3		; 10

	clr	b2		; 9 Calculate bit 2
	lsl	r6		; 8
	rol	b2		; 7
	lsl	r5		; 6
	rol	b2		; 5
	lsl	r4		; 4
	rol	b2		; 3
	lsl	r3		; 2
	rol	b2		; 1
	out	DDRB, b4	; 16 bit 4. Now we can reuse b4
	lsl	r2		; 15
	rol	b2		; 14

	clr	b1		; 13 Calculate bit 1
	lsl	r6		; 12
	rol	b1		; 11
	lsl	r5		; 10
	rol	b1		; 9
	lsl	r4		; 8
	rol	b1		; 7
	lsl	r3		; 6
	rol	b1		; 5
	
	lsl	r2		; 4
	rol	b1		; 3
	
	clr	b0		; 2 Calculate bit 0
	lsl	r6		; 1
	out	DDRB, b3	; 8 bit 3.
	rol	b0		; 7
	lsl	r5		; 6
	rol	b0		; 5
	lsl	r4		; 4
	rol	b0		; 3
	lsl	r3		; 2
	rol	b0		; 1
	out	DDRB, b2	; 4 bit 2
	lsl	r2		; 3
	rol	b0		; 2
	nop			; 1
	out	DDRB, b1	; 2 bit 1
	nop			; 1
	out	DDRB, b0	; 1 bit 0
	out	DDRB, b7	; 128 start bit 7. It will finish after the next interrupt
	
	
	nop
	sbi	DDRB,5
	ldi	r24, 5
	ldi	r24, lo8(325)
	nop
	reti
	
