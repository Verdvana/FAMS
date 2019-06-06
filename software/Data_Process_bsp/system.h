/*
 * system.h - SOPC Builder system and BSP software package information
 *
 * Machine generated for CPU 'nios2_gen2' in SOPC Builder design 'qsys_system'
 * SOPC Builder design path: ../../qsys_system.sopcinfo
 *
 * Generated: Thu Jun 06 16:25:25 CST 2019
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
#define ALT_CPU_BREAK_ADDR 0x00010820
#define ALT_CPU_CPU_ARCH_NIOS2_R1
#define ALT_CPU_CPU_FREQ 50000000u
#define ALT_CPU_CPU_ID_SIZE 1
#define ALT_CPU_CPU_ID_VALUE 0x00000000
#define ALT_CPU_CPU_IMPLEMENTATION "fast"
#define ALT_CPU_DATA_ADDR_WIDTH 0x11
#define ALT_CPU_DCACHE_BYPASS_MASK 0x80000000
#define ALT_CPU_DCACHE_LINE_SIZE 32
#define ALT_CPU_DCACHE_LINE_SIZE_LOG2 5
#define ALT_CPU_DCACHE_SIZE 2048
#define ALT_CPU_EXCEPTION_ADDR 0x00008020
#define ALT_CPU_FLASH_ACCELERATOR_LINES 0
#define ALT_CPU_FLASH_ACCELERATOR_LINE_SIZE 0
#define ALT_CPU_FLUSHDA_SUPPORTED
#define ALT_CPU_FREQ 50000000
#define ALT_CPU_HARDWARE_DIVIDE_PRESENT 0
#define ALT_CPU_HARDWARE_MULTIPLY_PRESENT 1
#define ALT_CPU_HARDWARE_MULX_PRESENT 0
#define ALT_CPU_HAS_DEBUG_CORE 1
#define ALT_CPU_HAS_DEBUG_STUB
#define ALT_CPU_HAS_EXTRA_EXCEPTION_INFO
#define ALT_CPU_HAS_ILLEGAL_INSTRUCTION_EXCEPTION
#define ALT_CPU_HAS_JMPI_INSTRUCTION
#define ALT_CPU_ICACHE_LINE_SIZE 32
#define ALT_CPU_ICACHE_LINE_SIZE_LOG2 5
#define ALT_CPU_ICACHE_SIZE 4096
#define ALT_CPU_INITDA_SUPPORTED
#define ALT_CPU_INST_ADDR_WIDTH 0x11
#define ALT_CPU_NAME "nios2_gen2"
#define ALT_CPU_NUM_OF_SHADOW_REG_SETS 0
#define ALT_CPU_OCI_VERSION 1
#define ALT_CPU_RESET_ADDR 0x00008000


/*
 * CPU configuration (with legacy prefix - don't use these anymore)
 *
 */

#define NIOS2_BIG_ENDIAN 0
#define NIOS2_BREAK_ADDR 0x00010820
#define NIOS2_CPU_ARCH_NIOS2_R1
#define NIOS2_CPU_FREQ 50000000u
#define NIOS2_CPU_ID_SIZE 1
#define NIOS2_CPU_ID_VALUE 0x00000000
#define NIOS2_CPU_IMPLEMENTATION "fast"
#define NIOS2_DATA_ADDR_WIDTH 0x11
#define NIOS2_DCACHE_BYPASS_MASK 0x80000000
#define NIOS2_DCACHE_LINE_SIZE 32
#define NIOS2_DCACHE_LINE_SIZE_LOG2 5
#define NIOS2_DCACHE_SIZE 2048
#define NIOS2_EXCEPTION_ADDR 0x00008020
#define NIOS2_FLASH_ACCELERATOR_LINES 0
#define NIOS2_FLASH_ACCELERATOR_LINE_SIZE 0
#define NIOS2_FLUSHDA_SUPPORTED
#define NIOS2_HARDWARE_DIVIDE_PRESENT 0
#define NIOS2_HARDWARE_MULTIPLY_PRESENT 1
#define NIOS2_HARDWARE_MULX_PRESENT 0
#define NIOS2_HAS_DEBUG_CORE 1
#define NIOS2_HAS_DEBUG_STUB
#define NIOS2_HAS_EXTRA_EXCEPTION_INFO
#define NIOS2_HAS_ILLEGAL_INSTRUCTION_EXCEPTION
#define NIOS2_HAS_JMPI_INSTRUCTION
#define NIOS2_ICACHE_LINE_SIZE 32
#define NIOS2_ICACHE_LINE_SIZE_LOG2 5
#define NIOS2_ICACHE_SIZE 4096
#define NIOS2_INITDA_SUPPORTED
#define NIOS2_INST_ADDR_WIDTH 0x11
#define NIOS2_NUM_OF_SHADOW_REG_SETS 0
#define NIOS2_OCI_VERSION 1
#define NIOS2_RESET_ADDR 0x00008000


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
#define RAM_NON_DEFAULT_INIT_FILE_ENABLED 0
#define RAM_RAM_BLOCK_TYPE "AUTO"
#define RAM_READ_DURING_WRITE_MODE "DONT_CARE"
#define RAM_SINGLE_CLOCK_OP 0
#define RAM_SIZE_MULTIPLE 1
#define RAM_SIZE_VALUE 20480
#define RAM_SPAN 20480
#define RAM_TYPE "altera_avalon_onchip_memory2"
#define RAM_WRITABLE 1


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
#define ALT_STDERR_BASE 0x11148
#define ALT_STDERR_DEV jtag_uart
#define ALT_STDERR_IS_JTAG_UART
#define ALT_STDERR_PRESENT
#define ALT_STDERR_TYPE "altera_avalon_jtag_uart"
#define ALT_STDIN "/dev/jtag_uart"
#define ALT_STDIN_BASE 0x11148
#define ALT_STDIN_DEV jtag_uart
#define ALT_STDIN_IS_JTAG_UART
#define ALT_STDIN_PRESENT
#define ALT_STDIN_TYPE "altera_avalon_jtag_uart"
#define ALT_STDOUT "/dev/jtag_uart"
#define ALT_STDOUT_BASE 0x11148
#define ALT_STDOUT_DEV jtag_uart
#define ALT_STDOUT_IS_JTAG_UART
#define ALT_STDOUT_PRESENT
#define ALT_STDOUT_TYPE "altera_avalon_jtag_uart"
#define ALT_SYSTEM_NAME "qsys_system"


/*
 * adc_p configuration
 *
 */

#define ADC_P_BASE 0x11000
#define ADC_P_BIT_CLEARING_EDGE_REGISTER 0
#define ADC_P_BIT_MODIFYING_OUTPUT_REGISTER 0
#define ADC_P_CAPTURE 0
#define ADC_P_DATA_WIDTH 24
#define ADC_P_DO_TEST_BENCH_WIRING 0
#define ADC_P_DRIVEN_SIM_VALUE 0
#define ADC_P_EDGE_TYPE "NONE"
#define ADC_P_FREQ 50000000
#define ADC_P_HAS_IN 1
#define ADC_P_HAS_OUT 0
#define ADC_P_HAS_TRI 0
#define ADC_P_IRQ -1
#define ADC_P_IRQ_INTERRUPT_CONTROLLER_ID -1
#define ADC_P_IRQ_TYPE "NONE"
#define ADC_P_NAME "/dev/adc_p"
#define ADC_P_RESET_VALUE 0
#define ADC_P_SPAN 16
#define ADC_P_TYPE "altera_avalon_pio"
#define ALT_MODULE_CLASS_adc_p altera_avalon_pio


/*
 * adc_t configuration
 *
 */

#define ADC_T_BASE 0x11010
#define ADC_T_BIT_CLEARING_EDGE_REGISTER 0
#define ADC_T_BIT_MODIFYING_OUTPUT_REGISTER 0
#define ADC_T_CAPTURE 0
#define ADC_T_DATA_WIDTH 24
#define ADC_T_DO_TEST_BENCH_WIRING 0
#define ADC_T_DRIVEN_SIM_VALUE 0
#define ADC_T_EDGE_TYPE "NONE"
#define ADC_T_FREQ 50000000
#define ADC_T_HAS_IN 1
#define ADC_T_HAS_OUT 0
#define ADC_T_HAS_TRI 0
#define ADC_T_IRQ -1
#define ADC_T_IRQ_INTERRUPT_CONTROLLER_ID -1
#define ADC_T_IRQ_TYPE "NONE"
#define ADC_T_NAME "/dev/adc_t"
#define ADC_T_RESET_VALUE 0
#define ADC_T_SPAN 16
#define ADC_T_TYPE "altera_avalon_pio"
#define ALT_MODULE_CLASS_adc_t altera_avalon_pio


/*
 * dig_p1 configuration
 *
 */

#define ALT_MODULE_CLASS_dig_p1 altera_avalon_pio
#define DIG_P1_BASE 0x110a0
#define DIG_P1_BIT_CLEARING_EDGE_REGISTER 0
#define DIG_P1_BIT_MODIFYING_OUTPUT_REGISTER 0
#define DIG_P1_CAPTURE 0
#define DIG_P1_DATA_WIDTH 16
#define DIG_P1_DO_TEST_BENCH_WIRING 0
#define DIG_P1_DRIVEN_SIM_VALUE 0
#define DIG_P1_EDGE_TYPE "NONE"
#define DIG_P1_FREQ 50000000
#define DIG_P1_HAS_IN 1
#define DIG_P1_HAS_OUT 0
#define DIG_P1_HAS_TRI 0
#define DIG_P1_IRQ -1
#define DIG_P1_IRQ_INTERRUPT_CONTROLLER_ID -1
#define DIG_P1_IRQ_TYPE "NONE"
#define DIG_P1_NAME "/dev/dig_p1"
#define DIG_P1_RESET_VALUE 0
#define DIG_P1_SPAN 16
#define DIG_P1_TYPE "altera_avalon_pio"


/*
 * dig_p2 configuration
 *
 */

#define ALT_MODULE_CLASS_dig_p2 altera_avalon_pio
#define DIG_P2_BASE 0x11090
#define DIG_P2_BIT_CLEARING_EDGE_REGISTER 0
#define DIG_P2_BIT_MODIFYING_OUTPUT_REGISTER 0
#define DIG_P2_CAPTURE 0
#define DIG_P2_DATA_WIDTH 16
#define DIG_P2_DO_TEST_BENCH_WIRING 0
#define DIG_P2_DRIVEN_SIM_VALUE 0
#define DIG_P2_EDGE_TYPE "NONE"
#define DIG_P2_FREQ 50000000
#define DIG_P2_HAS_IN 1
#define DIG_P2_HAS_OUT 0
#define DIG_P2_HAS_TRI 0
#define DIG_P2_IRQ -1
#define DIG_P2_IRQ_INTERRUPT_CONTROLLER_ID -1
#define DIG_P2_IRQ_TYPE "NONE"
#define DIG_P2_NAME "/dev/dig_p2"
#define DIG_P2_RESET_VALUE 0
#define DIG_P2_SPAN 16
#define DIG_P2_TYPE "altera_avalon_pio"


/*
 * dig_p3 configuration
 *
 */

#define ALT_MODULE_CLASS_dig_p3 altera_avalon_pio
#define DIG_P3_BASE 0x11080
#define DIG_P3_BIT_CLEARING_EDGE_REGISTER 0
#define DIG_P3_BIT_MODIFYING_OUTPUT_REGISTER 0
#define DIG_P3_CAPTURE 0
#define DIG_P3_DATA_WIDTH 16
#define DIG_P3_DO_TEST_BENCH_WIRING 0
#define DIG_P3_DRIVEN_SIM_VALUE 0
#define DIG_P3_EDGE_TYPE "NONE"
#define DIG_P3_FREQ 50000000
#define DIG_P3_HAS_IN 1
#define DIG_P3_HAS_OUT 0
#define DIG_P3_HAS_TRI 0
#define DIG_P3_IRQ -1
#define DIG_P3_IRQ_INTERRUPT_CONTROLLER_ID -1
#define DIG_P3_IRQ_TYPE "NONE"
#define DIG_P3_NAME "/dev/dig_p3"
#define DIG_P3_RESET_VALUE 0
#define DIG_P3_SPAN 16
#define DIG_P3_TYPE "altera_avalon_pio"


/*
 * dig_p4 configuration
 *
 */

#define ALT_MODULE_CLASS_dig_p4 altera_avalon_pio
#define DIG_P4_BASE 0x11070
#define DIG_P4_BIT_CLEARING_EDGE_REGISTER 0
#define DIG_P4_BIT_MODIFYING_OUTPUT_REGISTER 0
#define DIG_P4_CAPTURE 0
#define DIG_P4_DATA_WIDTH 16
#define DIG_P4_DO_TEST_BENCH_WIRING 0
#define DIG_P4_DRIVEN_SIM_VALUE 0
#define DIG_P4_EDGE_TYPE "NONE"
#define DIG_P4_FREQ 50000000
#define DIG_P4_HAS_IN 1
#define DIG_P4_HAS_OUT 0
#define DIG_P4_HAS_TRI 0
#define DIG_P4_IRQ -1
#define DIG_P4_IRQ_INTERRUPT_CONTROLLER_ID -1
#define DIG_P4_IRQ_TYPE "NONE"
#define DIG_P4_NAME "/dev/dig_p4"
#define DIG_P4_RESET_VALUE 0
#define DIG_P4_SPAN 16
#define DIG_P4_TYPE "altera_avalon_pio"


/*
 * dig_p5 configuration
 *
 */

#define ALT_MODULE_CLASS_dig_p5 altera_avalon_pio
#define DIG_P5_BASE 0x11050
#define DIG_P5_BIT_CLEARING_EDGE_REGISTER 0
#define DIG_P5_BIT_MODIFYING_OUTPUT_REGISTER 0
#define DIG_P5_CAPTURE 0
#define DIG_P5_DATA_WIDTH 16
#define DIG_P5_DO_TEST_BENCH_WIRING 0
#define DIG_P5_DRIVEN_SIM_VALUE 0
#define DIG_P5_EDGE_TYPE "NONE"
#define DIG_P5_FREQ 50000000
#define DIG_P5_HAS_IN 1
#define DIG_P5_HAS_OUT 0
#define DIG_P5_HAS_TRI 0
#define DIG_P5_IRQ -1
#define DIG_P5_IRQ_INTERRUPT_CONTROLLER_ID -1
#define DIG_P5_IRQ_TYPE "NONE"
#define DIG_P5_NAME "/dev/dig_p5"
#define DIG_P5_RESET_VALUE 0
#define DIG_P5_SPAN 16
#define DIG_P5_TYPE "altera_avalon_pio"


/*
 * dig_p6 configuration
 *
 */

#define ALT_MODULE_CLASS_dig_p6 altera_avalon_pio
#define DIG_P6_BASE 0x11060
#define DIG_P6_BIT_CLEARING_EDGE_REGISTER 0
#define DIG_P6_BIT_MODIFYING_OUTPUT_REGISTER 0
#define DIG_P6_CAPTURE 0
#define DIG_P6_DATA_WIDTH 16
#define DIG_P6_DO_TEST_BENCH_WIRING 0
#define DIG_P6_DRIVEN_SIM_VALUE 0
#define DIG_P6_EDGE_TYPE "NONE"
#define DIG_P6_FREQ 50000000
#define DIG_P6_HAS_IN 1
#define DIG_P6_HAS_OUT 0
#define DIG_P6_HAS_TRI 0
#define DIG_P6_IRQ -1
#define DIG_P6_IRQ_INTERRUPT_CONTROLLER_ID -1
#define DIG_P6_IRQ_TYPE "NONE"
#define DIG_P6_NAME "/dev/dig_p6"
#define DIG_P6_RESET_VALUE 0
#define DIG_P6_SPAN 16
#define DIG_P6_TYPE "altera_avalon_pio"


/*
 * dig_p7 configuration
 *
 */

#define ALT_MODULE_CLASS_dig_p7 altera_avalon_pio
#define DIG_P7_BASE 0x11040
#define DIG_P7_BIT_CLEARING_EDGE_REGISTER 0
#define DIG_P7_BIT_MODIFYING_OUTPUT_REGISTER 0
#define DIG_P7_CAPTURE 0
#define DIG_P7_DATA_WIDTH 16
#define DIG_P7_DO_TEST_BENCH_WIRING 0
#define DIG_P7_DRIVEN_SIM_VALUE 0
#define DIG_P7_EDGE_TYPE "NONE"
#define DIG_P7_FREQ 50000000
#define DIG_P7_HAS_IN 1
#define DIG_P7_HAS_OUT 0
#define DIG_P7_HAS_TRI 0
#define DIG_P7_IRQ -1
#define DIG_P7_IRQ_INTERRUPT_CONTROLLER_ID -1
#define DIG_P7_IRQ_TYPE "NONE"
#define DIG_P7_NAME "/dev/dig_p7"
#define DIG_P7_RESET_VALUE 0
#define DIG_P7_SPAN 16
#define DIG_P7_TYPE "altera_avalon_pio"


/*
 * dig_p8 configuration
 *
 */

#define ALT_MODULE_CLASS_dig_p8 altera_avalon_pio
#define DIG_P8_BASE 0x11030
#define DIG_P8_BIT_CLEARING_EDGE_REGISTER 0
#define DIG_P8_BIT_MODIFYING_OUTPUT_REGISTER 0
#define DIG_P8_CAPTURE 0
#define DIG_P8_DATA_WIDTH 16
#define DIG_P8_DO_TEST_BENCH_WIRING 0
#define DIG_P8_DRIVEN_SIM_VALUE 0
#define DIG_P8_EDGE_TYPE "NONE"
#define DIG_P8_FREQ 50000000
#define DIG_P8_HAS_IN 1
#define DIG_P8_HAS_OUT 0
#define DIG_P8_HAS_TRI 0
#define DIG_P8_IRQ -1
#define DIG_P8_IRQ_INTERRUPT_CONTROLLER_ID -1
#define DIG_P8_IRQ_TYPE "NONE"
#define DIG_P8_NAME "/dev/dig_p8"
#define DIG_P8_RESET_VALUE 0
#define DIG_P8_SPAN 16
#define DIG_P8_TYPE "altera_avalon_pio"


/*
 * dig_p9 configuration
 *
 */

#define ALT_MODULE_CLASS_dig_p9 altera_avalon_pio
#define DIG_P9_BASE 0x11020
#define DIG_P9_BIT_CLEARING_EDGE_REGISTER 0
#define DIG_P9_BIT_MODIFYING_OUTPUT_REGISTER 0
#define DIG_P9_CAPTURE 0
#define DIG_P9_DATA_WIDTH 16
#define DIG_P9_DO_TEST_BENCH_WIRING 0
#define DIG_P9_DRIVEN_SIM_VALUE 0
#define DIG_P9_EDGE_TYPE "NONE"
#define DIG_P9_FREQ 50000000
#define DIG_P9_HAS_IN 1
#define DIG_P9_HAS_OUT 0
#define DIG_P9_HAS_TRI 0
#define DIG_P9_IRQ -1
#define DIG_P9_IRQ_INTERRUPT_CONTROLLER_ID -1
#define DIG_P9_IRQ_TYPE "NONE"
#define DIG_P9_NAME "/dev/dig_p9"
#define DIG_P9_RESET_VALUE 0
#define DIG_P9_SPAN 16
#define DIG_P9_TYPE "altera_avalon_pio"


/*
 * dig_t1 configuration
 *
 */

#define ALT_MODULE_CLASS_dig_t1 altera_avalon_pio
#define DIG_T1_BASE 0x110d0
#define DIG_T1_BIT_CLEARING_EDGE_REGISTER 0
#define DIG_T1_BIT_MODIFYING_OUTPUT_REGISTER 0
#define DIG_T1_CAPTURE 0
#define DIG_T1_DATA_WIDTH 16
#define DIG_T1_DO_TEST_BENCH_WIRING 0
#define DIG_T1_DRIVEN_SIM_VALUE 0
#define DIG_T1_EDGE_TYPE "NONE"
#define DIG_T1_FREQ 50000000
#define DIG_T1_HAS_IN 1
#define DIG_T1_HAS_OUT 0
#define DIG_T1_HAS_TRI 0
#define DIG_T1_IRQ -1
#define DIG_T1_IRQ_INTERRUPT_CONTROLLER_ID -1
#define DIG_T1_IRQ_TYPE "NONE"
#define DIG_T1_NAME "/dev/dig_t1"
#define DIG_T1_RESET_VALUE 0
#define DIG_T1_SPAN 16
#define DIG_T1_TYPE "altera_avalon_pio"


/*
 * dig_t2 configuration
 *
 */

#define ALT_MODULE_CLASS_dig_t2 altera_avalon_pio
#define DIG_T2_BASE 0x110c0
#define DIG_T2_BIT_CLEARING_EDGE_REGISTER 0
#define DIG_T2_BIT_MODIFYING_OUTPUT_REGISTER 0
#define DIG_T2_CAPTURE 0
#define DIG_T2_DATA_WIDTH 16
#define DIG_T2_DO_TEST_BENCH_WIRING 0
#define DIG_T2_DRIVEN_SIM_VALUE 0
#define DIG_T2_EDGE_TYPE "NONE"
#define DIG_T2_FREQ 50000000
#define DIG_T2_HAS_IN 1
#define DIG_T2_HAS_OUT 0
#define DIG_T2_HAS_TRI 0
#define DIG_T2_IRQ -1
#define DIG_T2_IRQ_INTERRUPT_CONTROLLER_ID -1
#define DIG_T2_IRQ_TYPE "NONE"
#define DIG_T2_NAME "/dev/dig_t2"
#define DIG_T2_RESET_VALUE 0
#define DIG_T2_SPAN 16
#define DIG_T2_TYPE "altera_avalon_pio"


/*
 * dig_t3 configuration
 *
 */

#define ALT_MODULE_CLASS_dig_t3 altera_avalon_pio
#define DIG_T3_BASE 0x110b0
#define DIG_T3_BIT_CLEARING_EDGE_REGISTER 0
#define DIG_T3_BIT_MODIFYING_OUTPUT_REGISTER 0
#define DIG_T3_CAPTURE 0
#define DIG_T3_DATA_WIDTH 16
#define DIG_T3_DO_TEST_BENCH_WIRING 0
#define DIG_T3_DRIVEN_SIM_VALUE 0
#define DIG_T3_EDGE_TYPE "NONE"
#define DIG_T3_FREQ 50000000
#define DIG_T3_HAS_IN 1
#define DIG_T3_HAS_OUT 0
#define DIG_T3_HAS_TRI 0
#define DIG_T3_IRQ -1
#define DIG_T3_IRQ_INTERRUPT_CONTROLLER_ID -1
#define DIG_T3_IRQ_TYPE "NONE"
#define DIG_T3_NAME "/dev/dig_t3"
#define DIG_T3_RESET_VALUE 0
#define DIG_T3_SPAN 16
#define DIG_T3_TYPE "altera_avalon_pio"


/*
 * end_o configuration
 *
 */

#define ALT_MODULE_CLASS_end_o altera_avalon_pio
#define END_O_BASE 0x11110
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
 * hal configuration
 *
 */

#define ALT_INCLUDE_INSTRUCTION_RELATED_EXCEPTION_API
#define ALT_MAX_FD 32
#define ALT_SYS_CLK none
#define ALT_TIMESTAMP_CLK none


/*
 * heart_rate configuration
 *
 */

#define ALT_MODULE_CLASS_heart_rate altera_avalon_pio
#define HEART_RATE_BASE 0x110e0
#define HEART_RATE_BIT_CLEARING_EDGE_REGISTER 0
#define HEART_RATE_BIT_MODIFYING_OUTPUT_REGISTER 0
#define HEART_RATE_CAPTURE 0
#define HEART_RATE_DATA_WIDTH 8
#define HEART_RATE_DO_TEST_BENCH_WIRING 0
#define HEART_RATE_DRIVEN_SIM_VALUE 0
#define HEART_RATE_EDGE_TYPE "NONE"
#define HEART_RATE_FREQ 50000000
#define HEART_RATE_HAS_IN 0
#define HEART_RATE_HAS_OUT 1
#define HEART_RATE_HAS_TRI 0
#define HEART_RATE_IRQ -1
#define HEART_RATE_IRQ_INTERRUPT_CONTROLLER_ID -1
#define HEART_RATE_IRQ_TYPE "NONE"
#define HEART_RATE_NAME "/dev/heart_rate"
#define HEART_RATE_RESET_VALUE 0
#define HEART_RATE_SPAN 16
#define HEART_RATE_TYPE "altera_avalon_pio"


/*
 * heignt_dec configuration
 *
 */

#define ALT_MODULE_CLASS_heignt_dec altera_avalon_pio
#define HEIGNT_DEC_BASE 0x110f0
#define HEIGNT_DEC_BIT_CLEARING_EDGE_REGISTER 0
#define HEIGNT_DEC_BIT_MODIFYING_OUTPUT_REGISTER 0
#define HEIGNT_DEC_CAPTURE 0
#define HEIGNT_DEC_DATA_WIDTH 8
#define HEIGNT_DEC_DO_TEST_BENCH_WIRING 0
#define HEIGNT_DEC_DRIVEN_SIM_VALUE 0
#define HEIGNT_DEC_EDGE_TYPE "NONE"
#define HEIGNT_DEC_FREQ 50000000
#define HEIGNT_DEC_HAS_IN 0
#define HEIGNT_DEC_HAS_OUT 1
#define HEIGNT_DEC_HAS_TRI 0
#define HEIGNT_DEC_IRQ -1
#define HEIGNT_DEC_IRQ_INTERRUPT_CONTROLLER_ID -1
#define HEIGNT_DEC_IRQ_TYPE "NONE"
#define HEIGNT_DEC_NAME "/dev/heignt_dec"
#define HEIGNT_DEC_RESET_VALUE 0
#define HEIGNT_DEC_SPAN 16
#define HEIGNT_DEC_TYPE "altera_avalon_pio"


/*
 * heignt_int configuration
 *
 */

#define ALT_MODULE_CLASS_heignt_int altera_avalon_pio
#define HEIGNT_INT_BASE 0x11100
#define HEIGNT_INT_BIT_CLEARING_EDGE_REGISTER 0
#define HEIGNT_INT_BIT_MODIFYING_OUTPUT_REGISTER 0
#define HEIGNT_INT_CAPTURE 0
#define HEIGNT_INT_DATA_WIDTH 8
#define HEIGNT_INT_DO_TEST_BENCH_WIRING 0
#define HEIGNT_INT_DRIVEN_SIM_VALUE 0
#define HEIGNT_INT_EDGE_TYPE "NONE"
#define HEIGNT_INT_FREQ 50000000
#define HEIGNT_INT_HAS_IN 0
#define HEIGNT_INT_HAS_OUT 1
#define HEIGNT_INT_HAS_TRI 0
#define HEIGNT_INT_IRQ -1
#define HEIGNT_INT_IRQ_INTERRUPT_CONTROLLER_ID -1
#define HEIGNT_INT_IRQ_TYPE "NONE"
#define HEIGNT_INT_NAME "/dev/heignt_int"
#define HEIGNT_INT_RESET_VALUE 0
#define HEIGNT_INT_SPAN 16
#define HEIGNT_INT_TYPE "altera_avalon_pio"


/*
 * jtag_uart configuration
 *
 */

#define ALT_MODULE_CLASS_jtag_uart altera_avalon_jtag_uart
#define JTAG_UART_BASE 0x11148
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
 * max30102_0 configuration
 *
 */

#define ALT_MODULE_CLASS_max30102_0 altera_avalon_pio
#define MAX30102_0_BASE 0x11130
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
#define MAX30102_1_BASE 0x11120
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
 * sysid_qsys configuration
 *
 */

#define ALT_MODULE_CLASS_sysid_qsys altera_avalon_sysid_qsys
#define SYSID_QSYS_BASE 0x11140
#define SYSID_QSYS_ID 0
#define SYSID_QSYS_IRQ -1
#define SYSID_QSYS_IRQ_INTERRUPT_CONTROLLER_ID -1
#define SYSID_QSYS_NAME "/dev/sysid_qsys"
#define SYSID_QSYS_SPAN 8
#define SYSID_QSYS_TIMESTAMP 1559808822
#define SYSID_QSYS_TYPE "altera_avalon_sysid_qsys"

#endif /* __SYSTEM_H_ */
