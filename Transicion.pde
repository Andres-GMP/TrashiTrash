class Transicion
{
  int tamanio;
  boolean visible;
  Transicion()
  {
    tamanio = 1;
    visible = false;
  }
  void activar()
  {
    tamanio = 1;
    visible = true;
  }
  boolean desactivado()
  {
    if(tamanio >= 150)
    {
      visible = false;
      return false;
    }
    else
      return true;
  }
  void dibujarCuadro()
  {
    fill(0,200);
    for(int y = 0; y < height+80 ; y +=80)
    {
      for(int x = 0; x < width+80; x +=80)
      {
        circle(x,y,tamanio);//circle
      }
    }
  }
  void mostrar()
  {
    if(desactivado())
    {
      dibujarCuadro();
      tamanio += 5;
    }
  }
}
