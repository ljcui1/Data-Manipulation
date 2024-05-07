import java.util.Arrays;

PImage img;

boolean imgSel = false;
boolean start = true;

int space = 100;

int b = 0;

void setup(){
  size(1500, 1080);
  
  
  selectInput("Select an Image:", "select");
}

void draw(){
  if(start){
    background(255);
    if(img != null){
      image(img, 0, 0, width, height);
      imgSel = true;
      start = false;
    }else{
      textAlign(CENTER);
      textSize(20);
      fill(0);
      text("No Image selected", width/2, height/2);
      imgSel = false;
    }
  }
  
  
  
  /*for(int w = 0; w <= width; w++){
    for(int h = 0; h <= height; h++){
      
    }
  }*/
   
}

void mousePressed(){
  if(imgSel){
    int clickX = mouseX;
    int clickY = mouseY;
    
    invertCol(clickX, clickY);
  }
  
}

void keyPressed(){
  if(key == ' '){
    for(int i = 0; i < 10; i++){
      colorSort();
    }
    
  }
  
  if(key == 'a' || key == 'A'){
    brightChange(-10);
  }else if(key == 'd' || key == 'D'){
    brightChange(10);
  }
  
  if(key == ENTER){
    pixelShuffle();
  }
}

void select(File selection){
  if(selection != null){
    img = loadImage(selection.getAbsolutePath());
  }
}

void invertCol(int x, int y){
  loadPixels();
  int[] invert = pixels;
  int sX = constrain(x - space/2, 0, img.width - space);
  int sY = constrain(y - space/2, 0, img.height - space);
  
  for(int i = sX; i < sX + space; i++){
    for(int j = sY; j < sY + space; j++){
      invert[j * img.width + i] = color(255 - red(invert[j * img.width + i]), 255 - green(invert[j * img.width + i]), 255 - blue(invert[j * img.width + i]));
    }
  }
  
  arrayCopy(invert, pixels);
  updatePixels();
}

void colorSort(){
  loadPixels();
  int[] colSort = pixels;
  for(int i = 0; i < width * height - 1; i++){
    float r1 = red(colSort[i]);
    float g1 = green(colSort[i]);
    float b1 = blue(colSort[i]);
    
    float r2 = red(colSort[i + 1]);
    float g2 = green(colSort[i + 1]);
    float b2 = blue(colSort[i + 1]);
    
    float c1 = (r1 + g1 + b1)/3.0;
    float c2 = (r2 + g2 + b2)/3.0;
    
    if(c1 > c2){
      int temp = colSort[i];
      colSort[i] = colSort[i + 1];
      colSort[i + 1] = temp;
    }
  }
  
  arrayCopy(colSort, pixels);
  updatePixels();
}

void brightChange(int b){
  loadPixels();
  //int[] bSort = pixels;
  for(int i = 0; i < pixels.length; i++){
    float r = red(pixels[i]);
    float g = green(pixels[i]);
    float bl = blue(pixels[i]);
    r += b;
    g += b;
    bl += b;
    
    r = constrain(r, 0, 255);
    g = constrain(g, 0, 255);
    bl = constrain(bl, 0, 255);
    
    color c = color(r, g, bl);
    
    pixels[i] = c;
    
  }
  
  //arrayCopy(bSort, pixels);
  updatePixels();
}

void pixelShuffle(){
  loadPixels();
  for(int i = pixels.length - 1; i > 0; i--){
    int j = int(random(i + 1));
    
    int temp = pixels[i];
    pixels[i] = pixels[j];
    pixels[j] = temp;
  }
  updatePixels();
}
