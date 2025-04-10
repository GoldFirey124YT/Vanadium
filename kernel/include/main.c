#include "gdt.h"

void kernel_main() {
    gdt_init();

    char *video = (char*) 0xB8000;
    const char *msg = "Welcome to your BSD-like Kernel!";
    for (int i = 0; msg[i]; i++) {
        video[i * 2] = msg[i];
        video[i * 2 + 1] = 0x0F;
    }

    while (1) __asm__("hlt");
}
