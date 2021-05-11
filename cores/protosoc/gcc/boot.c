#include "main.h"
#include "io.h"

void boot(void) {
  for (uint32_t p = PORTA; p <= LASTPORT; p++) {
    setDirection(p, 0);
    setPort(p, 0);
  }
  main();
}
