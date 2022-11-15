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
    PImage[] getSheet(){
        return mySprite;
    }
}
