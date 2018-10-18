/*
===============================================================================
 Name        : main.c
 Author      : $(author)
 Version     :
 Copyright   : $(copyright)
 Description : main definition
===============================================================================
*/

#if defined (__USE_LPCOPEN)
#if defined(NO_BOARD_LIB)
#include "chip.h"
#else
#include "board.h"
#endif
#endif

#include <cr_section_macros.h>

// TODO: insert other include files here

// TODO: insert other definitions and declarations here
#define TICKRATE_HZ (10)	/* 10 ticks per second */

/**
 * @brief	Handle interrupt from SysTick timer
 * @return	Nothing
 */
extern "C" {
	void SysTick_Handler(void)
	{
		Chip_GPIO_SetPinToggle(LPC_GPIO_PORT, 0, 12);
	}
}

int main(void) {

#if defined (__USE_LPCOPEN)
    // Read clock settings and update SystemCoreClock variable
    SystemCoreClockUpdate();
#if !defined(NO_BOARD_LIB)
    // Set up and initialize all required blocks and
    // functions related to the board hardware
    Board_Init();
    // Set the LED to the state of "On"
    Board_LED_Set(0, true);
#endif
#endif

	/* Initialize GPIO */
	Chip_GPIO_Init(LPC_GPIO_PORT);
	Chip_GPIO_SetPinDIROutput(LPC_GPIO_PORT, 0, 12);
	Chip_GPIO_SetPinState(LPC_GPIO_PORT, 0, 12, true);
	Chip_GPIO_SetPinDIROutput(LPC_GPIO_PORT, 0, 16);
	Chip_GPIO_SetPinState(LPC_GPIO_PORT, 0, 16, true);
	Chip_GPIO_SetPinDIROutput(LPC_GPIO_PORT, 0, 27);
	Chip_GPIO_SetPinState(LPC_GPIO_PORT, 0, 27, true);


	/* Enable SysTick Timer */
	SysTick_Config(SystemCoreClock / TICKRATE_HZ);

	/* Loop forever */
	while (1) {
		__WFI();
	}

    return 0 ;
}
