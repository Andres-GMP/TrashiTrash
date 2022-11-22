class Sprite
{
  PImage img;
  PVector center, cambio, tamanio;
  int tipo, num; //0 - Player y fondos - 1 enemigo 

  /**
  * Método constructor Sprite
  */
  Sprite(PImage archivo,float x,float y)
  {
    img = archivo;
    tamanio = new PVector(img.width,img.height);
    center = new PVector(x,y);
    cambio = new PVector(0,0);
    tipo = 0;
    num = 0;
  }
  /**
  * Método constructor Sprite
  */
  Sprite(PImage archivo, int pared)
  {
    img = archivo;
    tamanio = new PVector(img.width,img.height);
    center = new PVector(0,0);
    cambio = new PVector(0,0);
    tipo = 0;
    num = pared;
  }
  /**
  * Método constructor Sprite
  */
  Sprite(float x,float y)
  {
    img = new PImage();
    tamanio = new PVector(0,0);
    center = new PVector(x,y);
    cambio = new PVector(0,0);
    tipo = 0;
  }
    /**
  * Método mostrar, su función es mostrar la imagen que corresponde al sprite
  */
  void mostrar()
  {
    image(img,center.x,center.y);
  }
  /**
  * Método mover, este realiza el cambio de frame por sprite
  */
  void mover()
  {
    center.x += cambio.x;
    center.y += cambio.y;
  }

  //SECCION DE SETTERS & GETTERS: se utiliza para la información encapsulada de la clase.
  //Por cada método se carga un valor, ya se izquierda o derecha se almacenará en el vector <center> esto ayuda a la detección de colisión

  void setLeft(float left)
  {
    center.x = left + tamanio.x/2;
  }
  float getLeft()
  {
    return center.x - tamanio.x/2;
  }
   void setRight(float right)
  {
    center.x = right - tamanio.x/2;
  }
  float getRight()
  {
    return center.x + tamanio.x/2;
  }
  void setTop(float top)
  {
    center.y = top + tamanio.y/2;
  }
  float getTop()
  {
    return center.y - tamanio.y/2;
  }
  void setBottom(float bottom)
  {
    center.y = bottom - tamanio.y/2;
  }
  float getBottom()
  {
    return center.y + tamanio.y/2;
  }
}
