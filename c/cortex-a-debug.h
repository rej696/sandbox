/**
 * @brief functions for debugging cortex a processors
 */

#ifndef CORTEX_A_DEBUG_H_
#define CORTEX_A_DEBUG_H_
#ifdef __cplusplus
extern "C" {
#endif

#include <stdio.h>
#include <stdint.h>

static inline void dump_reg(void)
{
    /* Print stack pointer and cpsr */
    uint32_t sp, cpsr, lr;
    asm volatile("mov %0, sp" : "=r"(sp));
    asm volatile("mov %0, lr" : "=r"(lr));
    asm volatile("mrs %0, cpsr" : "=r"(cpsr));
    printf("\r\n");
    printf("SP:\t0x%08x\r\n", (unsigned int)sp);
    printf("LR:\t0x%08x\r\n", (unsigned int)lr);
    printf("CPSR:\t0x%08x\r\n", (unsigned int)cpsr);
    printf("\r\n");
}

#ifdef __cplusplus
}
#endif
#endif
