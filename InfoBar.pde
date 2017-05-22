class InfoBar
{
  PVector pos;

  InfoBar()
  {
    pos = new PVector(-5, 398);
  }

  public void Draw()
  {
    fill(169, 169, 169);
    rect(pos.x, pos.y, 410, 30);
    fill(255, 0, 0);
    textSize(15);
    text("score:", 20, 412);
    fill(0, 0, 0);
    text("score:", 150, 412);
    text("ClientStatus:", 270, 412);
  }
}