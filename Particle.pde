class Particle{
  PVector pos, vel, acc;
  float pr, maxVel, maxFor;
  PVector tar;
  Particle(float x, float y, float r){
    pos = new PVector(x, y);
    tar = new PVector(x, y);
    vel = new PVector();
    acc = new PVector();
    pr = r;
    maxVel = 4;
    maxFor = .05;
  }
  void show(){
    ellipse(pos.x, pos.y, pr, pr);
    line(pos.x, pos.y, tar.x, tar.y);
  }
  void updateToMouse(PVector mouse){
    PVector target = PVector.sub(mouse, pos);
    target.normalize().div(2);
    addForce(target);
  }
  void updateToTarget(){
    PVector desired = PVector.sub(tar, pos);
    float d = desired.mag();
    desired.normalize();
    if (d < 100){
      float m = map(d, 0, 100, 0, maxVel);
      desired.mult(m);
    } else {
      desired.mult(maxVel);
    }
    PVector steer = PVector.sub(desired, vel);
    steer.limit(maxFor);
    addForce(steer);
  }
  void updateRandom(){
    PVector accRandom = PVector.random2D();
    accRandom.div(10);
    addForce(accRandom);
  }
  void addForce(PVector force){
    acc.add(force);
    vel.add(acc);
    vel.limit(maxVel);
    pos.add(vel);
    acc.mult(0);
  }
  Particle getNormatized(int size, int gSize){
    PVector normatized = PVector.div(tar, size);
    float radiusNormatized = pr / gSize;
    return new Particle(normatized.x, normatized.y, radiusNormatized);
  }
}
