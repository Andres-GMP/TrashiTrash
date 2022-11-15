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
void display(){
    image(bgBackground, view_x+width/2, height/2-130);

    for(Sprite p: plataform)
        p.display();
}

void createPlataform(String archive){
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

int getNum(String txt){
    int num = 0;    
    num = Integer.valueOf(txt);
    return num;
}
}
