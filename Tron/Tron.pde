Game game;

void setup () {
  //size (700, 700,P3D;
  fullScreen (P2D);
  
  smooth (0);
  SetGame ();
}
void Intializations () {
  
}
void SetGame () {
	game = new Game();
}
void draw () {
  game.Update ();
  println(frameRate);
}
void keyPressed () {
  game.KeyPressed ();
}
void mousePressed () {
	game.MousePressed ();
}