/** ===========================================================================
 * @ Software: Reconhecimento Facial
 * @ Data: 08 de março de 2016
 * @ Versao: 0.1
 * @ Developer: Rodrigues F.A.S.
 * @ Site: https://rodriguesfas.github.io
 * =========================================================================================
 */

// Inclui as bibliotecas..
import gab.opencv.*;
import processing.video.*;
import java.awt.Rectangle;
import processing.serial.*;

Capture video; // Conexao com webcam
OpenCV opencv; // Cerebro
Serial arduinoPort; // Porta comunicação com arduino.. 

/**
 * setup -  configuração incial...
 */
void setup() {
  size(320, 240); /*tamanho da tela.. */
  println(Serial.list()); /* lista todas as portas seriais.. */
  arduinoPort = new Serial(this, Serial.list()[0], 9600); /* configura porta serial.. */
  //frameRate(10);

  String[] cameras = Capture.list(); /* captura uma lista de webcam's ativas hardware.. */

  /* Verifica se existe alguma webcam disponivel.. */
  if (cameras.length == 0) {
    println("Não há câmeras disponíveis para a captura."); /* Notificação usuário.. */
    exit(); /* Feixa aplicação */
  } else { /* Se webcam disponivel .. */
    println("Câmeras disponíveis:"); /* Notifica ao usuário.. */

    video = new Capture(this, width, height);
    opencv = new OpenCV(this, width, height);
    opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);

    video.start(); /* inicia video captura.. */
  }
}

/**
 * draw
 */
void draw() {
  //scale(2);
  opencv.loadImage(video);
  image(video, 0, 0);
  Rectangle[] faces = opencv.detect();

  /*
  fill(255);
   rect(10, 210, 50, 30);
   rect(580, 210, 50, 30);
   
   fill(0);
   triangle(30, 215, 15, 225, 30, 235);
   triangle(610, 215, 610, 235, 625, 225);
   */

  noFill();
  stroke(0, 255, 0); /* cor das retas.. */
  strokeWeight(3); /* largura das retas */

  //println(faces.length);

  for (int i = 0; i < faces.length; i++) {
    // Imprime no monitor os valores das posições da face..
    //println(faces[i].x + "," + faces[i].y);

    rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);

    if (faces[i].x  < 80) {
      //println("Esquerda"); 
      arduinoPort.write("a");
    }
    if (faces[i].x + faces[i].width > 240) {
      //println("Direita"); 
      arduinoPort.write("d");
    }
    if (faces[i].y < 80) {
      //println("Cima"); 
      arduinoPort.write("w");
    }
    if (faces[i].y + faces[i].height > 160) {
      //println("Baixo"); 
      arduinoPort.write("s");
    }
  } /* FIM for */
} /* FIM draw */

/**
 * captureEvent
 */
void captureEvent(Capture c) {
  c.read();
}

/**
 * mousePressed
 */
/*
void mousePressed() {
 println("mouseX: "+mouseX +" mouseY: "+mouseY);
 
 //click da esquerda..
 if ((mouseX <= 60) && (mouseX >= 11) && (mouseY >= 211) && (mouseY <= 239)) {
 arduinoPort.write('e'); 
 println("ESQUERDA");
 }
 
 //Click da direita..
 if ((mouseX <= 630) && (mouseX >= 581) && (mouseY >= 211) && (mouseY <= 239)) {
 arduinoPort.write('d'); 
 println("DIREITA");
 }
 }
 */
