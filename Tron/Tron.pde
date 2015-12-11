Game game;
void setup () {
  fullScreen (P2D);
  smooth (0);
  game = new Game();
  SetGame ();
}
void SetGame () {
  game.SetupLevel1 ();
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