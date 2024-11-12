import java.util.ArrayList;
import processing.sound.*;

ArrayList<Cokroach> coks;
PImage img;
SoundFile sound;
int lastSpawnTime;

void setup() {
  size(800, 800);
  coks = new ArrayList<Cokroach>();
  img = loadImage("kecoa.png");
  sound = new SoundFile(this, "hit_sound.mp3");  // Pastikan file suara berada di folder yang benar
  lastSpawnTime = millis();
}

void draw() {
  background(#050505);
  
  // Menambahkan kecoa baru secara otomatis tiap 5 detik
  if (millis() - lastSpawnTime >= 5000) {
    float x = random(width);
    float y = random(height);
    coks.add(new Cokroach(img, x, y));
    lastSpawnTime = millis();
  }
  
  // Menampilkan dan memperbarui posisi kecoa
  for (int i = coks.size() - 1; i >= 0; i--) {
    Cokroach c = coks.get(i);
    c.live();
  }
  
  fill(51);
  textSize(16);
  text("nums: " + coks.size(), 50, 750); 
  fill(#FFFFFF);
  text("22.11.5105",350,100);
  text("Yosep Rasendriya Maheswara",300,115);
}

void mouseClicked() {
  boolean hit = false;
  for (int i = coks.size() - 1; i >= 0; i--) {
    Cokroach c = coks.get(i);
    float d = dist(mouseX, mouseY, c.pos.x, c.pos.y);
    if (d < img.width / 2) {  // Memastikan klik berada di area kecoa
      coks.remove(i);
      hit = true;
      break;
    }
  }
  
  if (hit) {
    sound.play();  // Memainkan efek suara ketika kecoa terkena klik
  }
}

class Cokroach {
  PVector pos;
  PVector vel;
  PImage img;
  float heading;
  
  Cokroach(PImage _img, float _x, float _y) {
    pos = new PVector(_x, _y);
    vel = PVector.random2D();
    heading = 0;
    img = _img;
  }
  
  void live() {
    pos.add(vel);
    
    // Pantulan di tepi layar
    if (pos.x <= 0 || pos.x >= width) vel.x *= -1;
    if (pos.y <= 0 || pos.y >= height) vel.y *= -1;
    
    // Rotasi berdasarkan arah kecepatan
    heading = atan2(vel.y, vel.x);
    pushMatrix();
    imageMode(CENTER);
    translate(pos.x, pos.y);
    rotate(heading + 0.5 * PI);
    image(img, 0, 0);
    popMatrix();
  }
}
