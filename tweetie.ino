/*
  Tweetie
  makes bird chirp ever other second

  modified 25 Apr 2016
  by Amy Wibowo
 */

// the setup function runs once when you press reset or power the board
void setup() {
  // initialize output pins
  pinMode(12, OUTPUT); //goes to bird switch
  pinMode(13, OUTPUT); //LED
}

// the loop function runs over and over again forever
void loop() {
  digitalWrite(12, HIGH); 
  // send on signal to the bird switch
  digitalWrite(13, HIGH); 
  // turn the LED on for debug
  delay(1000); // wait for 1 seconds

  digitalWrite(12, LOW);  
  // send off signal to the bird switch
  digitalWrite(13, LOW);   
  // turn the LED off
  delay(5000); // wait for 5 seconds
 }
}
