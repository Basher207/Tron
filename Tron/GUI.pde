abstract class GUI extends GameObject {
  GUI (GridVector position) {
    super(position);
  }
}
class ScoreBoard extends GUI {
  Bike bike;
  ScoreBoard (GridVector position, Bike bike) {
    super(position);
    this.bike = bike;
  }
  void Render () {
    //text (bike.lives, position.x, position.y);
  }
}