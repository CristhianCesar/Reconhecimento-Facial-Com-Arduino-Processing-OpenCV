/** ===========================================================================
 * @ Software: Reconhecimento Facial
 * @ Data: 08 de março de 2016
 * @ Versao: 0.1
 * @ Developer: Rodrigues F.A.S.
 * @ Site: https://rodriguesfas.github.io
 * =========================================================================================
 */


// Inclui as bibliotecas..
#include <Servo.h>
#include <ThreadController.h>
#include <Thread.h>

// Cria os objetos dos servos motores(controladores)..
Servo servoHor;
Servo servoVer;

// Define uma posiçao inicial para cada servo motor..
int valorHor = 90;
int valorVer = 90;

ThreadController cpu;
Thread threadServos;

int dados;

/**
 * setup - Configuraçoes iniciais.
 */
void setup() {
  Serial.begin(9600); // Inicia uma comunicaço serial..

  // Define a configuraçao das portas em que os servos estao conectados...
  servoHor.attach(10);
  servoVer.attach(11);

  threadServos.setInterval(15); // tempo de espera.
  threadServos.onRun(lerServos); // metodo solicitador.

  // adiciona thread filha a mae.
  cpu.add(&threadServos);
}

/**
 * loop
 */
void loop() {
  cpu.run(); // start thread System.
}

/**
 * lerServos - 
 */
void lerServos(){
  if (Serial.available() > 0) {
    dados = Serial.read();// leitura da porta serial..
    switch (dados) {
    case 'a' : 
      if (valorHor >= 180) {
        valorHor = 180;
      } 
      else {
        valorHor += 1;
      }
      break;

    case 'd' :
      if (valorHor <= 0) {
        valorHor = 0;
      } 
      else {
        valorHor -= 1;
      }
      break;

    case 's' :
      if (valorVer >= 180) {
        valorVer = 180;
      } 
      else {
        valorVer += 1;
      }
      break;

    case 'w' :
      if (valorVer <= 0) {
        valorVer = 0;
      } 
      else {
        valorVer -= 1;
      }
      break;
    }

    // estabelece um posiço no servo de acordo com o valor de "val"
    servoHor.write(valorHor);
    servoVer.write(valorVer);

    //Serial.print(valorHor);
    //Serial.print(valorVer);
  }
}


