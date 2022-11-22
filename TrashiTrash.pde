import ddf.minim.*;

Minim minim,minim2;
AudioPlayer[] jump,btc;

Nivel nivel;
PImage[] personaje, collected;
Player player;
Transicion shift;//-------

ArrayList<Sprite> plataforma,coin,decoracion,mar,enemigo,frenteAgua;
ArrayList<Recolectar> juntar;
final static int normal = 0;
final static int derecha = 1;
final static int izquierda = 2;
final static float salto = 12;
final static float gravedad = 0.6;
final static float vel = 5;
final static float size_sprite = 32;
final static float der_margen = 400;
final static float izq_margen = 32;
final static float vert_margen = 40;
float view_x = 0;
float view_y = 0;
Informacion info;

/*
Método setup:
  Inicializa las variables con un valor en concreto para no cargar espacio en memoria con cada iteración de <draw()>
*/
void setup()
{
  size(800,511);

  minim = new Minim(this);
  btc = new AudioPlayer[5];
  btc[0] = minim.loadFile("coin.wav");
  //jump
  btc[1]= minim.loadFile("jump.wav");
  btc[2]= minim.loadFile("DanceAround.wav");
  btc[3]= minim.loadFile("Win.wav");
  btc[4]= minim.loadFile("Oops.wav");
  imageMode(CENTER);
  //------------
  frenteAgua = new ArrayList<Sprite>();
  nivel = new Nivel();
  collected = new LeerArchivo(6,3,"Collected.png").getHoja();
  // Este es el ScriptSheet de 4 columnas y 12 filas para el personaje, es una array
  personaje = new LeerArchivo(4,12,"Trashi32.png").getHoja();
  // Se crea el personaje con su constructor
  player = new Player(personaje[0]);
  player.center.x = 65;
  player.center.y =  100;
  juntar = new ArrayList<Recolectar>();
  info = new Informacion();
}


  /**
  * Método draw, iterará hasta al final para cargar los cambios.
  */
void draw()
{
  if(!btc[2].isPlaying())
  {
     btc[2].setGain(-30);//bajar volumen
     btc[2].play(1);
  }
  background(178,255,255);
  shift.mostrar();
  
  if(!shift.visible)
  {
  scroll();
  nivel.mostrar();
  player.mostrarSombra();
  player.mostrar();
  player.actualizar();
  for(Sprite a: mar)
  {
    a.mostrar();
    ((Animacion)a).actualizar();
  }
  resolverColision(player,plataforma);
  reset();
  for(Sprite fa: frenteAgua)
    fa.mostrar();
  //borrar los objetos de recolectar
  int total = 0;
  for(Recolectar r: juntar)
  {
    r.mostrar();
    if(!r.estado)
      total ++;
  }
  if(total == juntar.size())//comparar la cantidad de elementos inactivos y borrar todo
    juntar.removeAll(juntar);
    
  info.mostrar();
    if(player.center.x > 4531)//llego a la meta
    {
      nivel.cambiarNivel();
    }
  }
}

  /**
  * Método scroll, ayudará al movimiento del foco de la camara.
  */
void scroll()
{
  //Para avanzar en el escenario
  float der_dimension = view_x + width - der_margen;
  if(player.getRight() > der_dimension)
  {
    if(view_x < 3700) 
      view_x += player.getRight() - der_dimension;
    
  }
  //Regresar a la izquierda del escenario
  float izq_dimension = view_x + izq_margen;
  if(player.getLeft() < izq_dimension)
  {
    if(view_x > 0)
    view_x -= izq_dimension - player.getLeft();
  }
  float piso_dimension = view_y + height - vert_margen+10;
  if(player.getBottom() > piso_dimension)
  {
    //view_y += player.getBottom() - piso_dimension;
  }
  float techo_dimension = view_y + vert_margen;
  if(player.getTop() < techo_dimension)
  {
    //view_y -= techo_dimension - player.getTop();
  }
  translate(-view_x,-view_y);
}

  /**
  * Método para medir la colisión del personaje con el objeto <Agua>
  */
boolean tocado(Sprite s1, Sprite s2)
{
   boolean tocarX = s1.getRight() <= s2.getLeft() || s1.getLeft() >= s2.getRight(); 
   boolean tocarY = s1.getBottom() <= s2.getTop() || s1.getTop() >= s2.getBottom();
   if(tocarX || tocarY)
     return false;
   else
   {
     if(s2.num == 13 && ((Player)s1).estado == 0)//si la gota toca el agua fria
       return false;
     else 
     {
       if(s2.num == 31 && ((Player)s1).estado == 1)//si el agua es caliente y toca el hielo
       {
         player.estado = 0;
         player.cargaEstado();
       }
       return true;
     }
   }
}


  /**
  * Método para 
  */
ArrayList<Sprite> tocandoLista(Sprite s, ArrayList<Sprite> lista)
{
  ArrayList<Sprite> listaTocada = new ArrayList<Sprite>();
  for(Sprite p: lista)
  {
    if(tocado(s,p))
      listaTocada.add(p);
  }
  return listaTocada;
}
//-----------fin metodo tocando lista
void resolverColision(Sprite s, ArrayList<Sprite> lista)
{
  s.cambio.y += gravedad;
  s.center.y += s.cambio.y;
  ArrayList<Sprite> colLista = tocandoLista(s,lista);
  if(colLista.size() > 0)
  {
    Sprite colision = colLista.get(0);
    if(s.cambio.y > 0)
    {
      s.setBottom(colision.getTop());
    }
    else if(s.cambio.y < 0)
    {
      s.setTop(colision.getBottom());
    }
    s.cambio.y = 0;
  }
  s.center.x += s.cambio.x;
  colLista = tocandoLista(s,lista);
  if(colLista.size() > 0)
  {
    Sprite colision = colLista.get(0);
    if(s.cambio.x > 0)
    {
      s.setRight(colision.getLeft());
    }
    else if(s.cambio.x < 0)
    {
      s.setLeft(colision.getRight());
    }
    s.cambio.x = 0;
    //-------------para los enemigos
    if(s.tipo > 0)
      ((Enemigo)s).invertir();
  }
}
boolean estaEnPlataforma(Sprite s, ArrayList<Sprite> pared)
{
  s.center.y += 5;
  ArrayList<Sprite> col_lista = tocandoLista(s,pared);
  s.center.y -= 5;
  if(col_lista.size()>0)
    return true;
  else
    return false;
}
void keyPressed()
{
  if(keyCode == RIGHT)
    player.cambio.x = vel;
  else if(keyCode == LEFT)
    player.cambio.x = -vel;
  else if(keyCode == UP && estaEnPlataforma(player,plataforma))
  {
    btc[1].play(1);
    player.cambio.y = -salto;
  }
}
void keyReleased()
{
  if(keyCode == RIGHT)
    player.cambio.x = 0;
  else if(keyCode == LEFT)
    player.cambio.x = 0;
  else if(keyCode == UP)
    player.cambio.y = 0;
}
void reset()
{
  if(player.center.y>height)
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
