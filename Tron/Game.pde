class Game {
  ArrayList <Player     > players;
  ArrayList <Obstical   > obsticals;
  ArrayList <GUI        > guis;
  ArrayList <Item       > items;
  ArrayList <ItemSpawner> itemSpawners;
  ArrayList <Trail      > trails;
  
  boolean paused = false;
  Menu menu;


  int framesSinceStart = 0;
  
  Game () {
    SetPause (false);
  }
  void Reset () {
    trails       = new ArrayList <Trail      > ();
    players      = new ArrayList <Player     > ();
    guis         = new ArrayList <GUI        > ();
    obsticals    = new ArrayList <Obstical   > ();
    items        = new ArrayList <Item       > ();
    itemSpawners = new ArrayList <ItemSpawner> ();
    SetupSound ();
  }
  void SetupLevel1 () {
    Reset ();
    menu = new Menu ();
    GridVector [] verts = {
      new GridVector (2        , 2         ),new GridVector (width - 2, 2         ), 
      new GridVector (width - 2, height - 2),new GridVector (2        , height - 2)
    };
    obsticals.add(new Obstical (verts, color(255,255,255)));
    //items.add (new KillBlock (new GridVector (round (width * 0.4), round (height * 0.4)), 50));
    itemSpawners.add(new ItemSpawner(new GridVector (width / 4, height / 4), 300));
    itemSpawners.add(new ItemSpawner(new GridVector (width - width / 4, height - height / 4), 300));
    itemSpawners.add(new ItemSpawner(new GridVector (width - width / 4, height / 4), 300));
    itemSpawners.add(new ItemSpawner(new GridVector (width / 4, height - height / 4), 300));
    
    Bike bike1 = new Bike (new GridVector (width/2 + 250, height/2), Direction.LEFT , 2, color (255, 0  , 0  ));
    Bike bike2 = new Bike (new GridVector (width/2 - 250, height/2), Direction.RIGHT, 2, color (0  , 0  , 255));
    Bike bike3 = new Bike (new GridVector (width/2, height/2 - 250), Direction.DOWN , 2, color (0  , 255, 0  ));
    Bike bike4 = new Bike (new GridVector (width/2, height/2 + 250), Direction.UP   , 2, color (200, 70 , 250));
    //Bike bike5 = new Bike (new GridVector (width/2 - 250, height/2 - 250), Direction.RIGHT, 2, color(255,255,255));

    //Bike ps4Bike= new Bike (new GridVector (width - 50, height - 50), Direction.DOWN , 2, color (0  , 255, 0  ));
    //InputJoystickController ps4Controller = new InputJoystickController (controlIO.getMatchedDevice(CONFIGFILEPATH), ps4Bike);

    KeyboardHandler inputHandler1 = new InputArrowController (UP , DOWN, LEFT, RIGHT, bike1);
    KeyboardHandler inputHandler2 = new InputController      ('t', 'g' , 'f' , 'h'  , bike2);
    KeyboardHandler inputHandler3 = new InputController      ('i', 'k' , 'j' , 'l'  , bike3);
    KeyboardHandler inputHandler4 = new InputController      ('w', 's' , 'a' , 'd'  , bike4);
    //KeyboardHandler inputHandler5 = new InputController      ('z', 'x' , 'c' , 'v'  , bike5);

    //players.add (new JoyStickPlayer (ps4Bike, ps4Controller));
    players.add (new KeyBoardPlayer (bike1,  inputHandler1));
    players.add (new KeyBoardPlayer (bike2,  inputHandler2));
    players.add (new KeyBoardPlayer (bike3,  inputHandler3));
    players.add (new KeyBoardPlayer (bike4,  inputHandler4));
    //players.add (new KeyBoardPlayer (bike5,  inputHandler5));
  }
  void Update () {
    background (0);
    if (!paused)
      for (Player player : players)
        player.Update ();
    for (Trail trail : trails) {
      trail.Render ();
    }
    for (Player player : players) {
      player.Render ();
    }
    for (int i = items.size () - 1; i >= 0; i--) {
      items.get (i).Render ();
      if (!paused)
        items.get (i).CheckPickup ();
    }
    if (!paused) {
        for (ItemSpawner itemSpawner : itemSpawners) {
          itemSpawner.Update();
          itemSpawner.Render();
        }
    } else {
      menu.Update ();
    }
    framesSinceStart++;
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
    if (paused)
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
  Player (Bike bike) {
    this.bike = bike;
  }
  abstract void KeyPressed ();
}
class KeyBoardPlayer extends Player {
  KeyboardHandler inputHandler;
  KeyBoardPlayer (Bike bike, KeyboardHandler inputHandler) {
    super(bike);
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
    super(bike);
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