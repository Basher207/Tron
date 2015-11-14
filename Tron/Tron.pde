ArrayList <Bike>         bikes;
ArrayList <InputHandler> inputHandlers;
ArrayList <GUI>          guis;
void setup () {
  //size (800, 800, P3D); 
  fullScreen ();
  smooth (0);
  bikes = new ArrayList<Bike> ();
  inputHandlers = new ArrayList<InputHandler> ();
  guis = new ArrayList<GUI> ();
  bikes.add (new Bike (new GridVector (width/2 + 250, height/2), Direction.LEFT, 4, color (255, 0, 0)));
  //guis.add (new ScoreBoard (new GridVector (width / 8, height / 8), bikes.get (bikes.size () - 1)));
  inputHandlers.add (new InputArrowController (UP, DOWN, LEFT, RIGHT, bikes.get(bikes.size() - 1)));
  bikes.add (new Bike (new GridVector (width/2 - 250, height/2), Direction.RIGHT, 4, color (0, 0, 255)));
  inputHandlers.add (new InputController ('t', 'g', 'f', 'h', bikes.get(bikes.size () - 1)));
  bikes.add (new Bike (new GridVector (width/2, height/2 - 250), Direction.DOWN, 4, color (0, 255, 0)));
  ftinputHandlers.add (new InputController ('i', 'k', 'j', 'l', bikes.get(bikes.size () - 1)));
  bikes.add (new Bike (new GridVector (width/2, height/2 + 250), Direction.UP, 4, color (200, 70, 250)));
  inputHandlers.add (new InputController ('w', 's', 'a', 'd', bikes.get(bikes.size () - 1)));
}
void draw () {
  background (0);
  for (Bike bike : bikes) {
    for (Trail trail : bike.trails) {
      trail.Render ();
    }
    bike.Render ();
    bike.Update ();
  }
  //for (GUI gui : guis) {
  // gui.Render (); 
  //}
}
void keyPressed () {
  if (key == ' ') {
    setup();
    return;
  }
  for (InputHandler inputCont : inputHandlers)
    inputCont.KeyPressed ();
}