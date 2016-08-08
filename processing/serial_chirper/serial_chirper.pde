import processing.serial.*;

Serial usbPort;
boolean serialInited;
PApplet context;

void setup() {
  println("listing serial ports");
  println(usbPort.list());
  usbPort = new Serial (this, Serial.list()[3], 9600);
  delay(2000);
}

void draw () {
  println("About to write to the serial port!");
  usbPort.write('N');
  delay(7000);
}