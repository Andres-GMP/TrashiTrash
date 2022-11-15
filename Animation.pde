class Animation extends Sprite{
        PImage[] current, still, moveLeft, moveRight;
        int dir, index, frame;

        Animation(PImage img){
            super(img, 0);
            dir = normal;
            index = 0;
            frame = 0;
        }

        void update(){
            frame ++;
            if(frame%8 == 0){
                selectDirection();
                selectImageCurrent();
            }
        }
        void selectDirection(){
            if (change.x>0) 
                dir = right;
            else if(change.x < 0)
                dir = left;
            else
                dir = normal;
        }
        void selectImageCurrent(){
            if (dir == left) 
                current = moveLeft;
            else if(dir == right)
                current = moveRight;
            else
            current = still;
        }
        void moveImg(){
            index ++;
            if(index >= current.length)
                index = 0;
            img = current[index];
        }
}