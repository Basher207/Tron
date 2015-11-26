import net.java.games.input.*;
import org.gamecontrolplus.*;
import org.gamecontrolplus.gui.*;

ControlIO controlIO;
public final static String CONFIGFILEPATH = "gamepad_P1";

abstract class KeyboardHandler {
  Bike controllingBike;
   abstract void KeyPressed ();
}
class InputController extends KeyboardHandler {
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
class InputArrowController extends KeyboardHandler {
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
class InputJoystickController {
  ControlDevice gpad;
  Bike controllingBike;
  InputJoystickController (ControlDevice gpad, Bike controllingBike) {

    this.gpad = gpad;
    this.controllingBike = controllingBike;
  }
  void Update () {
    //if (gpad.getButton ("UP"   ).pressed()) {
    //  controllingBike.ChangeDirection (Direction.UP);
    //} 
    //if (gpad.getButton ("DOWN" ).pressed()) {
    //  controllingBike.ChangeDirection (Direction.DOWN);
    //} 
    //if (gpad.getButton ("LEFT" ).pressed()) {
    //  controllingBike.ChangeDirection (Direction.LEFT);
    //} 
    //if (gpad.getButton ("RIGHT").pressed()) {
    //  controllingBike.ChangeDirection (Direction.RIGHT);
    //} 
  }
}