import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Tron extends PApplet {

ArrayList <Bike>         bikes;
ArrayList <InputHandler> inputHandlers;
ArrayList <GUI>          guis;
ArrayList <Item>  items;
public void setup () {
  //size (800, 800, P3D); 
  
  
  bikes = new ArrayList<Bike> ();
  inputHandlers = new ArrayList<InputHandler> ();
  guis = new ArrayList<GUI> ();
  items = new ArrayList<Item> ();
  //items.add (new SpeedBoost (new GridVector (width/2 + 50 ,height /2 + 50), 30));
  bikes.add (new Bike (new GridVector (width/2 + 250, height/2), Direction.LEFT, 2, color (255, 0, 0)));
  //guis.add (new ScoreBoard (new GridVector (width / 8, height / 8), bikes.get (bikes.size () - 1)));
  inputHandlers.add (new InputArrowController (UP, DOWN, LEFT, RIGHT, bikes.get(bikes.size() - 1)));
  bikes.add (new Bike (new GridVector (width/2 - 250, height/2), Direction.RIGHT, 2, color (0, 0, 255)));
  inputHandlers.add (new InputController ('t', 'g', 'f', 'h', bikes.get(bikes.size () - 1)));
  bikes.add (new Bike (new GridVector (width/2, height/2 - 250), Direction.DOWN, 2, color (0, 255, 0)));
   inputHandlers.add (new InputController ('i', 'k', 'j', 'l', bikes.get(bikes.size () - 1)));
  bikes.add (new Bike (new GridVector (width/2, height/2 + 250), Direction.UP, 2, color (200, 70, 250)));
  inputHandlers.add (new InputController ('w', 's', 'a', 'd', bikes.get(bikes.size () - 1)));
}
public void draw () {
  background (0);
  for (Bike bike : bikes) {
    for (Trail trail : bike.trails) {
      trail.Render ();
    }
    bike.Render ();
    bike.Update ();
  }
  for (int i = items.size () - 1; i >= 0; i--) {
    Item item = items.get (i);
    item.Render ();
    item.CheckPickup ();
  }
  //for (GUI gui : guis) {
  // gui.Render (); 
  //}
}
public void keyPressed () {
  if (key == ' ') {
    setup();
    return;
  }
  for (InputHandler inputCont : inputHandlers)
    inputCont.KeyPressed ();
}
abstract class GUI extends GameObject {
  
}
class ScoreBoard extends GUI {
  Bike bike;
  ScoreBoard (GridVector position, Bike bike) {
    this.position = position;
    this.bike = bike;
  }
  public void Render () {
    text (bike.lives, position.x, position.y);
  }
}
class Game {
  
}
class Player {
  Bike bike;
  InputHandler inputHandler;
  Player (Bike bike, InputHandler inputHandler) {
   this.bike = bike;
   this.inputHandler = inputHandler; 
  }
  
}
abstract class GameObject {
  GridVector position;
  public abstract void Render ();
}
abstract class DynamicObject extends GameObject {
  public abstract void Update ();
}
class Bike extends DynamicObject {
  int speed;
  Direction direction;
  Direction nextFrameDirection = Direction.NON;
  boolean turnnedThisFrame;
  int bikeColor;
  boolean alive = true;
  int lives;
  ArrayList <Trail> trails;
  Trail currentTrail;
  Bike (GridVector position, Direction direction, int speed, int bikeColor) {
    this.position       = position;
    this.direction      = direction;
    this.speed          = speed;
    this.bikeColor = bikeColor;
    lives = 5;
    trails = new ArrayList<Trail> ();
    currentTrail = new Trail (position.Get(), bikeColor);
    trails.add (currentTrail);
  }
  public void Render () {
    if (!alive)
      return;
    rectMode (CENTER);
    stroke (255);
    fill (bikeColor);
    rect (position.x, position.y, 4, 4);
  }
  public void Update () {
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
  public void ChangeDirection (Direction direction) {
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
  public boolean MoveToPoint (GridVector point) {
    for (Bike bike : bikes) 
      for (Trail trail : bike.trails) {
        if (trail.TouchedLine (point)) {
          return true;
        }
      }
    if (point.x < 0) {
      currentTrail.endPosition.Set (position);
      point.x = width - point.x;
      currentTrail = new Trail (point, bikeColor);
      trails.add (currentTrail);
    } else if (point.x > width) {
      currentTrail.endPosition.Set (point);
      point.x = width - point.x;
      currentTrail = new Trail (point, bikeColor);
      trails.add (currentTrail);
    }
    if (point.y < 0) {
      currentTrail.endPosition.Set (position);
      point.y = height - point.y;
      currentTrail = new Trail (point, bikeColor);
      trails.add (currentTrail);
    } else if (point.y > height) {
      currentTrail.endPosition.Set (point);
      point.y = height - point.y;
      currentTrail = new Trail (point, bikeColor);
      trails.add (currentTrail);
    }
    return false;
  }
}
class Trail extends GameObject {
  GridVector endPosition;
  int trailColor;
  Trail (GridVector position, int trailColor) {
    this.position = position.Get ();
    this.endPosition = position.Get();
    this.trailColor = trailColor;
  }
  public void Render () {
    strokeWeight (1);
    stroke (trailColor);
    line (position.x, position.y, endPosition.x, endPosition.y);
  }
  public boolean TouchedLine (GridVector checkPoint) {
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
abstract class InputHandler {
   public abstract void KeyPressed ();
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
  public void KeyPressed () {
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
  public void KeyPressed () {
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
abstract class Item extends GameObject {
  int size;
  public abstract void Pickup (Bike pickedUpBike);
  public void CheckPickup () {
    for (Bike bike : bikes) {
      if (abs (bike.position.x - position.x) < size / 2 && abs (bike.position.y - position.y) < size / 2) 
        Pickup (bike);
    }
  }
}
class SpeedBoost extends Item {
  PVector rotation;
  SpeedBoost (GridVector position, int size) {
    this.size = size;
    rotation = new PVector (0, 0, 0);
    this.position = position;
  }
  public void Render () {
    rotation.z += 0.05f;
    rectMode(CENTER);
    pushMatrix ();
    noFill ();
    stroke (255, 165, 0);
    translate (position.x, position.y);
    //rotateX (rotation.x);
    //rotateY (rotation.y);
    //rotateZ (rotation.z);
    rect (0, 0, size, size);
    popMatrix ();
  }
  public void Pickup (Bike pickedUpBike) {
    for (Bike bike : bikes) {
      bike.speed += 5;
      items.remove (this);
    }
  }
}

class GridVector {
  int x; 
  int y;
  GridVector (int x, int y) {
    this.x = x;
    this.y = y;
  }
  public GridVector Add (GridVector gridVector) {
    x += gridVector.x;
    y += gridVector.y;
    return this;
  }
  public GridVector Multi (int times) {
    x *= times;
    y *= times;
    return this;
  }
  public GridVector Div (int by) {
    x /= by;
    y /= by;
    return this;
  }
  public GridVector Get () {
    return new GridVector (x, y);
  }
  public void Set (GridVector gridVector) {
    x = gridVector.x;
    y = gridVector.y;
  }
  public boolean Equals (GridVector gridVector) {
    return (x == gridVector.x) && (y == gridVector.y);
  }
  public void SetDirection (Direction direction) {
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
  public boolean OppositeDirection (Direction direction, Direction otherDirection) {

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
public GridVector GridFromDirection (Direction direction) {
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
  public void settings() {  fullScreen (P3D);  smooth (0); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Tron" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
