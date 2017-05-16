 class Square
{
  float _posX;
  float _posY;
  color _color;
  int _size;
  int _ID;
  String _Color;

  Square(float posX, float posY, color Color, int size, int ID, String Name)
  {
    _posX = posX;
    _posY = posY;
    _color = Color;
    _size = size;
    _ID = ID;
    _Color = Name;
  }

  public void Draw()
  {
    fill(_color);
    rect(_posX, _posY, _size, _size);
  }

  public boolean spaceCollision() {
    if (mouseX >= _posX & mouseX <= _posX + _size & 
      mouseY >= _posY & mouseY <= _posY + _size)
    {
      return true;
    } else 
    {
      return false;
    }
  }
}