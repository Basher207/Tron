class GridVector {
  int x; 
  int y;
  GridVector (int x, int y) {
    this.x = x;
    this.y = y;
  }
  GridVector Add (GridVector gridVector) {
    x += gridVector.x;
    y += gridVector.y;
    return this;
  }
  GridVector Multi (int times) {
    x *= times;
    y *= times;
    return this;
  }
  GridVector Div (int by) {
    x /= by;
    y /= by;
    return this;
  }
  GridVector Get () {
    return new GridVector (x, y);
  }
  void Set (GridVector gridVector) {
    x = gridVector.x;
    y = gridVector.y;
  }
  boolean Equals (GridVector gridVector) {
    return (x == gridVector.x) && (y == gridVector.y);
  }
  void SetDirection (Direction direction) {
    int total = abs(x) + abs(y);
    x = y = 0;
    if        (direction == Direction.UP) {
      y = -total;
    } else if (direction == Direction.DOWN) {
      y =  total;
    } else if (direction == Direction.LEFT) {
      x = -total;
    } else {
      x = total;
    }
  }
  public GridVector Sub (GridVector gridVector) {
    x -= gridVector.x;
    y -= gridVector.y;
    return this;
  }
}
enum Direction {
  UP, 
  DOWN, 
  LEFT, 
  RIGHT,
  NON
}
  boolean OppositeDirection (Direction direction, Direction otherDirection) {

  if        (direction == Direction.DOWN  && otherDirection == Direction.UP) {
    return true;
  } else if (direction == Direction.UP    && otherDirection == Direction.DOWN) {
    return true;
  } else if (direction == Direction.RIGHT && otherDirection == Direction.LEFT) {
    return true;
  } else if (direction == Direction.LEFT  && otherDirection == Direction.RIGHT) {
    return true;
  }
  return false;
}
GridVector GridFromDirection (Direction direction) {
  if        (direction == Direction.UP) {
    return new GridVector ( 0, -1);
  } else if (direction == Direction.DOWN) {
    return new GridVector ( 0, 1);
  } else if (direction == Direction.LEFT) {
    return new GridVector (-1, 0);
  } else {
    return new GridVector ( 1, 0);
  }
}