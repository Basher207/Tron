class ItemSpawner extends DynamicObject {
  float angle;
  int timeBetweenSpawns;
  int coolDown;
  Item spawnedItem = null;
  ItemSpawner (GridVector position, int timeBetweenSpawns) {
    super(position);
    this.timeBetweenSpawns = coolDown = timeBetweenSpawns;
  }
  void Render () {
    pushMatrix();
    translate (position.x, position.y);
    angle += 0.1;
    rotate (angle);
    rectMode(CENTER);
    noFill ();
    stroke(255,50);
    rect (0, 0, 10, 10);
    popMatrix();
  }
  void Update () {
    println(spawnedItem);
    if ((spawnedItem == null ? true : spawnedItem.pickedUp))
      coolDown--;
    if (coolDown < 0 && (spawnedItem == null ? true : spawnedItem.pickedUp)) {
       spawnedItem = RandomItemSpawn ();
       coolDown = timeBetweenSpawns;
    } else {
      coolDown--; 
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