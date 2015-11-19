abstract class GameObject {
  GridVector position;
  abstract void Render ();
}
abstract class DynamicObject extends GameObject {
  abstract void Update ();
}
class Bike extends DynamicObject {
  int speed;
  Direction direction;
  Direction nextFrameDirection = Direction.NON;
  boolean turnnedThisFrame;
  color bikeColor;
  boolean alive = true;
  int lives;
  ArrayList <Trail> trails;
  Trail currentTrail;
  Bike (GridVector position, Direction direction, int speed, color bikeColor) {
    this.position       = position;
    this.direction      = direction;
    this.speed          = speed;
    this.bikeColor = bikeColor;
    lives = 5;
    trails = new ArrayList<Trail> ();
    currentTrail = new Trail (position.Get(), bikeColor);
    trails.add (currentTrail);
  }
  void Render () {
    for (Trail trail : trails) 
      trail.Render ();
    if (!alive)
      return;
    rectMode (CENTER);
    stroke (255);
    fill (bikeColor);
    rect (position.x, position.y, 4, 4);
  }
  void Update () {
    if (!alive)
      return;
    for (int i = 0; i < speed; i++) {
      GridVector velocity = GridFromDirection (direction);
      GridVector newPosition = position.Get ();
      newPosition.Add (velocity);
      if (MoveToPoint (newPosition)) {
        alive = false;
        return;
      }
      position.Set (newPosition);
      currentTrail.endPosition.Set(position);
    }
    turnnedThisFrame = false;
    if (nextFrameDirection != Direction.NON) {
      ChangeDirection (nextFrameDirection);
      nextFrameDirection = Direction.NON;
    }
  }
  void ChangeDirection (Direction direction) {
    if (turnnedThisFrame) {
      nextFrameDirection = direction;
      return;
    }
    turnnedThisFrame = true;
    currentTrail.endPosition.Set (position);
    currentTrail = new Trail (position.Get (), bikeColor);
    trails.add (currentTrail);
    if (!OppositeDirection (this.direction, direction))
      this.direction = direction;
  }
  boolean MoveToPoint (GridVector point) {
    for (Player player : game.players) 
      for (Trail trail : player.bike.trails) {
        if (trail.TouchedLine (point)) {
          return true;
        }
      }
    if (point.x < 0) {
      alive = false;
      /*
      currentTrail.endPosition.Set (position);
      point.x = width - point.x;
      currentTrail = new Trail (point, bikeColor);
      trails.add (currentTrail);
      */
    } else if (point.x > width) {
      alive = false;
      /*
      currentTrail.endPosition.Set (point);
      point.x = width - point.x;
      currentTrail = new Trail (point, bikeColor);
      trails.add (currentTrail);
      */
    }
    if (point.y < 0) {
      alive = false;
      /*
      currentTrail.endPosition.Set (position);
      point.y = height - point.y;
      currentTrail = new Trail (point, bikeColor);
      trails.add (currentTrail);
      */
    } else if (point.y > height) {
      alive = false;
      /*
      currentTrail.endPosition.Set (point);
      point.y = height - point.y;
      currentTrail = new Trail (point, bikeColor);
      trails.add (currentTrail);
      */
    }
    return false;
  }
}
class Trail extends GameObject {
  GridVector endPosition;
  color trailColor;
  Trail (GridVector position, color trailColor) {
    this.position = position.Get ();
    this.endPosition = position.Get();
    this.trailColor = trailColor;
  }
  void Render () {
    strokeWeight (1);
    stroke (trailColor);
    line (position.x, position.y, endPosition.x, endPosition.y);
  }
  boolean TouchedLine (GridVector checkPoint) {
    boolean trailVertical = this.endPosition.x - this.position.x == 0;
    if (trailVertical) {
      float trailLength = abs(position.y - endPosition.y);
      if (checkPoint.x == position.x && (abs(checkPoint.y - position.y) < trailLength && abs(checkPoint.y - endPosition.y) < trailLength))
        return true;
    }
    float trailLength = abs(position.x - endPosition.x);
    if (checkPoint.y == position.y && (abs(checkPoint.x - position.x) < trailLength && abs(checkPoint.x - endPosition.x) < trailLength)) 
      return true;
    return false;
  }
}