#include <ESP32Servo.h>
#include <XboxSeriesXControllerESP32_asukiaaa.hpp>
XboxSeriesXControllerESP32_asukiaaa::Core xboxController("3c:fa:06:46:81:6d");

Servo arm;
Servo shoulder;
Servo base;
Servo door;
Servo gripL;
Servo gripR;
int up1 = 0;
int up2 = 137;
int up_door = 136;
int up_grip1 = 78;
int up_grip2 = 78;
int armSpeed = 1;  // Adjust the speed factor to control arm movement speed

//Right motor
int enableRightMotor = 22;  // back right motor
int rightMotorPin1 = 16;
int rightMotorPin2 = 17;

int enableRightMotor2 = 14;  // front right motor
int rightMotorPin1_2 = 26;
int rightMotorPin2_2 = 27;

//Left motor
int enableLeftMotor = 23;  //  back left motor
int leftMotorPin1 = 18;
int leftMotorPin2 = 19;

int enableLeftMotor2 = 32;  // front left motor
int leftMotorPin1_2 = 33;
int leftMotorPin2_2 = 25;

const int PWMFreq = 1000; /* 1 KHz */
const int PWMResolution = 8;

const int rightMotorPWMSpeedChannel1 = 4;
const int rightMotorPWMSpeedChannel2 = 6;
const int leftMotorPWMSpeedChannel1 = 5;
const int leftMotorPWMSpeedChannel2 = 7;

void loop() {
  xboxController.onLoop();
  if (xboxController.isConnected()) {
    if (xboxController.isWaitingForFirstNotification()) {
      Serial.println("waiting for first notification");
    }



    // ... (other button checks and servo movements)


    int rightMotorSpeed, leftMotorSpeed;
    leftMotorSpeed = -xboxController.xboxNotif.joyLVert + 32000;   //Left stick  - y axis - forward/backward left motor movement
    rightMotorSpeed = -xboxController.xboxNotif.joyRVert + 32000;  //Right stick - y axis - forward/backward right motor movement

    int rightMotorSpeedX, leftMotorSpeedX;
    rightMotorSpeedX = xboxController.xboxNotif.joyRHori - 32000;  //Left stick  - y axis - forward/backward left motor movement
    leftMotorSpeedX = xboxController.xboxNotif.joyLHori - 32000;   // Right stick - x axis

    // Uncomment the lines below to print joystick values for debugging
    Serial.println("Right Motor Speed in Y");
    Serial.println(rightMotorSpeed);
    Serial.println("Right Motor Speed in X");
    Serial.println(rightMotorSpeedX);

    rotateMotor(rightMotorSpeed, leftMotorSpeed, rightMotorSpeedX, leftMotorSpeedX);
  } else {
    Serial.println("not connected");
    if (xboxController.getCountFailedConnection() > 2) {
      ESP.restart();
    }
  }
}

void rotateMotor(int rightMotorSpeed, int leftMotorSpeed, int rightMotorSpeedX, int leftMotorSpeedX) {
  // Motor control based on y-axis joystick input
  if (xboxController.xboxNotif.btnDirUp and up1 < 180) {
    arm.write(up1);
    up1 = up1 + armSpeed;
    Serial.println(up1);
    delay(10);  // Introduce a delay to control arm movement speed
  } else if (xboxController.xboxNotif.btnDirDown and up1 > 0) {
    arm.write(up1);
    up1 = up1 - armSpeed;
    Serial.println(up1);
    delay(10);  // Introduce a delay to control arm movement speed
  } else if (xboxController.xboxNotif.btnDirRight) {
    base.write(87);  // Introduce a delay to control arm movement speed
  } else if (xboxController.xboxNotif.btnDirLeft) {
    base.write(99);  // Introduce a delay to control arm movement speed
  } else if (xboxController.xboxNotif.btnA and up2 < 150) {
    shoulder.write(up2);
    up2 = up2 + armSpeed;
    Serial.println(up2);
    delay(10);  // Introduce a delay to control arm movement speed
  } else if (xboxController.xboxNotif.btnY and up2 > 0) {
    shoulder.write(up2);
    up2 = up2 - armSpeed;
    Serial.println(up2);
    delay(10);
  } else if (xboxController.xboxNotif.btnLB and up_door < 150) {
    door.write(up_door);
    up_door = up_door + armSpeed;
    Serial.println(up_door);
    delay(10);  // Introduce a delay to control arm movement speed
  } else if (xboxController.xboxNotif.btnRB and up_door > 0) {
    door.write(up_door);
    up_door = up_door - armSpeed;
    Serial.println(up_door);
    delay(10);
  } else if (xboxController.xboxNotif.trigLT and up_grip1 < 150) {
    gripR.write(up_grip1);
    gripL.write(up_grip2);
    up_grip1 = up_grip1 + armSpeed;
    up_grip2 = up_grip2 - armSpeed;
    Serial.println(up_grip1);
    delay(10);  // Introduce a delay to control arm movement speed
  } else if (xboxController.xboxNotif.trigRT and up_grip1 > 99) {
    gripR.write(up_grip1);
    gripL.write(up_grip2);
    up_grip1 = up_grip1 - armSpeed;
    up_grip2 = up_grip2 + armSpeed;
    Serial.println(up_grip1);
    delay(10);
  } else if (xboxController.xboxNotif.btnB) {
    shoulder.write(137);
    arm.write(0);
    up1 = 0;
    up2 = 137;
    delay(10);  // Introduce a delay to control arm movement speed
  } else {
    base.write(91);
  }
  if (rightMotorSpeed > 18000) {
    digitalWrite(rightMotorPin1, LOW); // backward
    digitalWrite(rightMotorPin2, HIGH);
    digitalWrite(rightMotorPin1_2, LOW);
    digitalWrite(rightMotorPin2_2, HIGH);
  } else if (rightMotorSpeed < -18000) {
    digitalWrite(rightMotorPin1, HIGH); // front 
    digitalWrite(rightMotorPin2, LOW);
    digitalWrite(rightMotorPin1_2, HIGH);
    digitalWrite(rightMotorPin2_2, LOW);
  } else {
    digitalWrite(rightMotorPin1, LOW); // no movement
    digitalWrite(rightMotorPin2, LOW);
    digitalWrite(rightMotorPin1_2, LOW);
    digitalWrite(rightMotorPin2_2, LOW);
  }

  // Motor control based on x-axis joystick input for right motor
  if (rightMotorSpeedX > 18000) {
    digitalWrite(rightMotorPin1, HIGH);  // left movement
    digitalWrite(rightMotorPin2, LOW);
    digitalWrite(rightMotorPin1_2, LOW);
    digitalWrite(rightMotorPin2_2, HIGH);
  } else if (rightMotorSpeedX < -18000) {
    digitalWrite(rightMotorPin1, LOW);  // right movement
    digitalWrite(rightMotorPin2, HIGH);
    digitalWrite(rightMotorPin1_2, HIGH);
    digitalWrite(rightMotorPin2_2, LOW);
  }

  // Motor control based on y-axis joystick input for left motor
  if (leftMotorSpeed > 18000) {
    digitalWrite(leftMotorPin1, LOW); // backward
    digitalWrite(leftMotorPin2, HIGH);
    digitalWrite(leftMotorPin1_2, LOW);
    digitalWrite(leftMotorPin2_2, HIGH);
  } else if (leftMotorSpeed < -18000) {
    digitalWrite(leftMotorPin1, HIGH);
    digitalWrite(leftMotorPin2, LOW); // front
    digitalWrite(leftMotorPin1_2, HIGH);
    digitalWrite(leftMotorPin2_2, LOW);
  } else {
    digitalWrite(leftMotorPin1, LOW);
    digitalWrite(leftMotorPin2, LOW);
    digitalWrite(leftMotorPin1_2, LOW);
    digitalWrite(leftMotorPin2_2, LOW);
  }
  // ... (unchanged code)

  // Motor control based on x-axis joystick input for left motor
  if (leftMotorSpeedX > 18000) {
    digitalWrite(leftMotorPin1, LOW);  // left movement
    digitalWrite(leftMotorPin2, HIGH);
    digitalWrite(leftMotorPin1_2, HIGH);
    digitalWrite(leftMotorPin2_2, LOW);
  } else if (leftMotorSpeedX < -18000) {
    digitalWrite(leftMotorPin1, HIGH);  // right movement
    digitalWrite(leftMotorPin2, LOW);
    digitalWrite(leftMotorPin1_2, LOW);
    digitalWrite(leftMotorPin2_2, HIGH);
  }

  ledcWrite(rightMotorPWMSpeedChannel1, abs(rightMotorSpeed));
  ledcWrite(rightMotorPWMSpeedChannel2, abs(rightMotorSpeed));
  ledcWrite(leftMotorPWMSpeedChannel1, abs(leftMotorSpeed));
  ledcWrite(leftMotorPWMSpeedChannel2, abs(leftMotorSpeed));

  Serial.print("Left Motor Speed: ");
  Serial.println(leftMotorSpeed);
  Serial.print("Left Motor Speed: ");
  Serial.println(leftMotorSpeedX);
  delay(20);
}

void setUpPinModes() {
  pinMode(enableRightMotor, OUTPUT);
  pinMode(rightMotorPin1, OUTPUT);
  pinMode(rightMotorPin2, OUTPUT);

  pinMode(enableRightMotor2, OUTPUT);
  pinMode(rightMotorPin1_2, OUTPUT);
  pinMode(rightMotorPin2_2, OUTPUT);

  pinMode(enableLeftMotor, OUTPUT);
  pinMode(leftMotorPin1, OUTPUT);
  pinMode(leftMotorPin2, OUTPUT);

  pinMode(enableLeftMotor2, OUTPUT);
  pinMode(leftMotorPin1_2, OUTPUT);
  pinMode(leftMotorPin2_2, OUTPUT);

  // Set up PWM for motor speed
  ledcSetup(rightMotorPWMSpeedChannel1, PWMFreq, PWMResolution);
  ledcSetup(rightMotorPWMSpeedChannel2, PWMFreq, PWMResolution);
  ledcSetup(leftMotorPWMSpeedChannel1, PWMFreq, PWMResolution);
  ledcSetup(leftMotorPWMSpeedChannel2, PWMFreq, PWMResolution);

  ledcAttachPin(enableRightMotor, rightMotorPWMSpeedChannel1);
  ledcAttachPin(enableRightMotor2, rightMotorPWMSpeedChannel2);
  ledcAttachPin(enableLeftMotor, leftMotorPWMSpeedChannel1);
  ledcAttachPin(enableLeftMotor2, leftMotorPWMSpeedChannel2);

  rotateMotor(0, 0, 0, 0);
}


void setup() {
  setUpPinModes();
  Serial.begin(115200);
  arm.attach(13);
  shoulder.attach(12);
  base.attach(15);
  door.attach(2);
  gripR.attach(4);
  gripL.attach(5);
  xboxController.begin();
  Serial.println("Ready.");
}
