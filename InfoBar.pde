class InfoBar
{
  PVector pos;

  InfoBar()
  {
    pos = new PVector(0,400);
  }

  public void Draw()
  {
    stroke(255, 255, 0);
    fill(169, 169, 169);
    rect(pos.x, pos.y, 400, 20);
    fill(255, 0, 0);
    textSize(15);
    text("Checkers: " + BlueCheckers, 20, 415);
    fill(0, 0, 0);
    text("Checkers: " + BlackCheckers, 140, 415);
    text("Server Status:", 250, 415);
  }
}