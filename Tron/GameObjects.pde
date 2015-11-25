abstract class GameObject {
  GridVector position;
  abstract void Render ();
}
abstract class DynamicObject extends GameObject {
  abstract void Update ();
}
class Trail extends GameObject {
  GridVector endPosition;
  Bike bike;
  Trail (GridVector position, Bike bike) {
    this.position = position.Get ();
    this.endPosition = position.Get();
    this.bike = bike;
  }
  void Render () {
    strokeWeight (1);
    stroke (bike.bikeColor);
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