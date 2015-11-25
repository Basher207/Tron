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
    paused = false;
  }
  void Reset () {
    players = new ArrayList <Player> ();
    guis    = new ArrayList <GUI> ();
    items   = new ArrayList <Item> ();
  }
  void SetupLevel1 () {
    Reset ();
    menu = new Menu ();

    Bike bike1 = new Bike (new GridVector (width/2 + 248, height/2), Direction.LEFT , 2, color (255, 0  , 0  ));
    Bike bike2 = new Bike (new GridVector (width/2 - 248, height/2), Direction.RIGHT, 2, color (0  , 0  , 255));
    Bike bike3 = new Bike (new GridVector (width/2, height/2 - 252), Direction.DOWN , 2, color (0  , 255, 0  ));
    Bike bike4 = new Bike (new GridVector (width/2, height/2 + 252), Direction.UP   , 2, color (200, 70 , 250));

    InputHandler inputHandler1 = new InputArrowController (UP , DOWN, LEFT, RIGHT, bike1);
    InputHandler inputHandler2 = new InputController      ('t', 'g' , 'f' , 'h'  , bike2);
    InputHandler inputHandler3 = new InputController      ('i', 'k' , 'j' , 'l'  , bike3);
    InputHandler inputHandler4 = new InputController      ('w', 's' , 'a' , 'd'  , bike4);

    players.add (new Player (bike1, inputHandler1));
    players.add (new Player (bike2, inputHandler2));
    players.add (new Player (bike3, inputHandler3));
    players.add (new Player (bike4, inputHandler4));
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
      if (framesSinceStart++ % 600 == 0)
        items.add (new GhostPickup (new GridVector ((int)random (width), (int)random (height)), 50, 50));
    } else {
      menu.Update ();
    }
  }
  void KeyPressed () {
    for (Player player : players) {
      player.KeyPressed ();
    }
    if (key == ' ')
      setup ();
  }
  void MousePressed () {
    menu.MousePressed ();
  }
  void SetPause (boolean pause) {
    paused = pause;
  }
}
class Player {
  Bike bike;
  InputHandler inputHandler;
  Player (Bike bike, InputHandler inputHandler) {
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