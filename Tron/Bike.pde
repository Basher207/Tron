class Bike extends DynamicObject implements ColoredObject {
  final int         defaultSpeed;                       //Bikes default speed
  int               speed;                              //Bikes current speed, variable to change
  Direction         direction;                          //Direction of movement
  Direction         nextFrameDirection = Direction.NON; //Direction of next frame movement (two keys in one frame)
  boolean           keyPressedThisFrame;                //Have pressed a key this frame
  final color       defaultBikeColor;                   //Default bike Color 
  color             bikeColor;                          //Bikes current color, variable to change
  
  boolean           alive = true;                       //If the bike is currently alive
  boolean           trailing = true;

  Trail             currentTrail;

  BikeState         state;
  int               timeForNormalState;

  Bike (GridVector position, Direction direction, int speed, color bikeColor) {
    super(position);
    this.direction        = direction;
    this.defaultSpeed     = speed;
    this.speed            = this.defaultSpeed;
    this.defaultBikeColor = bikeColor;
    this.bikeColor        = this.defaultBikeColor;
    this.bikeColor        = bikeColor;
    currentTrail          = new Trail (position.Get(), this, true);
    state                 = new NormalState (this);
  }
  void Render () {
    if (!alive)
      return;
    rectMode (CENTER);
    stroke (255, trailing ? 255 : 155);

    fill (bikeColor);
    rect (position.x, position.y, 4, 4);
  }
  void Update () {
    if (!alive)
      return;
    if (timeForNormalState < frameCount) {
      SetState (new NormalState (this));
    }
    for (int i = 0; i < speed; i++) {
      GridVector velocity = GridFromDirection (direction);
      GridVector newPosition = position.Get ();
      newPosition.Add (velocity);
      if (trailing && MoveToPoint (newPosition)) {
        alive = false;
        PlayCrash ();
        return;
      }
      position.Set (newPosition);
      if (currentTrail != null)
        currentTrail.endPosition.Set(position);
    }
    keyPressedThisFrame = false;
    if (nextFrameDirection != Direction.NON) {
      ChangeDirection (nextFrameDirection);
      nextFrameDirection = Direction.NON;
    }
  }
  void SetState (BikeState state) {
    this.state.OnExit ();
    this.state         = state;
    timeForNormalState = state.OnEnter () + frameCount;
  }
  void ChangeDirection (Direction direction) {
    if (keyPressedThisFrame) {
      nextFrameDirection = direction;
      return;
    }
    keyPressedThisFrame = true;
    if (currentTrail != null)
      currentTrail.endPosition.Set (position);
    CreateTrail ();
    if (!OppositeDirection (this.direction, direction))
      this.direction = direction;
  }
  void SetTrailing (boolean trailing) {
    if (this.trailing) {
      if (!trailing)
        currentTrail = null; 
      this.trailing = trailing;
      return;   
    }
    this.trailing = trailing;
    if (trailing) {
      CreateTrail ();
    }
  }
  void CreateTrail () {
    if (trailing) {
     currentTrail = new Trail (position.Get (), this, true);
    }
  }
  public color ObjectColor () {
    return bikeColor;
  }
  boolean MoveToPoint (GridVector point) {
    for (Trail trail : game.trails)
      if (trail.TouchedLine (point))
        return true;

    if (point.x < 0) {
      return true;
      //currentTrail.endPosition.Set (position);
      //point.x = width - point.x;
      //currentTrail = new Trail (point, this);
      //trails.add (currentTrail);
       
    } else if (point.x > width) {
      return true;
      
      //currentTrail.endPosition.Set (point);
      //point.x = width - point.x;
      //currentTrail = new Trail (point, this);
      //trails.add (currentTrail);
       
    }
    if (point.y < 0) {
      return true;
  
      //currentTrail.endPosition.Set (position);
      //point.y = height - point.y;
      //currentTrail = new Trail (point, this);
      //trails.add (currentTrail);
       
    } else if (point.y > height) {
      return true;
      
      //currentTrail.endPosition.Set (point);
      //point.y = height - point.y;
      //currentTrail = new Trail (point, this);
      //trails.add (currentTrail);
       
    }
    return false;
  }
}
abstract class BikeState {
  Bike bike;
  int numberOfFrames;
  BikeState (Bike bike, int numberOfFrames) {
    this.bike = bike;
    this.numberOfFrames = numberOfFrames;
  }
  abstract int OnEnter ();
  abstract void  OnExit  ();
}
class NormalState extends BikeState {
  NormalState (Bike bike) {
    super(bike, Integer.MAX_VALUE);
  }
  int OnEnter () {
    bike.speed = bike.defaultSpeed;
    return numberOfFrames;
  }
  void  OnExit () {
    
  }
}
class NoColliderState extends BikeState {
  NoColliderState (Bike bike, int frames) {
    super(bike,frames);
  }
  int OnEnter () {
    bike.SetTrailing (false);
    return numberOfFrames;
  }
  void  OnExit  () {
    bike.SetTrailing (true);
  }
}
class SpeedBoost extends BikeState {
  int speed;
  SpeedBoost (Bike bike, int frames, int speed) {
    super(bike, frames);
    this.speed = speed;
  }
  int OnEnter () {
    bike.speed = speed;
    return numberOfFrames;
  }
  void  OnExit  () {
    bike.speed = bike.defaultSpeed;
  }
}