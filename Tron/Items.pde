abstract class Item extends GameObject {
  int size;
  abstract void Pickup (Bike pickedUpBike);
  void CheckPickup () {
    for (Bike bike : bikes) {
      if (abs (bike.position.x - position.x) < size / 2 && abs (bike.position.y - position.y) < size / 2) 
        Pickup (bike);
    }
  }
}
class SpeedBoost extends Item {
  PVector rotation;
  SpeedBoost (GridVector position, int size) {
    this.size = size;
    rotation = new PVector (0, 0, 0);
    this.position = position;
  }
  void Render () {
    rotation.z += 0.05f;
    rectMode(CENTER);
    pushMatrix ();
    noFill ();
    stroke (255, 165, 0);
    translate (position.x, position.y);
    //rotateX (rotation.x);
    //rotateY (rotation.y);
    //rotateZ (rotation.z);
    rect (0, 0, size, size);
    popMatrix ();
  }
  void Pickup (Bike pickedUpBike) {
    for (Bike bike : bikes) {
      bike.speed += 5;
      items.remove (this);
    }
  }
}