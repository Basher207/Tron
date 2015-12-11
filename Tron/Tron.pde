Game game;
void setup () {
  fullScreen (P2D);
  smooth (0);
  loadAllImages();
  SetGame ();
}
void SetGame () {
  game = new Game();
  game.SetupLevel1 ();
}
void draw () {
  game.Update ();
}
void keyPressed () {
  game.KeyPressed ();
}