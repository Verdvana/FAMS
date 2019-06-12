/*
 * system.h - SOPC Builder system and BSP software package information
 *
 * Machine generated for CPU 'nios2_gen2' in SOPC Builder design 'qsys_system'
 * SOPC Builder design path: ../../qsys_system.sopcinfo
 *
 * Generated: Tue Jun 11 20:58:13 CST 2019
 */

/*
 * DO NOT MODIFY THIS FILE
 *
 * Changing this file will have subtle consequences
 * which will almost certainly lead to a nonfunctioning
 * system. If you do modify this file, be aware that your
 * changes will be overwritten and lost when this file
 * is generated again.
 *
 * DO NOT MODIFY THIS FILE
 */

/*
 * License Agreement
 *
 * Copyright (c) 2008
 * Altera Corporation, San Jose, California, USA.
 * All rights reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 *
 * This agreement shall be governed in all respects by the laws of the State
 * of California and by the laws of the United States of America.
 */

#ifndef __SYSTEM_H_
#define __SYSTEM_H_

/* Include definitions from linker script generator */
#include "linker.h"


/*
 * CPU configuration
 *
 */

#define ALT_CPU_ARCHITECTURE "altera_nios2_gen2"
#define ALT_CPU_BIG_ENDIAN 0
#define ALT_CPU_BREAK_ADDR 0x00014820
#define ALT_CPU_CPU_ARCH_NIOS2_R1
#define ALT_CPU_CPU_FREQ 50000000u
#define ALT_CPU_CPU_ID_SIZE 1
#define ALT_CPU_CPU_ID_VALUE 0x00000000
#define ALT_CPU_CPU_IMPLEMENTATION "tiny"
#define ALT_CPU_DATA_ADDR_WIDTH 0x11
#define ALT_CPU_DCACHE_LINE_SIZE 0
#define ALT_CPU_DCACHE_LINE_SIZE_LOG2 0
#define ALT_CPU_DCACHE_SIZE 0
#define ALT_CPU_EXCEPTION_ADDR 0x00008020
#define ALT_CPU_FLASH_ACCELERATOR_LINES 0
#define ALT_CPU_FLASH_ACCELERATOR_LINE_SIZE 0
#define ALT_CPU_FLUSHDA_SUPPORTED
#define ALT_CPU_FREQ 50000000
#define ALT_CPU_HARDWARE_DIVIDE_PRESENT 0
#define ALT_CPU_HARDWARE_MULTIPLY_PRESENT 0
#define ALT_CPU_HARDWARE_MULX_PRESENT 0
#define ALT_CPU_HAS_DEBUG_CORE 1
#define ALT_CPU_HAS_DEBUG_STUB
#define ALT_CPU_HAS_ILLEGAL_INSTRUCTION_EXCEPTION
#define ALT_CPU_HAS_JMPI_INSTRUCTION
#define ALT_CPU_ICACHE_LINE_SIZE 0
#define ALT_CPU_ICACHE_LINE_SIZE_LOG2 0
#define ALT_CPU_ICACHE_SIZE 0
#define ALT_CPU_INST_ADDR_WIDTH 0x11
#define ALT_CPU_NAME "nios2_gen2"
#define ALT_CPU_OCI_VERSION 1
#define ALT_CPU_RESET_ADDR 0x00012000


/*
 * CPU configuration (with legacy prefix - don't use these anymore)
 *
 */

#define NIOS2_BIG_ENDIAN 0
#define NIOS2_BREAK_ADDR 0x00014820
#define NIOS2_CPU_ARCH_NIOS2_R1
#define NIOS2_CPU_FREQ 50000000u
#define NIOS2_CPU_ID_SIZE 1
#define NIOS2_CPU_ID_VALUE 0x00000000
#define NIOS2_CPU_IMPLEMENTATION "tiny"
#define NIOS2_DATA_ADDR_WIDTH 0x11
#define NIOS2_DCACHE_LINE_SIZE 0
#define NIOS2_DCACHE_LINE_SIZE_LOG2 0
#define NIOS2_DCACHE_SIZE 0
#define NIOS2_EXCEPTION_ADDR 0x00008020
#define NIOS2_FLASH_ACCELERATOR_LINES 0
#define NIOS2_FLASH_ACCELERATOR_LINE_SIZE 0
#define NIOS2_FLUSHDA_SUPPORTED
#define NIOS2_HARDWARE_DIVIDE_PRESENT 0
#define NIOS2_HARDWARE_MULTIPLY_PRESENT 0
#define NIOS2_HARDWARE_MULX_PRESENT 0
#define NIOS2_HAS_DEBUG_CORE 1
#define NIOS2_HAS_DEBUG_STUB
#define NIOS2_HAS_ILLEGAL_INSTRUCTION_EXCEPTION
#define NIOS2_HAS_JMPI_INSTRUCTION
#define NIOS2_ICACHE_LINE_SIZE 0
#define NIOS2_ICACHE_LINE_SIZE_LOG2 0
#define NIOS2_ICACHE_SIZE 0
#define NIOS2_INST_ADDR_WIDTH 0x11
#define NIOS2_OCI_VERSION 1
#define NIOS2_RESET_ADDR 0x00012000


/*
 * Define for each module class mastered by the CPU
 *
 */

#define __ALTERA_AVALON_JTAG_UART
#define __ALTERA_AVALON_ONCHIP_MEMORY2
#define __ALTERA_AVALON_PIO
#define __ALTERA_AVALON_SYSID_QSYS
#define __ALTERA_NIOS2_GEN2


/*
 * RAM configuration
 *
 */

#define ALT_MODULE_CLASS_RAM altera_avalon_onchip_memory2
#define RAM_ALLOW_IN_SYSTEM_MEMORY_CONTENT_EDITOR 0
#define RAM_ALLOW_MRAM_SIM_CONTENTS_ONLY_FILE 0
#define RAM_BASE 0x8000
#define RAM_CONTENTS_INFO ""
#define RAM_DUAL_PORT 0
#define RAM_GUI_RAM_BLOCK_TYPE "AUTO"
#define RAM_INIT_CONTENTS_FILE "qsys_system_RAM"
#define RAM_INIT_MEM_CONTENT 1
#define RAM_INSTANCE_ID "NONE"
#define RAM_IRQ -1
#define RAM_IRQ_INTERRUPT_CONTROLLER_ID -1
#define RAM_NAME "/dev/RAM"
#define RAM_NON_DEFAULT_INIT_FILE_ENABLED 1
#define RAM_RAM_BLOCK_TYPE "AUTO"
#define RAM_READ_DURING_WRITE_MODE "DONT_CARE"
#define RAM_SINGLE_CLOCK_OP 0
#define RAM_SIZE_MULTIPLE 1
#define RAM_SIZE_VALUE 20480
#define RAM_SPAN 20480
#define RAM_TYPE "altera_avalon_onchip_memory2"
#define RAM_WRITABLE 1


/*
 * ROM configuration
 *
 */

#define ALT_MODULE_CLASS_ROM altera_avalon_onchip_memory2
#define ROM_ALLOW_IN_SYSTEM_MEMORY_CONTENT_EDITOR 0
#define ROM_ALLOW_MRAM_SIM_CONTENTS_ONLY_FILE 0
#define ROM_BASE 0x12000
#define ROM_CONTENTS_INFO ""
#define ROM_DUAL_PORT 0
#define ROM_GUI_RAM_BLOCK_TYPE "AUTO"
#define ROM_INIT_CONTENTS_FILE "qsys_system_ROM"
#define ROM_INIT_MEM_CONTENT 1
#define ROM_INSTANCE_ID "NONE"
#define ROM_IRQ -1
#define ROM_IRQ_INTERRUPT_CONTROLLER_ID -1
#define ROM_NAME "/dev/ROM"
#define ROM_NON_DEFAULT_INIT_FILE_ENABLED 1
#define ROM_RAM_BLOCK_TYPE "AUTO"
#define ROM_READ_DURING_WRITE_MODE "DONT_CARE"
#define ROM_SINGLE_CLOCK_OP 0
#define ROM_SIZE_MULTIPLE 1
#define ROM_SIZE_VALUE 8192
#define ROM_SPAN 8192
#define ROM_TYPE "altera_avalon_onchip_memory2"
#define ROM_WRITABLE 0


/*
 * System configuration
 *
 */

#define ALT_DEVICE_FAMILY "Cyclone IV E"
#define ALT_ENHANCED_INTERRUPT_API_PRESENT
#define ALT_IRQ_BASE NULL
#define ALT_LOG_PORT "/dev/null"
#define ALT_LOG_PORT_BASE 0x0
#define ALT_LOG_PORT_DEV null
#define ALT_LOG_PORT_TYPE ""
#define ALT_NUM_EXTERNAL_INTERRUPT_CONTROLLERS 0
#define ALT_NUM_INTERNAL_INTERRUPT_CONTROLLERS 1
#define ALT_NUM_INTERRUPT_CONTROLLERS 1
#define ALT_STDERR "/dev/jtag_uart"
#define ALT_STDERR_BASE 0x15158
#define ALT_STDERR_DEV jtag_uart
#define ALT_STDERR_IS_JTAG_UART
#define ALT_STDERR_PRESENT
#define ALT_STDERR_TYPE "altera_avalon_jtag_uart"
#define ALT_STDIN "/dev/jtag_uart"
#define ALT_STDIN_BASE 0x15158
#define ALT_STDIN_DEV jtag_uart
#define ALT_STDIN_IS_JTAG_UART
#define ALT_STDIN_PRESENT
#define ALT_STDIN_TYPE "altera_avalon_jtag_uart"
#define ALT_STDOUT "/dev/jtag_uart"
#define ALT_STDOUT_BASE 0x15158
#define ALT_STDOUT_DEV jtag_uart
#define ALT_STDOUT_IS_JTAG_UART
#define ALT_STDOUT_PRESENT
#define ALT_STDOUT_TYPE "altera_avalon_jtag_uart"
#define ALT_SYSTEM_NAME "qsys_system"


/*
 * ain_ch0 configuration
 *
 */

#define AIN_CH0_BASE 0x150a0
#define AIN_CH0_BIT_CLEARING_EDGE_REGISTER 0
#define AIN_CH0_BIT_MODIFYING_OUTPUT_REGISTER 0
#define AIN_CH0_CAPTURE 0
#define AIN_CH0_DATA_WIDTH 12
#define AIN_CH0_DO_TEST_BENCH_WIRING 0
#define AIN_CH0_DRIVEN_SIM_VALUE 0
#define AIN_CH0_EDGE_TYPE "NONE"
#define AIN_CH0_FREQ 50000000
#define AIN_CH0_HAS_IN 1
#define AIN_CH0_HAS_OUT 0
#define AIN_CH0_HAS_TRI 0
#define AIN_CH0_IRQ -1
#define AIN_CH0_IRQ_INTERRUPT_CONTROLLER_ID -1
#define AIN_CH0_IRQ_TYPE "NONE"
#define AIN_CH0_NAME "/dev/ain_ch0"
#define AIN_CH0_RESET_VALUE 0
#define AIN_CH0_SPAN 16
#define AIN_CH0_TYPE "altera_avalon_pio"
#define ALT_MODULE_CLASS_ain_ch0 altera_avalon_pio


/*
 * ain_ch1 configuration
 *
 */

#define AIN_CH1_BASE 0x150b0
#define AIN_CH1_BIT_CLEARING_EDGE_REGISTER 0
#define AIN_CH1_BIT_MODIFYING_OUTPUT_REGISTER 0
#define AIN_CH1_CAPTURE 0
#define AIN_CH1_DATA_WIDTH 12
#define AIN_CH1_DO_TEST_BENCH_WIRING 0
#define AIN_CH1_DRIVEN_SIM_VALUE 0
#define AIN_CH1_EDGE_TYPE "NONE"
#define AIN_CH1_FREQ 50000000
#define AIN_CH1_HAS_IN 1
#define AIN_CH1_HAS_OUT 0
#define AIN_CH1_HAS_TRI 0
#define AIN_CH1_IRQ -1
#define AIN_CH1_IRQ_INTERRUPT_CONTROLLER_ID -1
#define AIN_CH1_IRQ_TYPE "NONE"
#define AIN_CH1_NAME "/dev/ain_ch1"
#define AIN_CH1_RESET_VALUE 0
#define AIN_CH1_SPAN 16
#define AIN_CH1_TYPE "altera_avalon_pio"
#define ALT_MODULE_CLASS_ain_ch1 altera_avalon_pio


/*
 * ain_ch2 configuration
 *
 */

#define AIN_CH2_BASE 0x150c0
#define AIN_CH2_BIT_CLEARING_EDGE_REGISTER 0
#define AIN_CH2_BIT_MODIFYING_OUTPUT_REGISTER 0
#define AIN_CH2_CAPTURE 0
#define AIN_CH2_DATA_WIDTH 12
#define AIN_CH2_DO_TEST_BENCH_WIRING 0
#define AIN_CH2_DRIVEN_SIM_VALUE 0
#define AIN_CH2_EDGE_TYPE "NONE"
#define AIN_CH2_FREQ 50000000
#define AIN_CH2_HAS_IN 1
#define AIN_CH2_HAS_OUT 0
#define AIN_CH2_HAS_TRI 0
#define AIN_CH2_IRQ -1
#define AIN_CH2_IRQ_INTERRUPT_CONTROLLER_ID -1
#define AIN_CH2_IRQ_TYPE "NONE"
#define AIN_CH2_NAME "/dev/ain_ch2"
#define AIN_CH2_RESET_VALUE 0
#define AIN_CH2_SPAN 16
#define AIN_CH2_TYPE "altera_avalon_pio"
#define ALT_MODULE_CLASS_ain_ch2 altera_avalon_pio


/*
 * ain_ch3 configuration
 *
 */

#define AIN_CH3_BASE 0x150d0
#define AIN_CH3_BIT_CLEARING_EDGE_REGISTER 0
#define AIN_CH3_BIT_MODIFYING_OUTPUT_REGISTER 0
#define AIN_CH3_CAPTURE 0
#define AIN_CH3_DATA_WIDTH 12
#define AIN_CH3_DO_TEST_BENCH_WIRING 0
#define AIN_CH3_DRIVEN_SIM_VALUE 0
#define AIN_CH3_EDGE_TYPE "NONE"
#define AIN_CH3_FREQ 50000000
#define AIN_CH3_HAS_IN 1
#define AIN_CH3_HAS_OUT 0
#define AIN_CH3_HAS_TRI 0
#define AIN_CH3_IRQ -1
#define AIN_CH3_IRQ_INTERRUPT_CONTROLLER_ID -1
#define AIN_CH3_IRQ_TYPE "NONE"
#define AIN_CH3_NAME "/dev/ain_ch3"
#define AIN_CH3_RESET_VALUE 0
#define AIN_CH3_SPAN 16
#define AIN_CH3_TYPE "altera_avalon_pio"
#define ALT_MODULE_CLASS_ain_ch3 altera_avalon_pio


/*
 * ain_ch4 configuration
 *
 */

#define AIN_CH4_BASE 0x150e0
#define AIN_CH4_BIT_CLEARING_EDGE_REGISTER 0
#define AIN_CH4_BIT_MODIFYING_OUTPUT_REGISTER 0
#define AIN_CH4_CAPTURE 0
#define AIN_CH4_DATA_WIDTH 12
#define AIN_CH4_DO_TEST_BENCH_WIRING 0
#define AIN_CH4_DRIVEN_SIM_VALUE 0
#define AIN_CH4_EDGE_TYPE "NONE"
#define AIN_CH4_FREQ 50000000
#define AIN_CH4_HAS_IN 1
#define AIN_CH4_HAS_OUT 0
#define AIN_CH4_HAS_TRI 0
#define AIN_CH4_IRQ -1
#define AIN_CH4_IRQ_INTERRUPT_CONTROLLER_ID -1
#define AIN_CH4_IRQ_TYPE "NONE"
#define AIN_CH4_NAME "/dev/ain_ch4"
#define AIN_CH4_RESET_VALUE 0
#define AIN_CH4_SPAN 16
#define AIN_CH4_TYPE "altera_avalon_pio"
#define ALT_MODULE_CLASS_ain_ch4 altera_avalon_pio


/*
 * end_o configuration
 *
 */

#define ALT_MODULE_CLASS_end_o altera_avalon_pio
#define END_O_BASE 0x15120
#define END_O_BIT_CLEARING_EDGE_REGISTER 0
#define END_O_BIT_MODIFYING_OUTPUT_REGISTER 0
#define END_O_CAPTURE 0
#define END_O_DATA_WIDTH 1
#define END_O_DO_TEST_BENCH_WIRING 0
#define END_O_DRIVEN_SIM_VALUE 0
#define END_O_EDGE_TYPE "NONE"
#define END_O_FREQ 50000000
#define END_O_HAS_IN 1
#define END_O_HAS_OUT 0
#define END_O_HAS_TRI 0
#define END_O_IRQ -1
#define END_O_IRQ_INTERRUPT_CONTROLLER_ID -1
#define END_O_IRQ_TYPE "NONE"
#define END_O_NAME "/dev/end_o"
#define END_O_RESET_VALUE 0
#define END_O_SPAN 16
#define END_O_TYPE "altera_avalon_pio"


/*
 * h2_one configuration
 *
 */

#define ALT_MODULE_CLASS_h2_one altera_avalon_pio
#define H2_ONE_BASE 0x15080
#define H2_ONE_BIT_CLEARING_EDGE_REGISTER 0
#define H2_ONE_BIT_MODIFYING_OUTPUT_REGISTER 0
#define H2_ONE_CAPTURE 0
#define H2_ONE_DATA_WIDTH 4
#define H2_ONE_DO_TEST_BENCH_WIRING 0
#define H2_ONE_DRIVEN_SIM_VALUE 0
#define H2_ONE_EDGE_TYPE "NONE"
#define H2_ONE_FREQ 50000000
#define H2_ONE_HAS_IN 0
#define H2_ONE_HAS_OUT 1
#define H2_ONE_HAS_TRI 0
#define H2_ONE_IRQ -1
#define H2_ONE_IRQ_INTERRUPT_CONTROLLER_ID -1
#define H2_ONE_IRQ_TYPE "NONE"
#define H2_ONE_NAME "/dev/h2_one"
#define H2_ONE_RESET_VALUE 0
#define H2_ONE_SPAN 16
#define H2_ONE_TYPE "altera_avalon_pio"


/*
 * h2_ten configuration
 *
 */

#define ALT_MODULE_CLASS_h2_ten altera_avalon_pio
#define H2_TEN_BASE 0x15090
#define H2_TEN_BIT_CLEARING_EDGE_REGISTER 0
#define H2_TEN_BIT_MODIFYING_OUTPUT_REGISTER 0
#define H2_TEN_CAPTURE 0
#define H2_TEN_DATA_WIDTH 4
#define H2_TEN_DO_TEST_BENCH_WIRING 0
#define H2_TEN_DRIVEN_SIM_VALUE 0
#define H2_TEN_EDGE_TYPE "NONE"
#define H2_TEN_FREQ 50000000
#define H2_TEN_HAS_IN 0
#define H2_TEN_HAS_OUT 1
#define H2_TEN_HAS_TRI 0
#define H2_TEN_IRQ -1
#define H2_TEN_IRQ_INTERRUPT_CONTROLLER_ID -1
#define H2_TEN_IRQ_TYPE "NONE"
#define H2_TEN_NAME "/dev/h2_ten"
#define H2_TEN_RESET_VALUE 0
#define H2_TEN_SPAN 16
#define H2_TEN_TYPE "altera_avalon_pio"


/*
 * hal configuration
 *
 */

#define ALT_INCLUDE_INSTRUCTION_RELATED_EXCEPTION_API
#define ALT_MAX_FD 32
#define ALT_SYS_CLK none
#define ALT_TIMESTAMP_CLK none


/*
 * harmful_one configuration
 *
 */

#define ALT_MODULE_CLASS_harmful_one altera_avalon_pio
#define HARMFUL_ONE_BASE 0x15020
#define HARMFUL_ONE_BIT_CLEARING_EDGE_REGISTER 0
#define HARMFUL_ONE_BIT_MODIFYING_OUTPUT_REGISTER 0
#define HARMFUL_ONE_CAPTURE 0
#define HARMFUL_ONE_DATA_WIDTH 4
#define HARMFUL_ONE_DO_TEST_BENCH_WIRING 0
#define HARMFUL_ONE_DRIVEN_SIM_VALUE 0
#define HARMFUL_ONE_EDGE_TYPE "NONE"
#define HARMFUL_ONE_FREQ 50000000
#define HARMFUL_ONE_HAS_IN 0
#define HARMFUL_ONE_HAS_OUT 1
#define HARMFUL_ONE_HAS_TRI 0
#define HARMFUL_ONE_IRQ -1
#define HARMFUL_ONE_IRQ_INTERRUPT_CONTROLLER_ID -1
#define HARMFUL_ONE_IRQ_TYPE "NONE"
#define HARMFUL_ONE_NAME "/dev/harmful_one"
#define HARMFUL_ONE_RESET_VALUE 0
#define HARMFUL_ONE_SPAN 16
#define HARMFUL_ONE_TYPE "altera_avalon_pio"


/*
 * harmful_ten configuration
 *
 */

#define ALT_MODULE_CLASS_harmful_ten altera_avalon_pio
#define HARMFUL_TEN_BASE 0x15030
#define HARMFUL_TEN_BIT_CLEARING_EDGE_REGISTER 0
#define HARMFUL_TEN_BIT_MODIFYING_OUTPUT_REGISTER 0
#define HARMFUL_TEN_CAPTURE 0
#define HARMFUL_TEN_DATA_WIDTH 4
#define HARMFUL_TEN_DO_TEST_BENCH_WIRING 0
#define HARMFUL_TEN_DRIVEN_SIM_VALUE 0
#define HARMFUL_TEN_EDGE_TYPE "NONE"
#define HARMFUL_TEN_FREQ 50000000
#define HARMFUL_TEN_HAS_IN 0
#define HARMFUL_TEN_HAS_OUT 1
#define HARMFUL_TEN_HAS_TRI 0
#define HARMFUL_TEN_IRQ -1
#define HARMFUL_TEN_IRQ_INTERRUPT_CONTROLLER_ID -1
#define HARMFUL_TEN_IRQ_TYPE "NONE"
#define HARMFUL_TEN_NAME "/dev/harmful_ten"
#define HARMFUL_TEN_RESET_VALUE 0
#define HARMFUL_TEN_SPAN 16
#define HARMFUL_TEN_TYPE "altera_avalon_pio"


/*
 * heart_rate_hun configuration
 *
 */

#define ALT_MODULE_CLASS_heart_rate_hun altera_avalon_pio
#define HEART_RATE_HUN_BASE 0x15110
#define HEART_RATE_HUN_BIT_CLEARING_EDGE_REGISTER 0
#define HEART_RATE_HUN_BIT_MODIFYING_OUTPUT_REGISTER 0
#define HEART_RATE_HUN_CAPTURE 0
#define HEART_RATE_HUN_DATA_WIDTH 4
#define HEART_RATE_HUN_DO_TEST_BENCH_WIRING 0
#define HEART_RATE_HUN_DRIVEN_SIM_VALUE 0
#define HEART_RATE_HUN_EDGE_TYPE "NONE"
#define HEART_RATE_HUN_FREQ 50000000
#define HEART_RATE_HUN_HAS_IN 0
#define HEART_RATE_HUN_HAS_OUT 1
#define HEART_RATE_HUN_HAS_TRI 0
#define HEART_RATE_HUN_IRQ -1
#define HEART_RATE_HUN_IRQ_INTERRUPT_CONTROLLER_ID -1
#define HEART_RATE_HUN_IRQ_TYPE "NONE"
#define HEART_RATE_HUN_NAME "/dev/heart_rate_hun"
#define HEART_RATE_HUN_RESET_VALUE 0
#define HEART_RATE_HUN_SPAN 16
#define HEART_RATE_HUN_TYPE "altera_avalon_pio"


/*
 * heart_rate_one configuration
 *
 */

#define ALT_MODULE_CLASS_heart_rate_one altera_avalon_pio
#define HEART_RATE_ONE_BASE 0x15100
#define HEART_RATE_ONE_BIT_CLEARING_EDGE_REGISTER 0
#define HEART_RATE_ONE_BIT_MODIFYING_OUTPUT_REGISTER 0
#define HEART_RATE_ONE_CAPTURE 0
#define HEART_RATE_ONE_DATA_WIDTH 4
#define HEART_RATE_ONE_DO_TEST_BENCH_WIRING 0
#define HEART_RATE_ONE_DRIVEN_SIM_VALUE 0
#define HEART_RATE_ONE_EDGE_TYPE "NONE"
#define HEART_RATE_ONE_FREQ 50000000
#define HEART_RATE_ONE_HAS_IN 0
#define HEART_RATE_ONE_HAS_OUT 1
#define HEART_RATE_ONE_HAS_TRI 0
#define HEART_RATE_ONE_IRQ -1
#define HEART_RATE_ONE_IRQ_INTERRUPT_CONTROLLER_ID -1
#define HEART_RATE_ONE_IRQ_TYPE "NONE"
#define HEART_RATE_ONE_NAME "/dev/heart_rate_one"
#define HEART_RATE_ONE_RESET_VALUE 0
#define HEART_RATE_ONE_SPAN 16
#define HEART_RATE_ONE_TYPE "altera_avalon_pio"


/*
 * heart_rate_ten configuration
 *
 */

#define ALT_MODULE_CLASS_heart_rate_ten altera_avalon_pio
#define HEART_RATE_TEN_BASE 0x150f0
#define HEART_RATE_TEN_BIT_CLEARING_EDGE_REGISTER 0
#define HEART_RATE_TEN_BIT_MODIFYING_OUTPUT_REGISTER 0
#define HEART_RATE_TEN_CAPTURE 0
#define HEART_RATE_TEN_DATA_WIDTH 4
#define HEART_RATE_TEN_DO_TEST_BENCH_WIRING 0
#define HEART_RATE_TEN_DRIVEN_SIM_VALUE 0
#define HEART_RATE_TEN_EDGE_TYPE "NONE"
#define HEART_RATE_TEN_FREQ 50000000
#define HEART_RATE_TEN_HAS_IN 0
#define HEART_RATE_TEN_HAS_OUT 1
#define HEART_RATE_TEN_HAS_TRI 0
#define HEART_RATE_TEN_IRQ -1
#define HEART_RATE_TEN_IRQ_INTERRUPT_CONTROLLER_ID -1
#define HEART_RATE_TEN_IRQ_TYPE "NONE"
#define HEART_RATE_TEN_NAME "/dev/heart_rate_ten"
#define HEART_RATE_TEN_RESET_VALUE 0
#define HEART_RATE_TEN_SPAN 16
#define HEART_RATE_TEN_TYPE "altera_avalon_pio"


/*
 * jtag_uart configuration
 *
 */

#define ALT_MODULE_CLASS_jtag_uart altera_avalon_jtag_uart
#define JTAG_UART_BASE 0x15158
#define JTAG_UART_IRQ 0
#define JTAG_UART_IRQ_INTERRUPT_CONTROLLER_ID 0
#define JTAG_UART_NAME "/dev/jtag_uart"
#define JTAG_UART_READ_DEPTH 64
#define JTAG_UART_READ_THRESHOLD 8
#define JTAG_UART_SPAN 8
#define JTAG_UART_TYPE "altera_avalon_jtag_uart"
#define JTAG_UART_WRITE_DEPTH 64
#define JTAG_UART_WRITE_THRESHOLD 8


/*
 * liquefied_one configuration
 *
 */

#define ALT_MODULE_CLASS_liquefied_one altera_avalon_pio
#define LIQUEFIED_ONE_BASE 0x15060
#define LIQUEFIED_ONE_BIT_CLEARING_EDGE_REGISTER 0
#define LIQUEFIED_ONE_BIT_MODIFYING_OUTPUT_REGISTER 0
#define LIQUEFIED_ONE_CAPTURE 0
#define LIQUEFIED_ONE_DATA_WIDTH 4
#define LIQUEFIED_ONE_DO_TEST_BENCH_WIRING 0
#define LIQUEFIED_ONE_DRIVEN_SIM_VALUE 0
#define LIQUEFIED_ONE_EDGE_TYPE "NONE"
#define LIQUEFIED_ONE_FREQ 50000000
#define LIQUEFIED_ONE_HAS_IN 0
#define LIQUEFIED_ONE_HAS_OUT 1
#define LIQUEFIED_ONE_HAS_TRI 0
#define LIQUEFIED_ONE_IRQ -1
#define LIQUEFIED_ONE_IRQ_INTERRUPT_CONTROLLER_ID -1
#define LIQUEFIED_ONE_IRQ_TYPE "NONE"
#define LIQUEFIED_ONE_NAME "/dev/liquefied_one"
#define LIQUEFIED_ONE_RESET_VALUE 0
#define LIQUEFIED_ONE_SPAN 16
#define LIQUEFIED_ONE_TYPE "altera_avalon_pio"


/*
 * liquefied_ten configuration
 *
 */

#define ALT_MODULE_CLASS_liquefied_ten altera_avalon_pio
#define LIQUEFIED_TEN_BASE 0x15070
#define LIQUEFIED_TEN_BIT_CLEARING_EDGE_REGISTER 0
#define LIQUEFIED_TEN_BIT_MODIFYING_OUTPUT_REGISTER 0
#define LIQUEFIED_TEN_CAPTURE 0
#define LIQUEFIED_TEN_DATA_WIDTH 4
#define LIQUEFIED_TEN_DO_TEST_BENCH_WIRING 0
#define LIQUEFIED_TEN_DRIVEN_SIM_VALUE 0
#define LIQUEFIED_TEN_EDGE_TYPE "NONE"
#define LIQUEFIED_TEN_FREQ 50000000
#define LIQUEFIED_TEN_HAS_IN 0
#define LIQUEFIED_TEN_HAS_OUT 1
#define LIQUEFIED_TEN_HAS_TRI 0
#define LIQUEFIED_TEN_IRQ -1
#define LIQUEFIED_TEN_IRQ_INTERRUPT_CONTROLLER_ID -1
#define LIQUEFIED_TEN_IRQ_TYPE "NONE"
#define LIQUEFIED_TEN_NAME "/dev/liquefied_ten"
#define LIQUEFIED_TEN_RESET_VALUE 0
#define LIQUEFIED_TEN_SPAN 16
#define LIQUEFIED_TEN_TYPE "altera_avalon_pio"


/*
 * max30102_0 configuration
 *
 */

#define ALT_MODULE_CLASS_max30102_0 altera_avalon_pio
#define MAX30102_0_BASE 0x15140
#define MAX30102_0_BIT_CLEARING_EDGE_REGISTER 0
#define MAX30102_0_BIT_MODIFYING_OUTPUT_REGISTER 0
#define MAX30102_0_CAPTURE 0
#define MAX30102_0_DATA_WIDTH 24
#define MAX30102_0_DO_TEST_BENCH_WIRING 0
#define MAX30102_0_DRIVEN_SIM_VALUE 0
#define MAX30102_0_EDGE_TYPE "NONE"
#define MAX30102_0_FREQ 50000000
#define MAX30102_0_HAS_IN 1
#define MAX30102_0_HAS_OUT 0
#define MAX30102_0_HAS_TRI 0
#define MAX30102_0_IRQ -1
#define MAX30102_0_IRQ_INTERRUPT_CONTROLLER_ID -1
#define MAX30102_0_IRQ_TYPE "NONE"
#define MAX30102_0_NAME "/dev/max30102_0"
#define MAX30102_0_RESET_VALUE 0
#define MAX30102_0_SPAN 16
#define MAX30102_0_TYPE "altera_avalon_pio"


/*
 * max30102_1 configuration
 *
 */

#define ALT_MODULE_CLASS_max30102_1 altera_avalon_pio
#define MAX30102_1_BASE 0x15130
#define MAX30102_1_BIT_CLEARING_EDGE_REGISTER 0
#define MAX30102_1_BIT_MODIFYING_OUTPUT_REGISTER 0
#define MAX30102_1_CAPTURE 0
#define MAX30102_1_DATA_WIDTH 24
#define MAX30102_1_DO_TEST_BENCH_WIRING 0
#define MAX30102_1_DRIVEN_SIM_VALUE 0
#define MAX30102_1_EDGE_TYPE "NONE"
#define MAX30102_1_FREQ 50000000
#define MAX30102_1_HAS_IN 1
#define MAX30102_1_HAS_OUT 0
#define MAX30102_1_HAS_TRI 0
#define MAX30102_1_IRQ -1
#define MAX30102_1_IRQ_INTERRUPT_CONTROLLER_ID -1
#define MAX30102_1_IRQ_TYPE "NONE"
#define MAX30102_1_NAME "/dev/max30102_1"
#define MAX30102_1_RESET_VALUE 0
#define MAX30102_1_SPAN 16
#define MAX30102_1_TYPE "altera_avalon_pio"


/*
 * natural_one configuration
 *
 */

#define ALT_MODULE_CLASS_natural_one altera_avalon_pio
#define NATURAL_ONE_BASE 0x15040
#define NATURAL_ONE_BIT_CLEARING_EDGE_REGISTER 0
#define NATURAL_ONE_BIT_MODIFYING_OUTPUT_REGISTER 0
#define NATURAL_ONE_CAPTURE 0
#define NATURAL_ONE_DATA_WIDTH 4
#define NATURAL_ONE_DO_TEST_BENCH_WIRING 0
#define NATURAL_ONE_DRIVEN_SIM_VALUE 0
#define NATURAL_ONE_EDGE_TYPE "NONE"
#define NATURAL_ONE_FREQ 50000000
#define NATURAL_ONE_HAS_IN 0
#define NATURAL_ONE_HAS_OUT 1
#define NATURAL_ONE_HAS_TRI 0
#define NATURAL_ONE_IRQ -1
#define NATURAL_ONE_IRQ_INTERRUPT_CONTROLLER_ID -1
#define NATURAL_ONE_IRQ_TYPE "NONE"
#define NATURAL_ONE_NAME "/dev/natural_one"
#define NATURAL_ONE_RESET_VALUE 0
#define NATURAL_ONE_SPAN 16
#define NATURAL_ONE_TYPE "altera_avalon_pio"


/*
 * natural_ten configuration
 *
 */

#define ALT_MODULE_CLASS_natural_ten altera_avalon_pio
#define NATURAL_TEN_BASE 0x15050
#define NATURAL_TEN_BIT_CLEARING_EDGE_REGISTER 0
#define NATURAL_TEN_BIT_MODIFYING_OUTPUT_REGISTER 0
#define NATURAL_TEN_CAPTURE 0
#define NATURAL_TEN_DATA_WIDTH 4
#define NATURAL_TEN_DO_TEST_BENCH_WIRING 0
#define NATURAL_TEN_DRIVEN_SIM_VALUE 0
#define NATURAL_TEN_EDGE_TYPE "NONE"
#define NATURAL_TEN_FREQ 50000000
#define NATURAL_TEN_HAS_IN 0
#define NATURAL_TEN_HAS_OUT 1
#define NATURAL_TEN_HAS_TRI 0
#define NATURAL_TEN_IRQ -1
#define NATURAL_TEN_IRQ_INTERRUPT_CONTROLLER_ID -1
#define NATURAL_TEN_IRQ_TYPE "NONE"
#define NATURAL_TEN_NAME "/dev/natural_ten"
#define NATURAL_TEN_RESET_VALUE 0
#define NATURAL_TEN_SPAN 16
#define NATURAL_TEN_TYPE "altera_avalon_pio"


/*
 * oxy_one configuration
 *
 */

#define ALT_MODULE_CLASS_oxy_one altera_avalon_pio
#define OXY_ONE_BASE 0x15000
#define OXY_ONE_BIT_CLEARING_EDGE_REGISTER 0
#define OXY_ONE_BIT_MODIFYING_OUTPUT_REGISTER 0
#define OXY_ONE_CAPTURE 0
#define OXY_ONE_DATA_WIDTH 4
#define OXY_ONE_DO_TEST_BENCH_WIRING 0
#define OXY_ONE_DRIVEN_SIM_VALUE 0
#define OXY_ONE_EDGE_TYPE "NONE"
#define OXY_ONE_FREQ 50000000
#define OXY_ONE_HAS_IN 0
#define OXY_ONE_HAS_OUT 1
#define OXY_ONE_HAS_TRI 0
#define OXY_ONE_IRQ -1
#define OXY_ONE_IRQ_INTERRUPT_CONTROLLER_ID -1
#define OXY_ONE_IRQ_TYPE "NONE"
#define OXY_ONE_NAME "/dev/oxy_one"
#define OXY_ONE_RESET_VALUE 0
#define OXY_ONE_SPAN 16
#define OXY_ONE_TYPE "altera_avalon_pio"


/*
 * oxy_ten configuration
 *
 */

#define ALT_MODULE_CLASS_oxy_ten altera_avalon_pio
#define OXY_TEN_BASE 0x15010
#define OXY_TEN_BIT_CLEARING_EDGE_REGISTER 0
#define OXY_TEN_BIT_MODIFYING_OUTPUT_REGISTER 0
#define OXY_TEN_CAPTURE 0
#define OXY_TEN_DATA_WIDTH 4
#define OXY_TEN_DO_TEST_BENCH_WIRING 0
#define OXY_TEN_DRIVEN_SIM_VALUE 0
#define OXY_TEN_EDGE_TYPE "NONE"
#define OXY_TEN_FREQ 50000000
#define OXY_TEN_HAS_IN 0
#define OXY_TEN_HAS_OUT 1
#define OXY_TEN_HAS_TRI 0
#define OXY_TEN_IRQ -1
#define OXY_TEN_IRQ_INTERRUPT_CONTROLLER_ID -1
#define OXY_TEN_IRQ_TYPE "NONE"
#define OXY_TEN_NAME "/dev/oxy_ten"
#define OXY_TEN_RESET_VALUE 0
#define OXY_TEN_SPAN 16
#define OXY_TEN_TYPE "altera_avalon_pio"


/*
 * sysid_qsys configuration
 *
 */

#define ALT_MODULE_CLASS_sysid_qsys altera_avalon_sysid_qsys
#define SYSID_QSYS_BASE 0x15150
#define SYSID_QSYS_ID 0
#define SYSID_QSYS_IRQ -1
#define SYSID_QSYS_IRQ_INTERRUPT_CONTROLLER_ID -1
#define SYSID_QSYS_NAME "/dev/sysid_qsys"
#define SYSID_QSYS_SPAN 8
#define SYSID_QSYS_TIMESTAMP 1560257782
#define SYSID_QSYS_TYPE "altera_avalon_sysid_qsys"

#endif /* __SYSTEM_H_ */
