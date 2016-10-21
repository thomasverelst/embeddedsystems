/*
 * "Hello World" example.
 *
 * This example prints 'Hello from Nios II' to the STDOUT stream. It runs on
 * the Nios II 'standard', 'full_featured', 'fast', and 'low_cost' example
 * designs. It runs with or without the MicroC/OS-II RTOS and requires a STDOUT
 * device in your system's hardware.
 * The memory footprint of this hosted application is ~69 kbytes by default
 * using the standard reference design.
 *
 * For a reduced footprint version of this template, and an explanation of how
 * to reduce the memory footprint for a given application, see the
 * "small_hello_world" template.
 *
 */

#include <inttypes.h>
#include <stdio.h>
#include "system.h"
#include "io.h"
#include "altera_avalon_pio_regs.h"

int main() {
//  printf("Hello from Nios II!\n");
//  uint32_t pio_data = IORD_ALTERA_AVALON_PIO_DATA(PIO_0_BASE);
//  return 0;
	uint8_t count = 0x01;
	int delay;
	printf("Hello from Nios II!\n");
	while (1) {
		IOWR_ALTERA_AVALON_PIO_DATA(PIO_0_BASE, count);
		delay = 0;
		while (delay < 2000000) {
			delay++;
		}
		count = count << 1;
		if(count == 0x0) count = 0x01;

	}
	return 0;
}
