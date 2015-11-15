abstract class InputHandler {
   abstract void KeyPressed ();
}
class InputController extends InputHandler {
  Bike controllingBike;
  char goUp, goDown, goLeft, goRight;
  
  InputController (char goUp, char goDown, char goLeft, char goRight, Bike controllingBike) {
    this.goUp     = goUp;
    this.goDown   = goDown;
    this.goLeft   = goLeft;
    this.goRight  = goRight;
    this.controllingBike = controllingBike;
  }
  void KeyPressed () {
   if (controllingBike == null)
     return;
   if (key == goUp)
       controllingBike.ChangeDirection(Direction.UP   );
   else if (key == goDown)
       controllingBike.ChangeDirection(Direction.DOWN );
   else if (key == goLeft)
       controllingBike.ChangeDirection(Direction.LEFT );
   else if (key == goRight)
       controllingBike.ChangeDirection(Direction.RIGHT);
  }
}
class InputArrowController extends InputHandler {
  Bike controllingBike;
  int goUp, goDown, goLeft, goRight;
  
  InputArrowController (int goUp, int goDown, int goLeft, int goRight, Bike controllingBike) {
    this.goUp     = goUp;
    this.goDown   = goDown;
    this.goLeft   = goLeft;
    this.goRight  = goRight;
    this.controllingBike = controllingBike;
  }
  void KeyPressed () {
   if (controllingBike == null)
     return;
   if (keyCode == goUp)
       controllingBike.ChangeDirection(Direction.UP   );
   else if (keyCode == goDown)
       controllingBike.ChangeDirection(Direction.DOWN );
   else if (keyCode == goLeft)
       controllingBike.ChangeDirection(Direction.LEFT );
   else if (keyCode == goRight)
       controllingBike.ChangeDirection(Direction.RIGHT);
  }
}