/**
* Clase animacion que hereda de Sprite
*/
class Animacion extends Sprite
{
  // Matrices de imagenes
  PImage[] actual,quieto,moverIzq,moverDer;
  int dir, index, frame;
  
  /**
  * Método constructor Animacion
  */
  Animacion(PImage img)
  {
    super(img,0);
    dir = normal;
    index = 0;
    frame = 0;
  }
  /**
  * Método actualizar, recorre los frames constantemente, con los siguientes pasos:
  * 1- ¿Hacia que dirección apunta el personaje? utiliza el vector de cambio para detectar el movimiento
  * 2- Asigna un valor a la imagen que se presenta actualmente <actual> dependiendo la dirección
  * 3- Carga el sprite actual en la matriz de <actual[index]> con un indice asignado por <index>
  * Cada 8 frames va realizar la acción que le corresponde
  */
  void actualizar()
  {
    frame ++;
    if(frame % 8 == 0)
    {
      seleccionarDireccion();
      seleccionarImagenActual();
      avanzaImagen();
    }
  }

  /**
  * Método para seleccionar hacía donde apunta nuestro sprite de personaje.
  */
  void seleccionarDireccion()
  {
    if(cambio.x > 0)
      dir = derecha;
    else if(cambio.x < 0)
      dir = izquierda;
    else
      dir = normal;
  }
  
  /**
  * Método para seleccionar la imagen de srpite que se debe mostrar.
  */
  void seleccionarImagenActual()
  {
    if(dir == izquierda)
      actual = moverIzq;
    else if(dir == derecha)
      actual = moverDer;
    else
      actual = quieto;
  }
  
  /**
  * Método para recorrer el indice de sprites que contiene la matriz.
  */
  void avanzaImagen()
  {
    index++;
    if(index >= actual.length)
      index = 0;
    img = actual[index];
  }
}
