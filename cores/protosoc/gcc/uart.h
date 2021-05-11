#pragma once

void uartPutc(unsigned char);
unsigned char uartGetc();
uint32_t uartStatus();
void uartInit();
int puts(const char *string);