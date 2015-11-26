class Game {
  ArrayList <Player>  players;
  ArrayList <GUI>     guis;
  ArrayList <Item>    items;

  boolean paused = false;
  Menu menu;


  int framesSinceStart = 0;
  
  Game () {
    Reset ();
    SetupLevel1 ();
    SetupSound ();
    SetPause (false);
  }
  void Reset () {
    players = new ArrayList <Player> ();
    guis    = new ArrayList <GUI> ();
    items   = new ArrayList <Item> ();
  }
  void SetupLevel1 () {
    Reset ();
    menu = new Menu ();

    Bike bike1 = new Bike (new GridVector (width/2 + 250, height/2), Direction.LEFT , 2, color (255, 0  , 0  ));
    Bike bike2 = new Bike (new GridVector (width/2 - 250, height/2), Direction.RIGHT, 2, color (0  , 0  , 255));
    Bike bike3 = new Bike (new GridVector (width/2, height/2 - 250), Direction.DOWN , 2, color (0  , 255, 0  ));
    Bike bike4 = new Bike (new GridVector (width/2, height/2 + 250), Direction.UP   , 2, color (200, 70 , 250));
    Bike bike5 = new Bike (new GridVector (width/2 - 250, height/2 - 250), Direction.RIGHT, 2, color(255,255,255));
    //Bike ps4Bike = new Bike (new GridVector (50, 50), Direction.DOWN , 2, color (0  , 255, 0  ));
    //InputJoystickController ps4Controller = new InputJoystickController (controlIO.getMatchedDevice(CONFIGFILEPATH), ps4Bike);

    KeyboardHandler inputHandler1 = new InputArrowController (UP , DOWN, LEFT, RIGHT, bike1);
    KeyboardHandler inputHandler2 = new InputController      ('t', 'g' , 'f' , 'h'  , bike2);
    KeyboardHandler inputHandler3 = new InputController      ('i', 'k' , 'j' , 'l'  , bike3);
    KeyboardHandler inputHandler4 = new InputController      ('w', 's' , 'a' , 'd'  , bike4);
    KeyboardHandler inputHandler5 = new InputController      ('z', 'x' , 'c' , 'v'  , bike5);

    //players.add (new JoyStickPlayer (ps4Bike, ps4Controller));
    players.add (new KeyBoardPlayer (bike1, inputHandler1));
    players.add (new KeyBoardPlayer (bike2, inputHandler2));
    players.add (new KeyBoardPlayer (bike3, inputHandler3));
    players.add (new KeyBoardPlayer (bike4, inputHandler4));
    players.add (new KeyBoardPlayer (bike5, inputHandler5));
  }
  void Update () {
    background (0);
    if (!paused)
      for (Player player : players)
        player.Update ();
      
    for (Player player : players) {
      player.Render ();
    }
    for (int i = items.size () - 1; i >= 0; i--) {
      items.get (i).Render ();
      if (!paused)
        items.get (i).CheckPickup ();
    }
    for (Player player : players) {
      player.Render ();
    }
    if (!paused) {
      if (framesSinceStart++ % 300 == 200)
        if (items.size () < 2)
          items.add (new GhostPickup (new GridVector ((int)random (width), (int)random (height)), 50, 50));
    } else {
      menu.Update ();
    }
    rectMode (CORNERS);
    noFill ();
    strokeWeight (1);
    stroke (255,255,0);
    rect (0,0,width - 1,height - 1);
  }
  void KeyPressed () {
    for (Player player : players) {
      player.KeyPressed ();
    }
    if (key == ' ')
      SetGame ();
    else if (key == 'e')
      game.SetPause (!game.paused);
  }
  void MousePressed () {
    menu.MousePressed ();
  }
  void SetPause (boolean pause) {
    paused = pause;
  }
}
abstract class Player {
  Bike bike;
  abstract void Update ();
  abstract void Render ();
  abstract void KeyPressed ();
}
class KeyBoardPlayer extends Player {
  KeyboardHandler inputHandler;
  KeyBoardPlayer (Bike bike, KeyboardHandler inputHandler) {
    this.bike = bike;
    this.inputHandler = inputHandler;
  }
  void Update () {
    bike.Update ();
  }
  void Render () {
    bike.Render ();
  }
  void KeyPressed () {
    inputHandler.KeyPressed ();
  }
}
class JoyStickPlayer extends Player {
  InputJoystickController inputHandler;
  JoyStickPlayer (Bike bike, InputJoystickController inputHandler) {
    this.bike = bike;
    this.inputHandler = inputHandler;
  }
  void Update () {
    bike.Update ();
    inputHandler.Update ();
  }
  void Render () {
    bike.Render ();
  }
  void KeyPressed () {}
}