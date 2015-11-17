class Game {
  ArrayList <Player>  players;
  ArrayList <GUI>     guis;
  ArrayList <Item>    items;
  Game () {
    Reset ();
    SetupLevel1 ();
  }
  void Reset () {
    players = new ArrayList <Player> ();
    guis    = new ArrayList <GUI> ();
    items   = new ArrayList <Item> ();
    
  }
  void SetupLevel1 () {
    Reset ();
    
    Bike bike1 = new Bike (new GridVector (width/2 + 250, height/2), Direction.LEFT , 2, color (255, 0  , 0  ));
    Bike bike2 = new Bike (new GridVector (width/2 - 250, height/2), Direction.RIGHT, 2, color (0  , 0  , 255));
    Bike bike3 = new Bike (new GridVector (width/2, height/2 - 250), Direction.DOWN , 2, color (0  , 255, 0  ));
    Bike bike4 = new Bike (new GridVector (width/2, height/2 + 250), Direction.UP   , 2, color (200, 70 , 250));
    
    InputHandler inputHandler1 = new InputArrowController (UP , DOWN, LEFT, RIGHT, bike1);
    InputHandler inputHandler2 = new InputController      ('t', 'g' , 'f' , 'h'  , bike2);
    InputHandler inputHandler3 = new InputController      ('i', 'k' , 'j' , 'l'  , bike3);
    InputHandler inputHandler4 = new InputController      ('w', 's' , 'a' , 'd'  , bike4);
       
    players.add (new Player (bike1, inputHandler1));
    //players.add (new Player (bike2, inputHandler2));
    //players.add (new Player (bike3, inputHandler3));
    players.add (new Player (bike4, inputHandler4));
  }
  void Update () {
    background (0);
    for (Player player : players) {
      player.Update ();
    }
    for (Player player : players) {
      player.Render (); 
    }
    for (Item item : items) {
      item.CheckPickup ();
    }
    for (Player player : players) {
      player.Render ();
    }
  }
  void KeyPressed () {
    for (Player player : players) {
      player.KeyPressed ();
    }
    if (key == ' ')
      setup ();
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