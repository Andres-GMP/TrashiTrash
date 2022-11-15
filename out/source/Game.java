/* autogenerated by Processing revision 1286 on 2022-11-09 */
import processing.core.*;
import processing.data.*;
import processing.event.*;
import processing.opengl.*;

import java.util.HashMap;
import java.util.ArrayList;
import java.io.File;
import java.io.BufferedReader;
import java.io.PrintWriter;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.IOException;

public class Game extends PApplet {


Backgroundd lvl;

final static int normal = 0;
final static int right = 1;
final static int left = 2;
final static float right_margin = 400;
final static float left_margin = 32;
final static float see_image = 40;
final static float gravity = 0.6f;
final static float jump = 5;
final static float vel = 5;
final static float size_sprite = 32;


float view_x = 0;
float view_y = 0;


PImage[] character;
ArrayList<Sprite> plataform;
Trashi trash;


 public void setup() {
    /* size commented out by preprocessor */;
    imageMode(CENTER);
    character = new ReadArchive(4,12,"Gotita.png").getSheet();
    trash = new Trashi(character[0]);
    trash.center.x = 65;
    trash.center.y = 100;
    lvl = new Backgroundd("maps0.csv", "Tileset32.png", 32);

}

 public void draw() {
    background(255);
    play();
}

 public void play(){
    scroll();
    lvl.display();
    trash.displayShadow();
    trash.display();
    trash.update();
    resolveColision(trash,plataform);
}

 public void scroll(){
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

 public boolean touched(Sprite s1, Sprite s2){
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

 public ArrayList<Sprite> touched(Sprite s, ArrayList<Sprite> lista){
    ArrayList<Sprite> listTouch = new ArrayList<Sprite>();
    for (Sprite p: lista) {
        if (touched(s,p))
            listTouch.add(p);
    }
    return listTouch;
}

 public void resolveColision(Sprite s, ArrayList<Sprite> list){
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

 public boolean isInPlataform(Sprite s, ArrayList<Sprite> wall){
    s.center.y += 5;
    ArrayList<Sprite> colList = touched(s, wall);
    s.center.y -= 5;
    if (colList.size() > 0)
        return true;
    else
        return false;
}

 public void keyPressed(){
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

 public void keyReleased() {
    if(keyCode == RIGHT)
        trash.change.x = 0;
    else if(keyCode == LEFT)
        trash.change.x = 0;
    else if(keyCode == UP){
        trash.change.y = 0;
    }
}
class Animation extends Sprite{
        PImage[] current, still, moveLeft, moveRight;
        int dir, index, frame;

        Animation(PImage img){
            super(img, 0);
            dir = normal;
            index = 0;
            frame = 0;
        }

         public void update(){
            frame ++;
            if(frame%8 == 0){
                selectDirection();
                selectImageCurrent();
            }
        }
         public void selectDirection(){
            if (change.x>0) 
                dir = right;
            else if(change.x < 0)
                dir = left;
            else
                dir = normal;
        }
         public void selectImageCurrent(){
            if (dir == left) 
                current = moveLeft;
            else if(dir == right)
                current = moveRight;
            else
            current = still;
        }
         public void moveImg(){
            index ++;
            if(index >= current.length)
                index = 0;
            img = current[index];
        }
}
class Backgroundd {

PImage mySprite[], bgBackground;
float sizeSprite;

Backgroundd(String name, String tilemap, float size){
    sizeSprite = size;
    mySprite = new ReadArchive(8, 5, tilemap).getSheet();
    plataform = new ArrayList<Sprite>();

    bgBackground = loadImage("Backgrounded.png");
    createPlataform(name);
}
 public void display(){
    image(bgBackground, view_x+width/2, height/2-130);

    for(Sprite p: plataform)
        p.display();
}

 public void createPlataform(String archive){
    String[] lines = loadStrings(archive);

    for (int row = 0; row < lines.length; row++) {
        String[] values = split(lines[row], ",");
        for (int col = 0; col < values.length; col++) {
            int num = getNum(values[col]);
            if (num < 13) {
                Sprite s = new Sprite(mySprite[num], num);
                s.center.x = sizeSprite/2 + col*sizeSprite;
                s.center.y = sizeSprite/2 + row*sizeSprite;
                plataform.add(s);
            }else if(num ==31){
                Sprite s = new Sprite(mySprite[13], num);
                s.center.x = sizeSprite/2 + col*sizeSprite;
                s.center.y = sizeSprite/2 + row*sizeSprite;
                plataform.add(s);
            }
        }
    }
}

 public int getNum(String txt){
    int num = 0;    
    num = Integer.valueOf(txt);
    return num;
}
}
class ReadArchive{

    int colSprite, rowSprite, totalSprite;
    PImage[] mySprite;


    ReadArchive (int col, int row, String name) {
        colSprite = col;
        rowSprite = row;
        totalSprite = col*row;
        mySprite = new PImage[totalSprite];
        PImage sheet = loadImage(name);
        int widt = sheet.width/colSprite;
        int heigt = sheet.height/rowSprite;
        int pos = 0;
        for (int y = 0; y < rowSprite; ++y) {
            for (int x = 0; x < colSprite; x++) {
                mySprite[pos] = sheet.get(x*widt, y*heigt, widt,heigt);
                pos++;
            }
        }
    }
     public PImage[] getSheet(){
        return mySprite;
    }
}
class Sprite{
    PImage img;
    PVector center, change, sizee;
    int type, num;
    
    Sprite(PImage archive, float x, float y){
        img = archive;
        sizee = new PVector(img.width, img.height);
        center = new PVector(x, y);
        change = new PVector(0,0);
        type = 0; 
        num = 0;
    }

    Sprite(PImage archive, int wall){
        img = archive;
        sizee = new PVector(img.width, img.height);
        center = new PVector(0, 0);
        change = new PVector(0,0);
        type = 0; 
        num = wall;
    }
    Sprite(float x, float y){
        img = new PImage();
        sizee = new PVector(0,0);
        center = new PVector(0, 0);
        change = new PVector(0,0);
        type = 0;
        
    }

     public void display(){
        image(img, center.x, center.y);
    }

     public void move(){

        center.x += change.x;
        center.y += change.y;

    }
     public void setLeft(float left){
        center.x = left + sizee.x/2;
    }

     public float getLeft(){
        return center.x - sizee.x/2;
    }
     public void setRight(float right){
        center.x = right - sizee.x/2;
    }
     public float getRight(){
        return center.x + sizee.x/2;
    }

     public void setTop(float top){
        center.y = top + sizee.y/2;
    }
     public float getTop(){
        return center.y - sizee.y/2;
    }
     public void setBottom(float bottom){
        center.y = bottom - sizee.y/2;
    }
     public float getBottom(){
        return center.y + sizee.y/2;
    }
    
}
class Trashi extends Animation{
    int lifes, estate, timer; 
    boolean onPlataform, onFloor;
    PImage[] goRight, goLeft, jumpRight, jumpLeft;
    ArrayList<Sprite> shadow;

    Trashi (PImage image) {
        super(image);
        shadow = new ArrayList<Sprite>();
        lifes = 3;
        timer = 0;
        dir = right;
        estate = 0;
        onPlataform = false;
        onFloor = false;
        goRight = new PImage[2];
        goLeft = new PImage[2];
        moveRight = new PImage[8];
        moveLeft = new PImage[8];
        jumpRight = new PImage[1];
        jumpLeft = new PImage[1];
        current = jumpRight;
    }

     public void displayShadow(){
        if(timer < 30){
            // transparent the image of character
            tint(120, 100);
            if(frameCount % 4 == 0){
                shadow.add(0, new Sprite(img, center.x, center.y));
                timer++;
            }
            if(shadow.size() > 5)
                shadow.remove((shadow.size()-1));
            for (Sprite g : shadow) 
                g.display();
            noTint();
            }
            else{
                if(shadow.size() > 0)
                shadow.removeAll(shadow);
            }
    }

     public void loadState(){
        timer = 0;
        if (estate == 0) {
            jumpRight[0] = character[2];
            jumpLeft[0] = character[26];
            goLeft[0] = character[24];
            goLeft[1] = character[25];
            goRight[0] = character[0];
            goRight[1] = character[1];
            moveRight[0] = character[4];
            moveRight[1] = character[5];
            moveRight[2] = character[6];
            moveRight[3] = character[7];
            moveRight[4] = character[8];
            moveRight[5] = character[9];
            moveRight[6] = character[10];
            moveRight[7] = character[11];
            moveLeft[0] = character[28];
            moveLeft[1] = character[29];
            moveLeft[2] = character[30];
            moveLeft[3] = character[31];
            moveLeft[4] = character[32];
            moveLeft[5] = character[33];
            moveLeft[6] = character[34];
            moveLeft[7] = character[35];
            
        }
        if (estate == 1) {
            jumpRight[0] = character[14];
            jumpLeft[0] = character[38];
            goLeft[0] = character[36];
            goLeft[1] = character[37];
            goRight[0] = character[12];
            goRight[1] = character[13];
            moveRight[0] = character[16];
            moveRight[1] = character[17];
            moveRight[2] = character[18];
            moveRight[3] = character[19];
            moveRight[4] = character[20];
            moveRight[5] = character[21];
            moveRight[6] = character[22];
            moveRight[7] = character[23];
            moveLeft[0] = character[40];
            moveLeft[1] = character[41];
            moveLeft[2] = character[42];
            moveLeft[3] = character[43];
            moveLeft[4] = character[44];
            moveLeft[5] = character[45];
            moveLeft[6] = character[46];
            moveLeft[7] = character[47];
            
        }
    }
    @Override public 
    void selectDirection(){
        if (change.x > 0) 
            dir = right;
        else if (change.x < 0) 
            dir = left;
    }
     public void selectImageCurrent(){
        if (dir == right) {
            if (onFloor) 
                current = goRight;
            else if (!onPlataform) 
                current = jumpRight;
            else
                current = moveRight;
        }
        else if (dir == right) {
            if (onFloor) 
                current = goLeft;
            else if (!onPlataform) 
                current = jumpLeft;
            else
                current = moveLeft;
        }
    }
}


  public void settings() { size(800, 511); }

  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Game" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
