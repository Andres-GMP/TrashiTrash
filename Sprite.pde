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

    void display(){
        image(img, center.x, center.y);
    }

    void move(){

        center.x += change.x;
        center.y += change.y;

    }
    void setLeft(float left){
        center.x = left + sizee.x/2;
    }

    float getLeft(){
        return center.x - sizee.x/2;
    }
    void setRight(float right){
        center.x = right - sizee.x/2;
    }
    float getRight(){
        return center.x + sizee.x/2;
    }

    void setTop(float top){
        center.y = top + sizee.y/2;
    }
    float getTop(){
        return center.y - sizee.y/2;
    }
    void setBottom(float bottom){
        center.y = bottom - sizee.y/2;
    }
    float getBottom(){
        return center.y + sizee.y/2;
    }
    
}