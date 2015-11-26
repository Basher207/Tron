Game game;

ControlIO control;
Configuration config;
ControlDevice gpad;

void setup () {
  //size (700, 700,P3D);
  fullScreen (P2D);
  pixelDensity (displayDensity ());
  
  smooth (0);
  SetGame ();
}
void SetGame () {
  game = new Game ();
}
void draw () {
  game.Update ();
}
void keyPressed () {
  game.KeyPressed ();
}
void mousePressed () {
	game.MousePressed ();
}