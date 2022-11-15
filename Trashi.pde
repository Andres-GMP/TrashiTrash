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

    void displayShadow(){
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

    void loadState(){
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
    @Override
    void selectDirection(){
        if (change.x > 0) 
            dir = right;
        else if (change.x < 0) 
            dir = left;
    }
    void selectImageCurrent(){
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
