class Nivel
{
  Fondo lv1;
  int mapa;
  Nivel()
  {
    mapa = 0;
    lv1 = new Fondo("mapa0.csv","Background.png",32);
  }
  void mostrar()
  {
    lv1.mostrar();
  }
  void cambiarNivel()
  {
    plataforma.removeAll(plataforma);
    coin.removeAll(coin);
    decoracion.removeAll(decoracion);
    mar.removeAll(mar);
    enemigo.removeAll(enemigo);
    frenteAgua.removeAll(frenteAgua);
    mapa++;
    player.center.x = 65;
    view_x = 0;
    lv1 = new Fondo("mapa"+mapa+".csv","Background.png",32);
  }
}
