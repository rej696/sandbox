// Pins
const int ledPin = 9;
const int buttonPin = 8;
const int buzzerPin = 10;

// Variables
int fadeTime = 10; //ms 
int buttonState = 0;
int builtInState = 0;
int buzzerDelay = 100; //ms
int buzzerNote = 440;

// Calculate a logarhythmicly increasing LED using the following equation
// y = 2^(x/r) - 1 where r = ((mlog2)/(logp)) where p is max power (255) and m is number of steps

// The number of steps between the output being on and off
const int pwmIntervals = 100;
// The R value used in the graph calculation
float R; 

void setup() {
    // Initialise Pins
    pinMode(ledPin, OUTPUT);
    pinMode(LED_BUILTIN, OUTPUT);
    pinMode(buttonPin, INPUT_PULLUP);
    pinMode(buzzerPin, OUTPUT);
    digitalWrite(LED_BUILTIN, LOW);
    analogWrite(ledPin, 0);
    noTone(buzzerPin);
    Serial.begin(9600);

    // deterime R
    R = (pwmIntervals * log10(2))/(log10(255)); 
}

void doFade() {

    Serial.println("Begin Cycle");

    int brightness = 0;

    for (int i = 0; i <= pwmIntervals; i++) {
        // Calculate required PWM value for the brightness
        brightness = pow(2, (i / R)) - 1;
        
        analogWrite(ledPin, brightness);

        delay(fadeTime * 10); // ten ms

        Serial.println("LED Step: " + String(i));
        Serial.println("LED brightness: " + String(brightness));
    }
    
}

void loop() {
    buttonState = digitalRead(buttonPin);

    if (buttonState != LOW) {
        doFade();
        digitalWrite(LED_BUILTIN, HIGH);


        do {
            buttonState = digitalRead(buttonPin);
            noTone(buzzerPin);
            tone(buzzerPin, buzzerNote);
            delay(100);
            buttonState = digitalRead(buttonPin) || buttonState;
            noTone(buzzerPin);
            tone(buzzerPin, (buzzerNote + (buzzerNote/2)));
            delay(100);
            buttonState = digitalRead(buttonPin) || buttonState;
        } while (buttonState == LOW);
        digitalWrite(LED_BUILTIN, LOW);
        noTone(buzzerPin);
        delay(fadeTime * 10);
    }

    Serial.println("LED off");
    analogWrite(ledPin, 0);
    digitalWrite(LED_BUILTIN, LOW);

}
