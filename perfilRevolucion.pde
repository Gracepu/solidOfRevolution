PShape obj;
int x, y, x0, y0, firstPress;
float z;
boolean startShape;
boolean drawn;
ArrayList<Vertex> v;
PFont f;

void setup() {
  size(700,700,P3D);
  background(255);
  stroke(200);
  fill(0);
  obj = createShape();
  startShape = false;
  drawn = false;
  v = new ArrayList();
  f = createFont("Subscribe.ttf",25);  // Source -> https://www.dafont.com/es/subscribe.font
  textFont(f);
}

void draw() {
  
  // Darle forma a la figura
  if(startShape && !drawn) {
    obj.beginShape(TRIANGLE_STRIP);
    float a = TWO_PI/36;
    for (int i = 0; i < v.size() - 1; i++) {
      for (int p = 0; p < 37; p++) {
        float x1 = v.get(i).getX() - width/2;
        float y1 = v.get(i).getY();
        float x11 = v.get(i+1).getX() - width/2;
        float y11 = v.get(i+1).getY();
        float x2 = x1*cos(p*a) - z*sin(p*a);
        float z2 = x1*sin(p*a) + z*cos(p*a);
        float x22 = x11*cos(p*a) - z*sin(p*a);
        float z22 = x11*sin(p*a) + z*cos(p*a);
        obj.vertex(x2,y1,z2);
        obj.vertex(x22,y11,z22);
      }
    }
    obj.endShape();
    drawn = true;
    
    // Dibujar la figura
  } else if(startShape && drawn) {
    background(128);
    translate(mouseX,mouseY - 150);
    shape(obj);
    
    // Instrucciones y lienzo
  } else {
    text("From silhouette to 3D!",10,230);
    text("1. Use the right side",15,280);
    text("2. Left click to draw",15,310);
    text("3. Right click to make it 3D",15,340);
    text("4. Right click again: new silhouette",15,370);
    line(width/2,0,width/2,height);  // Línea central de perfil
    drawn = false;
  }
}

void mouseClicked() {
  
  // Se ha entrado al modo de figura
  if(mouseButton == RIGHT && v.size() > 0) {
    startShape = !startShape;
    if (!startShape) {
      reset();
    }
  }
  
  // Se ha pintado el primer punto válido
  if(firstPress == 0 && mouseButton != RIGHT) {
    if(mouseX > width/2 - 10) {
      x0 = mouseX;
      y0 = mouseY;
      point(x0, y0);
      v.add(new Vertex(x0,y0));
      firstPress++;
    }
    
  }
  
  // Se pintan los siguientes puntos válidos
  if(firstPress == 1 && mouseButton != RIGHT) {
    if(mouseX > width/2 - 10) {
      x = mouseX;
      y = mouseY;
      point(x, y);
      v.add(new Vertex(x,y));
      line(x0, y0, x, y);
      x0 = x;
      y0 = y;
    }
    
  }
}

// Se regresa al estado de lienzo para pintar otra silueta
void reset() {
  firstPress = 0;
  background(255);
  obj = createShape();
  v = new ArrayList();
}
