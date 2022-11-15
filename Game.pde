
Backgroundd lvl;

final static int normal = 0;
final static int right = 1;
final static int left = 2;
final static float right_margin = 400;
final static float left_margin = 32;
final static float see_image = 40;
final static float gravity = 0.6;
final static float jump = 5;
final static float vel = 5;
final static float size_sprite = 32;


float view_x = 0;
float view_y = 0;


PImage[] character;
ArrayList<Sprite> plataform;
Trashi trash;


void setup() {
    size(800, 511);
    imageMode(CENTER);
    character = new ReadArchive(4,12,"Gotita.png").getSheet();
    trash = new Trashi(character[0]);
    trash.center.x = 65;
    trash.center.y = 100;
    lvl = new Backgroundd("maps0.csv", "Tileset32.png", 32);

}

void draw() {
    background(255);
    play();
}

void play(){
    scroll();
    lvl.display();
    trash.displayShadow();
    trash.display();
    trash.update();
    resolveColision(trash,plataform);
}

void scroll(){
    float right_dimension = view_x + width - right_margin; 
    if(trash.getRight() > right_dimension ){
        if (view_x < 3700) {
            view_x  += trash.getRight() - right_dimension;
        }
    }
    float left_dimension = view_x + width - left_margin;
    if (trash.getLeft() < left_dimension) {
        if (view_x > 0) {
            view_x -= left_dimension - trash.getLeft();
        }
    translate(view_x, view_y);
    }
}

boolean touched(Sprite s1, Sprite s2){
    boolean touchX = s1.getRight() <= s2.getLeft() || s1.getLeft() >= s2.getRight();
    boolean touchY = s1.getBottom() <= s2.getTop() || s1.getTop() >= s2.getBottom();
    if (touchX || touchY)
        return false;
    else{
        if (s2.num == 13 && ((Trashi)s1).estate == 0) 
            return false;
        else{
            if (s2.num == 31 && ((Trashi)s1).estate == 1) {
            trash.estate = 0;
            trash.loadState();
            }
        return true;
        }
    }
}

ArrayList<Sprite> touched(Sprite s, ArrayList<Sprite> lista){
    ArrayList<Sprite> listTouch = new ArrayList<Sprite>();
    for (Sprite p: lista) {
        if (touched(s,p))
            listTouch.add(p);
    }
    return listTouch;
}

void resolveColision(Sprite s, ArrayList<Sprite> list){
    s.change.y += gravity;
    s.change.y += s.change.y;
    ArrayList<Sprite> colList = touched(s, list);
    if (colList.size()> 0) {
        Sprite colision = colList.get(0);
        System.out.println("debug"); //DEBUGER MAESTRO
        if(s.change.y > 0)
            s.setBottom(colision.getTop());
        else if (s.change.y < 0 )
            s.setTop(colision.getBottom());
        s.change.y = 0;
        }
    s.center.x += s.change.x; 
    colList = touched(s, list);
    if (colList.size() > 0){
        Sprite colision = colList.get(0);
    if(s.change.x > 0)
        s.setRight(colision.getLeft());
    else if(s.change.x < 0)
        s.setLeft(colision.getRight());
    s.change.x = 0;
    }
}

boolean isInPlataform(Sprite s, ArrayList<Sprite> wall){
    s.center.y += 5;
    ArrayList<Sprite> colList = touched(s, wall);
    s.center.y -= 5;
    if (colList.size() > 0)
        return true;
    else
        return false;
}

void keyPressed(){
    if(keyCode == RIGHT){
        System.out.println("hola");
        trash.change.x = vel;
    }
    else if(keyCode == LEFT){
        System.out.println("adios");
        trash.change.x = -vel;
    }
    else if(keyCode == UP && isInPlataform(trash, plataform)){
        // System.out.println("isInPlataform(trash, plataform): ");
        trash.change.y = -jump;
    }
}

void keyReleased() {
    if(keyCode == RIGHT)
        trash.change.x = 0;
    else if(keyCode == LEFT)
        trash.change.x = 0;
    else if(keyCode == UP){
        trash.change.y = 0;
    }
}