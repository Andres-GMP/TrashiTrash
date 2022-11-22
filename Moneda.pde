class Moneda extends Animacion
{
  int tipo;
  Moneda(PImage img, int _tipo)
  {
    super(img);
    tipo = _tipo;//tipo agua
    if(tipo ==0)
    {
      quieto = new LeerArchivo(5,2,"CoinTaco.png").getHoja();
    }
    else
    {
      quieto = new LeerArchivo(5,2,"CoinIce.png").getHoja();
    }
    actual = quieto;
  }
}
