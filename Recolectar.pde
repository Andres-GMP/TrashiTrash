class Recolectar
{
  PVector center;
  PImage[] img;
  int pos;
  boolean estado;
  Recolectar(float x, float y, int tipo)
  {
    img = new PImage[6];
    center = new PVector(x,y);
    pos = 0;
    estado = true;
    if(tipo == 2)
    {
      img[0] = collected[0];
      img[1] = collected[1];
      img[2] = collected[2];
      img[3] = collected[3];
      img[4] = collected[4];
      img[5] = collected[5];
    }
    else if(tipo == 0)
    {
      img[0] = collected[6];
      img[1] = collected[7];
      img[2] = collected[8];
      img[3] = collected[9];
      img[4] = collected[10];
      img[5] = collected[11];
    }
    else if(tipo == 1)
    {
      img[0] = collected[12];
      img[1] = collected[13];
      img[2] = collected[14];
      img[3] = collected[15];
      img[4] = collected[16];
      img[5] = collected[17];
    }
  }
  void mostrar()
  {
    if(estado)
    {
      if(frameCount % 6 == 0)
        pos++;
      if(pos < 6)
      image(img[pos],center.x, center.y);
      if (pos > 5)
      {
        pos = 0;
        estado = false;
      }
    }
  }
}
