PImage img = null;
PImage bg;

Table cards = null;
String desc = "file does not exist";

String name = "owoce";

int state = 0;

void loadCSV() {
  cards = loadTable(name + "/desc.csv", "header");
}

String getQuestion() {
    int nr = int(random(cards.getRowCount()));
    TableRow row = cards.getRow(nr);
    String name = row.getString("name");
    String picture = row.getString("picture");
    return name + "&" + picture;
}

void ShowQuestion(String q) {
    desc = q.split("&")[0];
    img = loadImage(name+ "/" + q.split("&")[1]);
    img.resize(640, 480);
}


void keyPressed() {
  if(state == 0 || state == 3) {
    if(key==BACKSPACE) {
        my_textbox.keyRemove();
        return;
    }
    if(key==ENTER) {
        name = my_textbox.says;
        loadCSV();
        state = 3; 
        if(cards != null) {
          String s = getQuestion();
          ShowQuestion(s);
          state = 1;
        } else {
          state = 3;
        }
        return;
    }
    my_textbox.keyPressed(key);
    return;
  }
  if(state == 2) {
    state = 1;
    String s = getQuestion();
    ShowQuestion(s);
    return;
  }
  if(state == 1) {
    state = 2;
    return;
  }
}

// https://forum.processing.org/two/discussion/19374/#Comment_80483
class Textbox {
  float x, y;
  String says;
  Textbox(float ix, float iy) {
    x=ix;
    y=iy;
    says = "";
  }
  void draw() {
    rectMode(CENTER);
    textAlign(CENTER, CENTER);
    fill(255);
    rect(x, y, 200, 20);
    fill(255, 0, 0);
    text(says, x, y);
  }
  void keyPressed(char pressed_key) {
    if ( pressed_key != CODED ) {
      says += pressed_key;
    }
  }
  
  void keyRemove() {
    if (says != null && says.length() > 0) {
        says = says.substring(0, says.length() - 1);
    }
  }
}
 
Textbox my_textbox = new Textbox(300,300);

void setup() {
  size(640, 540);
  bg = loadImage("download.jpg");
  bg.resize(640,540);
}





void draw() {
  background(bg);
  if(state == 0) {
    my_textbox.draw();
  } else if (state == 3) {
    my_textbox.draw();
    text(desc, 100, 500);
  }else if(state == 1) {
    image(img, 0, 0);
  } else {
    image(img, 0, 0);
    text(desc, 100, 500);
  }
}
