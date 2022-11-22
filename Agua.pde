class Agua extends Animacion
{
  
  Agua(PImage img,PImage dos)
  {
    super(img);
    quieto = new PImage[2];
    quieto[0] = img;
    quieto[1] = dos;
    actual = quieto;
  }
}
