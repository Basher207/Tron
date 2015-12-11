abstract class Item extends GameObject {
  int size;
  boolean pickedUp = false;
  PImage powerupImage;
  abstract void Pickup (Bike pickedUpBike);
  Item (GridVector position, int size, PImage powerupImage) {
    super(position.Get()); 
    this.powerupImage = powerupImage;
    game.items.add(this);
    this.size = size;
  }
  void CheckPickup () {
    for (Player player : game.players) {
      if (player.bike != null && player.bike.alive) {
        if (abs (player.bike.position.x - position.x) < size / 2 &&
            abs (player.bike.position.y - position.y) < size / 2) 
          Pickup (player.bike);
          pickedUp = true;
          break;
      }
    }
  }
  void Render () {
    rectMode(CENTER);
    pushMatrix ();
    noFill ();
    stroke (255, 165, 0);
    translate (position.x, position.y);
    imageMode(CENTER);
    image (powerupImage, 0, 0, size, size);
    popMatrix ();
  }
}
class SpeedPickup extends Item {
  SpeedPickup (GridVector position, int size) {
    super (position, size, speedImage);
  }
  void Pickup (Bike pickedUpBike) {
    pickedUpBike.SetState(new SpeedBoost (pickedUpBike, 120, 4));
    game.items.remove (this);
  }
}
class GhostPickup extends Item {
  int frames;
  GhostPickup (GridVector position, int size) {
    super (position, size,ghostImage);
    this.frames = 60;
  }
  void Pickup (Bike pickedUpBike) {
    pickedUpBike.SetState (new NoColliderState (pickedUpBike, frames));
    game.items.remove (this);
    PlayPickup ();
  }
}
class BlasterPickup extends Item {
  int blastExtent = 20;
  BlasterPickup (GridVector position, int size) {
    super (position, size,bombImage);
  }
  void Pickup (Bike pickedUpBike) {
    Bounds2D blastingBound = null;
    if (pickedUpBike.direction == Direction.UP) {
      blastingBound = new Bounds2D (new GridVector (pickedUpBike.position.x - blastExtent, Integer.MIN_VALUE), new GridVector (pickedUpBike.position.x + blastExtent, pickedUpBike.position.y));
    } else if (pickedUpBike.direction == Direction.DOWN) {
      blastingBound = new Bounds2D (new GridVector (pickedUpBike.position.x - blastExtent, pickedUpBike.position.y), new GridVector (pickedUpBike.position.x + blastExtent, Integer.MAX_VALUE));
    } else if (pickedUpBike.direction == Direction.RIGHT) {
      blastingBound = new Bounds2D (new GridVector (pickedUpBike.position.x, pickedUpBike.position.y - blastExtent), new GridVector (Integer.MAX_VALUE, pickedUpBike.position.y + blastExtent));
    } else {
      blastingBound = new Bounds2D (new GridVector (Integer.MIN_VALUE, pickedUpBike.position.y - blastExtent), new GridVector (pickedUpBike.position.x, pickedUpBike.position.y + blastExtent));
    }
    for (int i = game.trails.size() - 1; i >= 0; i--) {
     game.trails.get(i).CutArea (blastingBound);
    }
    fill (pickedUpBike.ObjectColor());
    stroke(255,255,255);
    rectMode (CORNERS);
    rect (blastingBound.min.x, blastingBound.min.y, blastingBound.max.x, blastingBound.max.y);
    game.items.remove(this);
  }
}