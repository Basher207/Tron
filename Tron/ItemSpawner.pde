class ItemSpawner extends DynamicObject {
  float angle;
  int timeBetweenSpawns;
  int coolDown;
  Item spawnedItem = null;
  ItemSpawner (GridVector position, int timeBetweenSpawns) {
    super(position);
    this.timeBetweenSpawns = coolDown = timeBetweenSpawns + (int)random (-280, 280);
  }
  void Render () {
    pushMatrix();
    translate (position.x, position.y);
    angle += 0.1;
    rotate (angle);
    rectMode(CENTER);
    noFill ();
    stroke(255, 50);
    float size = (float)coolDown / timeBetweenSpawns * 40;
    rect (0, 0, size, size);
    popMatrix();
  }
  void Update () {
    if (((spawnedItem == null) ? true : spawnedItem.pickedUp)) {
      coolDown--;
      if (coolDown < 0) {
        spawnedItem = RandomItemSpawn ();
        coolDown = timeBetweenSpawns;
      }
    }
  }
  Item RandomItemSpawn () {
    int ranIndex = floor(random (0, 2));
    switch (ranIndex) {
    case 0:
      return new BlasterPickup (position.Get(), 50);
    case 1:
      return new GhostPickup (position.Get(), 50);
    case 2:
      return new SpeedPickup (position.Get(), 50);
    }
    return new BlasterPickup (position.Get(), 50);
  }
}