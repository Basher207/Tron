Game game;

void setup () {
  //size (1000,1000,P2D);
  fullScreen (P2D);
  pixelDensity (displayDensity ());
  game = new Game ();
  smooth (0);
}
void draw () {
  game.Update ();
}
void keyPressed () {
  game.KeyPressed ();
  if (key == 'e')
    game.paused = !game.paused;
}
void mousePressed () {
	game.MousePressed ();
  game.SetPause (!game.paused);
}