ArrayList <Bike> bikes;
ArrayList <InputHandler> inputHandlers;
void setup () {
  size (500, 500, P3D); 
  smooth (0);
  bikes = new ArrayList<Bike> ();
  inputHandlers = new ArrayList<InputHandler> ();
  bikes.add (new Bike (new GridVector (width/4 * 3, height/2), Direction.LEFT, 2, color (255, 0, 0)));
  inputHandlers.add (new InputArrowController (UP, DOWN, LEFT, RIGHT, bikes.get(bikes.size() - 1)));
  bikes.add (new Bike (new GridVector (width/4, height/2), Direction.RIGHT, 2, color (0, 0, 255)));
  inputHandlers.add (new InputController ('w', 's', 'a', 'd', bikes.get(bikes.size () - 1)));
}
void draw () {
  background (255);
  for (Bike bike : bikes) {
    for (Trail trail : bike.trails) {
      trail.Render ();
    }
    bike.Render ();
    bike.Update ();
  }
}
void keyPressed () {
  if (key == ' ') {
    setup();
    return;
  }
  for (InputHandler inputCont : inputHandlers)
    inputCont.KeyPressed ();
}