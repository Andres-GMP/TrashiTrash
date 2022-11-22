class Enemigo extends Animacion
{
  PImage[] iceImg;
  int dir, clase;
  Enemigo(PImage ene, int esUn)
  {
    super(ene);
    shift = new Transicion();
    tamanio.x = 43;
    tamanio.y = 37;
    tipo = 1;
    clase = esUn;
    dir = izquierda;
    cambio.x = -1;
    iceImg = new LeerArchivo(8,3,"nieve.png").getHoja();
    quieto = new PImage[1];
    quieto[0] = iceImg[0];
    if(clase == 1)//nieve
    {
      moverDer = new PImage[8];
      moverIzq = new PImage[8];
      moverDer[0] = iceImg[0];
      moverDer[1] = iceImg[1];
      moverDer[2] = iceImg[2];
      moverDer[3] = iceImg[3];
      moverDer[4] = iceImg[4];
      moverDer[5] = iceImg[5];
      moverDer[6] = iceImg[6];
      moverDer[7] = iceImg[7];
      moverIzq[0] = iceImg[8];
      moverIzq[1] = iceImg[9];
      moverIzq[2] = iceImg[10];
      moverIzq[3] = iceImg[11];
      moverIzq[4] = iceImg[12];
      moverIzq[5] = iceImg[13];
      moverIzq[6] = iceImg[14];
      moverIzq[7] = iceImg[15];
    }
    else if(clase == 2)
    {
      moverDer = new PImage[4];
      moverIzq = new PImage[4];
      moverDer[0] = iceImg[20];
      moverDer[1] = iceImg[21];
      moverDer[2] = iceImg[22];
      moverDer[3] = iceImg[23];
      moverIzq[0] = iceImg[16];
      moverIzq[1] = iceImg[17];
      moverIzq[2] = iceImg[18];
      moverIzq[3] = iceImg[19];
    }
    actual = moverIzq;
  }
  @Override
  void mover()
  {
    actualizar();
    resolverColision(this,plataforma);
    if(tocado(player,this))
    {
      if(player.estado == 0 && num == 49)
      {
         player.estado = 1;
         player.cargaEstado();
      }
      else if(player.estado == 0 && num == 50)
      {
        btc[4].play(1);
        shift.activar();
        player.center.x = 65;
        player.center.y =  100;
        view_x = 0;
        view_y = 0;
        player.vidas--;
      }
    }
    center.x += cambio.x;
    center.y += cambio.y;
  }
  void invertir()
  {
    if(dir == izquierda) 
    {
      dir = derecha;
      cambio.x = 1;
    }
    else if(dir == derecha) 
    {
      dir = izquierda;
      cambio.x = -1;
    }
  }
}
