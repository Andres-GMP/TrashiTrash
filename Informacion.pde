class Informacion
{
  PImage[] img;
  int puntaje;
  Informacion()
  {
    img = new LeerArchivo(3,1,"icono.png").getHoja();
    puntaje = 0;
  }
  void mostrar()
  {
    fill(191,219,249);
    rect(view_x+3,3,70,35,10);
    image(img[player.estado],view_x+20,20);
    fill(0);
    textSize(20);
    text("x"+player.vidas,view_x+40,30);
    fill(191,219,249);
    rect(view_x+width/2-8,3,40,35,10);
    fill(0);
    String txt = nf(puntaje,2);
    text(txt,view_x+width/2,30);
  }
  void sumar()
  {
    puntaje++;
    if(puntaje == 100)
    {
      puntaje = 0;
      player.vidas++;
    }
  }
}
