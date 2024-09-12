#include <stdio.h>

int main(void) {

    printf("  GPGGA-TIME, GPGGA-GPSQ, GPGGA-NLOCK, MACM-TIME, MACM-NLOCK,");
    /* for (int i = 0; i < 12; ++i) { */
    /*   printf(" PRN[%02d], CN0[%02d],", i, i); */
    /* } */
    for (int i = 0; i < 12; ++i) {
      printf(" CN0[%02d],", i + 1);
    }
    for (int i = 0; i < 12; ++i) {
      printf(" PRN[%02d],", i + 1);
    }
    printf("\r\n");


  for (int j = 0; j < 15; ++j) {
    printf("%02u:%02u:%02u.%03u, %10u, %11u, %9u, %10u,", 1, 2, 3, 4, 5, 6, 7,
           12);
    for (int i = 0; i < 12; ++i) {
      printf(" %7d, %7d,", i, i * 14);
    }
    printf("\r\n");
  }

  return 0;
}
