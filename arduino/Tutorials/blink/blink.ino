
void setup() {
    pinMode(LED_BUILTIN, OUTPUT);
}

int count = 10000;

void loop() {
    digitalWrite(LED_BUILTIN, HIGH);
    delay(count);
    delay(10);
    digitalWrite(LED_BUILTIN, LOW);
    delay(count);
    delay(10);
    count /= 2;
    if (count <= 5) {
        count = 10000;
    }
}
