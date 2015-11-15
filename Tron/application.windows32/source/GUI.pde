abstract class GUI extends GameObject {
  
}
class ScoreBoard extends GUI {
  Bike bike;
  ScoreBoard (GridVector position, Bike bike) {
    this.position = position;
    this.bike = bike;
  }
  void Render () {
    text (bike.lives, position.x, position.y);
  }
}