/*
  Literal Twitter Bot
  makes bird chirp when it receives a character from processing

  modified 25 Apr 2016
  by Amy Wibowo
 */

int incomingByte = 0;   // for incoming serial data from processing

// the setup function runs once when you press reset or power the board
void setup() {
  // initialize output pins
  pinMode(12, OUTPUT); //goes to toy bird
  pinMode(13, OUTPUT); //LED

  Serial.begin(9600);     // opens serial port, sets data rate to 9600 bps
}

// the loop function runs over and over again forever
void loop() {

  // send data only when you receive data:
    if (Serial.available() > 0) {
      incomingByte = Serial.read();

      if (incomingByte == 'N') {
        digitalWrite(12, HIGH);   // send the on signal to the bird
        digitalWrite(13, HIGH);   // turn the LED on for debugging
        delay(1000);              // wait for a second
        digitalWrite(12, LOW);    // send the off signal to the bird
        digitalWrite(13, LOW);   // turn the LED off
        delay(1000);
      }
    }
    delay(100); //pause between attempts to read the serial port
}