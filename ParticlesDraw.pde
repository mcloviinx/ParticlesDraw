ArrayList<Particle> particles;

void setup(){
  size(700, 700, P2D);
  particles = getParticles(loadImage("src/img.jpg"));
  fill(255);
  stroke(255, 100);
}
void draw(){
  background(0);
  for (Particle p : particles){
    p.show();
    if (mousePressed) p.updateRandom();
    else p.update();
  }
  //saveFrame("/export/frame-####.jpg");
}
ArrayList<Particle> getParticles(PImage img){
  img.resize(width, height);
  img.filter(THRESHOLD, 0.5);
  int gx = 100;         //grid particles x
  int gy = 100;         // grid particles y
  int sx = width / gx;  //grid x length
  int sy = height / gy; //grid x length
  int totalPixels = sx * sy;
  ArrayList<Particle> p = new ArrayList<Particle>();
  String output = new String();
  for (int x = 0; x < gy; x++){
    for (int y = 0; y < gy; y++){
      int vx = sx * x;
      int vy = sy * y;
      int pixelCount = 0;
      for (int i = vx; i < vx + sx; i++){
        for (int j = vy; j < vy + sy; j++){
          if (img.get(i, j) == color(255)){
            pixelCount++;
          }
        }
      }
      if (pixelCount > 0){
        Particle part = new Particle(sx / 2 + vx, sy / 2 + vy, map(pixelCount, 1, totalPixels, 1, sx - 1));
        Particle partNormatized = part.getNormatized(width, vx);
        output += "particles.push(new Particle("+partNormatized.tar.x+" * wSize, "+partNormatized.tar.y+" * wSize, "+partNormatized.pr+" * gSize));\n";
        p.add(part);
      }
    }
  }
  String[] list = split(output, '\n');
  saveStrings("particlesExport.txt", list); //Particles in JavaScript object sintax
  return p;
}
