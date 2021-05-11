#include "main.h"

int main() {
  setBitDirection(LED_PORT, LED_PIN, OUTPUT);

  setDivideBy(64);
  resetTimer();
  startTimer();

  uartInit();

  sleep(2000);

  initDisplay();

  sendData('H');
  sendData('e');
  sendData('l');
  sendData('l');
  sendData('o');
  sendData(' ');
  sendData('W');
  sendData('o');
  sendData('r');
  sendData('l');
  sendData('d');
  sendData(' ');
  sendData('[');
  sendData('2');
  sendData(']');

  printf("Hello world\n");

  while(1) {
    printf("Cycle\n");
    for(int i = 0; i < 64; i++) {
      setBit(LED_PORT, LED_PIN, HIGH);
      sleep(100);
      setBit(LED_PORT, LED_PIN, LOW);
      sleep(100);
    }
    sleep(2000);
  }

  return 0;
}