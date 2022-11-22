  /**
  * Clase Player que hereda de Animacion
  */
class Player extends Animacion
{
  // Atributos del personaje
  int vidas, estado,timer;
  // Atributos para la detección de suelos en el personaje
  boolean enPlataforma, enPiso;
  // Matriz de imagenes cargadas desde el Sprite.
  PImage[] irDer, irIzq, saltoDer, saltoIzq;
  ArrayList<Sprite> sombra;
  
  /**
  * Método constructor Player
  */
  Player(PImage imagen)
  {
    super(imagen);
    sombra = new ArrayList<Sprite>();
    vidas = 3;
    timer = 0;//controlar la sombra por tiempo
    dir = derecha;
    estado = 0;
    enPlataforma = false;
    enPiso = false;
    irDer = new PImage[2];
    irIzq = new PImage[2];
    moverDer = new PImage[8];
    moverIzq = new PImage[8];
    saltoDer = new PImage[1];
    saltoIzq = new PImage[1];
    cargaEstado();
    actual = saltoDer;
  }

  /**
  * Método para cargar el estado del personaje con sus indices de Sprites.
  */
  void cargaEstado()
  {
    timer = 0;
    if(estado == 0)
    {
      saltoDer[0] = personaje[2];
      saltoIzq[0] = personaje[26];
      irIzq[0] = personaje[24];
      irIzq[1] = personaje[25];
      irDer[0] = personaje[0];
      irDer[1] = personaje[1];
      moverDer[0] = personaje[4];
      moverDer[1] = personaje[5];
      moverDer[2] = personaje[6];
      moverDer[3] = personaje[7];
      moverDer[4] = personaje[8];
      moverDer[5] = personaje[9];
      moverDer[6] = personaje[10];
      moverDer[7] = personaje[11];
      moverIzq[0] = personaje[28];
      moverIzq[1] = personaje[29];
      moverIzq[2] = personaje[30];
      moverIzq[3] = personaje[31];
      moverIzq[4] = personaje[32];
      moverIzq[5] = personaje[33];
      moverIzq[6] = personaje[34];
      moverIzq[7] = personaje[35];
    }
    else if(estado == 1)//hielo
    {
      saltoDer[0] = personaje[14];
      saltoIzq[0] = personaje[38];
      irIzq[0] = personaje[36];
      irIzq[1] = personaje[37];
      irDer[0] = personaje[12];
      irDer[1] = personaje[13];
      moverDer[0] = personaje[16];
      moverDer[1] = personaje[17];
      moverDer[2] = personaje[18];
      moverDer[3] = personaje[19];
      moverDer[4] = personaje[20];
      moverDer[5] = personaje[21];
      moverDer[6] = personaje[22];
      moverDer[7] = personaje[23];
      moverIzq[0] = personaje[40];
      moverIzq[1] = personaje[41];
      moverIzq[2] = personaje[42];
      moverIzq[3] = personaje[43];
      moverIzq[4] = personaje[44];
      moverIzq[5] = personaje[45];
      moverIzq[6] = personaje[46];
      moverIzq[7] = personaje[47];
    }
  }
  /**
  * Método que muestra la sombra
  */
  void mostrarSombra()
  {
    if(timer < 30)
    {
      tint(120,100); // Se usa de manera similar a lo que ya hemos visto para fill() y stroke(), pero afecta exclusivamente a las imágenes.
      if(frameCount % 4 == 0)
      {
        sombra.add(0, new Sprite(img,center.x,center.y));
        timer ++;
      }
      if(sombra.size() > 5)
        sombra.remove((sombra.size()-1));
        
      for(Sprite g: sombra)
        g.mostrar();
      noTint();
    }
    else
    {
      if(sombra.size()>0)
        sombra.removeAll(sombra);
    }
  }
  
  /**
  * Método para actualizar el estado del personaje, detecta si está en el piso o plataforma
  */
  @Override
  void actualizar()
  {
    enPlataforma = estaEnPlataforma(this,plataforma);
    enPiso = cambio.x == 0 && cambio.y == 0;
    super.actualizar();
    println("x:"+center.x+"  y:"+center.y);
  }
  
  /**
  * Método que realiza el cambio de dirección (es un método heredado)
  */
  @Override
  void seleccionarDireccion()
  {
    if(cambio.x > 0)
      dir = derecha;
    else if(cambio.x < 0)
      dir = izquierda;
  }
  
  /**
  * Método que selecciona la imagen actual dependiendo la dirección en que el personaje vaya
  */
  @Override
  void seleccionarImagenActual()
  {
    if(dir == derecha)
    {
      if(enPiso)
        actual = irDer;
      else if(!enPlataforma)
        actual = saltoDer;
      else
        actual = moverDer;
    }
    else if(dir == izquierda)
    {
      if(enPiso)
        actual = irIzq;
      else if(!enPlataforma)
        actual = saltoIzq;
      else
        actual = moverIzq;
    }
  }
}
