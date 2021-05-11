#include "main.h"

#define _UART_ADDR 0xF3000000

#define UART_BITS5            (0 << 0) // 5 bit char
#define UART_BITS6            (1 << 0) // 6 bit char
#define UART_BITS7            (2 << 0) // 7 bit char
#define UART_BITS8            (3 << 0) // 8 bit char
#define UART_1STOP            (0 << 2) // 1 stop bits
#define UART_2STOP            (1 << 2) // 1.5 stop bits in 5 bit char, 2 otherwise
#define UART_PARITY_ENABLE    (1 << 3)
#define UART_PARITY_EVEN      (1 << 4)
#define UART_STICKY_PARITY    (1 << 5)
#define UART_BREAK            (1 << 6)
#define UART_DIVISOR_LATCH    (1 << 7)


#define UART_LSR_DATAREADY    (1 << 0)
#define UART_LSR_OVERRUNERR   (1 << 1)
#define UART_LSR_PARITYERR    (1 << 2)
#define UART_LSR_FRAMEERR     (1 << 3)
#define UART_LSR_BREAKINT     (1 << 4)
#define UART_LSR_TXFIFOEMPTY  (1 << 5)
#define UART_LSR_TXREADY      (1 << 6)
#define UART_LSR_ERR          (1 << 7)

#define uart_rxtx_buff          (*((volatile uint32_t *)      (_UART_ADDR + 0)))
#define uart_interrupt_enable   (*((volatile uint32_t *)      (_UART_ADDR + 4)))
#define uart_interrupt_id       (*((const volatile uint32_t *)(_UART_ADDR + 8)))
#define uart_fifo_options       (*((volatile uint32_t *)      (_UART_ADDR + 8)))
#define uart_line_control       (*((volatile uint32_t *)      (_UART_ADDR + 12)))
#define uart_modem_control      (*((volatile uint32_t *)      (_UART_ADDR + 16)))
#define uart_line_status        (*((const volatile uint32_t *)(_UART_ADDR + 20)))
#define uart_modem_status       (*((const volatile uint32_t *)(_UART_ADDR + 24)))
#define uart_divisor_latch_b0   (*((volatile uint32_t *)      (_UART_ADDR + 0)))
#define uart_divisor_latch_b1   (*((volatile uint32_t *)      (_UART_ADDR + 4)))

int txReady() {
  return (uart_line_status & UART_LSR_TXFIFOEMPTY) > 0;
}

void uartPutc(unsigned char c) {
  uart_rxtx_buff = c;
  while(!txReady()) {} // Wait for sending data
}

unsigned char uartGetc() {
  return uart_rxtx_buff & 0xFF;
}

uint32_t uartStatus() {
  return uart_line_status;
}

void uartInit() {
  // 8N1 mode and enable divisor latch
  uart_line_control = UART_BITS8 | UART_1STOP | UART_DIVISOR_LATCH;

  #define dividerS 13
  uart_divisor_latch_b1 = (dividerS & 0xFF00) >> 8; // First MSB
  uart_divisor_latch_b0 = (dividerS & 0x00FF) >> 0; // Last  LSB

  uart_line_control = UART_BITS8 | UART_1STOP; // Disable divisor latch and start working
}

int puts(const char *string) {
  int n = 0;
  while (*string != 0x00) {
    if (*string == '\n') {
      uartPutc('\r');
      n++;
    }
    uartPutc(*string);
    string++;
    n++;
  }

  uartPutc('\r');
  uartPutc('\n');

  return n+2;
}