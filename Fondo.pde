class Fondo
{
  PImage mySprite[], bgFondo;
  float sizeSprite;
  Fondo(String name, String tilemap, float size)
  {
    sizeSprite = size;
    mySprite = new LeerArchivo(8,5,tilemap).getHoja();
    plataforma = new ArrayList<Sprite>();
    //------------------ copiar
    coin = new ArrayList<Sprite>();
    decoracion = new ArrayList<Sprite>();
    mar = new ArrayList<Sprite>();
    enemigo = new ArrayList<Sprite>();
    //------------------
    bgFondo = loadImage("Background.png");
    crearPlataforma(name);
  }
  void mostrar()
  {// reemplazar width/2 por view_x ------------
    image(bgFondo,view_x+width/2,height/2-130);
    //-------copiar
    for(Sprite d: decoracion)
      d.mostrar();
    //----------------
    for(Sprite p: plataforma)
      p.mostrar();
    ////---------------agregar todo lo de abajo
    for(Sprite m: coin)
    {
      m.mostrar();
      ((Animacion)m).actualizar();
    }
    
    ArrayList<Sprite> recoleccion = tocandoLista(player, coin);
    if(recoleccion.size() > 0)
    {
      for(Sprite r: recoleccion)
      {
        if(((Moneda)r).tipo == 0 && player.estado == 0)
        {
          btc[0].play(1);//tocar sonido al recolectar las monedas
          juntar.add(new Recolectar(r.center.x,r.center.y,0));
          coin.remove(r);
          info.sumar();
        }
        
        if(((Moneda)r).tipo == 1 && player.estado == 1)
        {
          btc[0].play(1);//tocar sonido al recolectar las monedas
          juntar.add(new Recolectar(r.center.x,r.center.y,1));
          coin.remove(r);
          info.sumar();
        }
          
        if(((Moneda)r).tipo == 2 && player.estado == 2)
        {
          btc[0].play(1);//tocar sonido al recolectar las monedas
          juntar.add(new Recolectar(r.center.x,r.center.y,2));
          coin.remove(r);
          info.sumar();
        }
      }  
    }
    for(Sprite e: enemigo)
    {
      e.mostrar();
      e.mover();
    }
  }
  void crearPlataforma(String archivo)
  {
    String[] lineas = loadStrings(archivo);
    for(int row = 0; row < lineas.length; row++)
    {
      String[] valores = split(lineas[row],";");
      for(int col = 0; col < valores.length; col++)
      {
        int num = obtenerNum(valores[col]);
        if(num < 13)
        {
          Sprite s = new Sprite(mySprite[num],num);
          s.center.x = sizeSprite/2 + col * sizeSprite;
          s.center.y = sizeSprite/2 + row * sizeSprite;
          plataforma.add(s);
        }
        else if(num == 13)
        {
          
          Sprite s = new Sprite(mySprite[num],num);
          s.center.x = sizeSprite/2 + col * sizeSprite;
          s.center.y = sizeSprite/2 + row * sizeSprite;
          frenteAgua.add(s);
          plataforma.add(s);
        }
        else if(num == 14 || num == 29 || num == 38)
        {
          Agua a = new Agua(mySprite[num],mySprite[num+1]);
          a.center.x = sizeSprite/2 + col * sizeSprite;
          a.center.y = sizeSprite/2 + row * sizeSprite;
          mar.add(a);
        }
        else if(num == 16)//----------------
        {
          Moneda c = new Moneda(mySprite[num],0);
          c.center.x = sizeSprite/2 + col * sizeSprite;
          c.center.y = sizeSprite/2 + row * sizeSprite;
          coin.add(c);
        }
        else if(num == 17)//----------------
        {
          Moneda c = new Moneda(mySprite[num],1);
          c.center.x = sizeSprite/2 + col * sizeSprite;
          c.center.y = sizeSprite/2 + row * sizeSprite;
          coin.add(c);
        }
        else if(num == 49)
        {
          Enemigo n = new Enemigo(mySprite[31],1);
          n.center.x = sizeSprite/2 + col * sizeSprite;
          n.center.y = sizeSprite/2 + row * sizeSprite;
          n.tipo = 1;
          n.num = 49;
          enemigo.add(n);
        }
        else if(num == 50)
        {
          Enemigo n = new Enemigo(mySprite[31],2);
          n.center.x = sizeSprite/2 + col * sizeSprite;
          n.center.y = sizeSprite/2 + row * sizeSprite;
          n.tipo = 1;
          n.num = 50;
          enemigo.add(n);
        }
        else if(num == 31)
        {
          Sprite d = new Sprite(mySprite[13],num);
          d.center.x = sizeSprite/2 + col * sizeSprite;
          d.center.y = sizeSprite/2 + row * sizeSprite;
          plataforma.add(d);
        }
        else if(num > 18)
        {
          Sprite d = new Sprite(mySprite[num],0);
          d.center.x = sizeSprite/2 + col * sizeSprite;
          d.center.y = sizeSprite/2 + row * sizeSprite;
          decoracion.add(d);
        }
        
      }
    }
  }
  int obtenerNum(String txt)
  {
    int num = 0;
    num = Integer.valueOf(txt);
    return num;
  }
}
