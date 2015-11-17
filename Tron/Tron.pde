Game game;
void setup () {
  fullScreen (P2D);
  game = new Game ();
}
void draw () {
  game.Update ();
}
void keyPressed () {
  game.KeyPressed ();
}