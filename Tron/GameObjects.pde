abstract class GameObject {
  GridVector position;
  GameObject (GridVector position) {
    this.position = position; 
  }
  abstract void Render ();
}
abstract class DynamicObject extends GameObject {
  DynamicObject (GridVector position) {
    super(position);
  }
  abstract void Update ();
}
interface ColoredObject {
  public color ObjectColor();
}