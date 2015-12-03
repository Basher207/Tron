abstract class Item extends GameObject {
  int size;
  abstract void Pickup (Bike pickedUpBike);
  void CheckPickup () {
    for (Player player : game.players) {
      if (abs (player.bike.position.x - position.x) < size / 2 && abs (player.bike.position.y - position.y) < size / 2) 
        Pickup (player.bike);
    }
  }
  void Render () {
    rectMode(CENTER);
    pushMatrix ();
    noFill ();
    stroke (255, 165, 0);
    translate (position.x, position.y);
    rect (0, 0, size, size);
    popMatrix ();
  }
}
class SpeedPickup extends Item {
  SpeedPickup (GridVector position, int size) {
    this.size = size;
    this.position = position;
  }
  void Pickup (Bike pickedUpBike) {
    for (Player player : game.players) {
      if (player.bike != pickedUpBike) 
        player.bike.speed += 2;
    }
    game.items.remove (this);
  }
}
class GhostPickup extends Item {
  int frames;
  GhostPickup (GridVector position, int size, int frames) {
    this.size = size;
    this.frames = frames;
    this.position = position;
  }
  void Pickup (Bike pickedUpBike) {
    for (Player player : game.players) {
      if (player.bike == pickedUpBike) {
        player.bike.SetState (new NoColliderState (player.bike, frames));
        break;
      }
    }
    game.items.remove (this);
    PlayPickup ();
  }
}
class KillBlock extends Item {
  KillBlock (GridVector position, int size) {
    this.size     = size;
    this.position = position;
  }
  void Render () {
    rectMode(CENTER);
    pushMatrix ();
    fill (255);
    stroke (255, 165, 0);
    translate (position.x, position.y);
    rect (0, 0, size, size);
    popMatrix ();
  }
  void Pickup (Bike pickedUpBike) {
    for (Player player : game.players) {
      if (player.bike == pickedUpBike) {
        player.bike.alive = false;
        break;
      }
    }
  }
}