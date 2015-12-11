class Bounds2D {
	GridVector min;
	GridVector max;
	Bounds2D (GridVector min, GridVector max) {
    this.min = min;
    this.max = max;
	}
	boolean Intersects (GridVector point) {	
    if (point.x > min.x && point.x < max.x && point.y > min.y && point.y < max.y)
      return true;
    return false;
	}
	boolean Intersects (Bounds2D bound) {
    if (bound.max.x > min.x && bound.min.x < max.x && bound.max.y > min.y && bound.min.y < max.y) 
      return true;
	  return false;
	}
}