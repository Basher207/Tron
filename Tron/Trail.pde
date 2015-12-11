class Trail extends GameObject {
  GridVector endPosition;
  ColoredObject bike;
  boolean breakable;
  Trail (GridVector position, ColoredObject bike, boolean breakable) {
    super(position.Get ());
    this.breakable = breakable;
    game.trails.add(this);
    this.endPosition = position.Get();
    this.bike = bike;
  }
  void Render () {
    strokeWeight (1);
    stroke (bike.ObjectColor());
    line (position.x, position.y, endPosition.x, endPosition.y);
  }
  boolean TrailVertical () {
    return this.endPosition.x - this.position.x == 0;
  }
  boolean TouchedLine (GridVector checkPoint) {
    boolean trailVertical = this.endPosition.x - this.position.x == 0;
    if (trailVertical) {
      float trailLength = abs(position.y - endPosition.y);
      if (checkPoint.x == position.x && (abs(checkPoint.y - position.y) <= trailLength && abs(checkPoint.y - endPosition.y) <= trailLength))
        return true;
    }
    float trailLength = abs(position.x - endPosition.x);
    if (checkPoint.y == position.y && (abs(checkPoint.x - position.x) <= trailLength && abs(checkPoint.x - endPosition.x) <= trailLength)) 
      return true;
    return false;
  }
  void CutArea (Bounds2D bound) {
    if (!breakable)
      return;
    GridVector max = null;
    GridVector min = null;
    if (!TrailVertical ()) {
      if (endPosition.x > position.x) {
        max = endPosition;
        min = position;
      } else {
        max = position;
        min = endPosition;
      }
    } else {
      if (endPosition.y > position.y) {
        max = endPosition;
        min = position;
      } else {
        max = position;
        min = endPosition;
      }
    }
    if (bound.max.x > min.x && bound.min.x < max.x && bound.min.y < max.y && bound.max.y > min.y) {
      if (bound.max.x < max.x && bound.min.x > min.x) {
        Trail leftSideOfTrail = new Trail (min.Get(), bike, true);
        leftSideOfTrail.endPosition = new GridVector (bound.min.x, endPosition.y);
        min.x = bound.max.x;
      } else if (bound.min.x > min.x) {
        max.x = bound.min.x;
      } else if (bound.max.x < max.x) {
        min.x = bound.max.x;
      }
      if (bound.max.y < max.y && bound.min.y > min.y) {
        Trail lowSide = new Trail (min.Get(), bike, true);
        lowSide.endPosition = new GridVector (endPosition.x, bound.min.y);
        min.y = bound.max.y;
      } else if (bound.min.y > min.y) {
        max.y = bound.min.y;
      } else if (bound.max.y < max.y) {
        min.y = bound.max.y;
      }
    }
    if (bound.max.x > max.x && bound.min.x < min.x && bound.min.y < min.y && bound.max.y > max.y)
      game.trails.remove(this);
  }
}