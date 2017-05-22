int size = 50;
boolean checkerpiece = false;
boolean mouseClicked = false;
int selectedPieces = 0;
boolean hit;

int currSelected;
int currSelectedBlock;
int ID;
int BlockID;

boolean Update = false;
int screen = 0;

import processing.net.*;

import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;
Minim minim;
AudioPlayer movesound;
AudioPlayer music;

Client c;
String input;
int data[] = new int[6];


ArrayList<Checker_Black> checker = new ArrayList<Checker_Black>();
ArrayList<Square> block = new ArrayList<Square>();
InfoBar InfoBar;

void setup() 
{
  size (400, 420);
  background(0);
  smooth();

  data[0] = 0;
  data[3] = 0;
  data[4] = 0;

  minim = new Minim(this); //Music 
  movesound = minim.loadFile("movesound.mp3");
  music = minim.loadFile("music.mp3");

  c = new Client(this, "127.0.0.1", 12345); 

  for (int x = 0; x < width; x += size) 
  {
    for (int y = 0; y < height; y += size) 
    { 
      if ((x+y) % 20 ==0) 
      {
        if (y < 150)
        {
          checker.add(new Checker_Black(new PVector(x + size/2, y + size/2), color(0, 0, 155), ID, 0));
          ID += 1;
        } else if (y >= 250)
        {
          checker.add(new Checker_Black(new PVector(x + size/2, y + size/2), color(0, 0, 0), ID, 1));
          ID += 1;
        }
      }
    }
  }

  for (int x = 0; x < width; x += size) 
  {
    for (int y = 0; y < height; y += size) 
    { 
      if ((x+y) % 20 ==0) 
      {
        block.add(new Square(x, y, color(255, 0, 0), size, BlockID, "RED"));
        BlockID += 1;
      } else
      {
        block.add(new Square(x, y, color(0, 0, 0), size, BlockID, "BLACK"));
        BlockID += 1;
      }
    }
  }

  InfoBar = new InfoBar();
}

void draw() 
{
  background(0);
  noStroke();
  InfoBar.Draw();

  //music.play();

  for (int i = 0; i < block.size(); i++)
  {

    block.get(i).Draw();
    InfoBar.Draw();
  }


  if (data[3] == 0)
  {
    fill(0, 150, 0); //play
    rect(30, 140, 350, 80);
    textSize(20);
    fill(0, 0, 0);
    if (data[4] == 0)
    {
      text("Awaiting server connection...", 50, 177);
      textSize(12);
      fill(255, 255, 0);
      text("Warning: Do not run client until server has been opened", 46, 205);
    }

    if (data[4] == 1)
    {
      text("Server is playing on one device...", 50, 177);
    }
  }

  if (data[3] == 1)
  {
    for (int i = 0; i<checker.size(); i++)
    {
      checker.get(i).Draw();
      checker.get(i).select();
      checker.get(i).Move();
      InfoBar.Draw();


      if (data[0] == 0)
      {
        checker.get(i)._isSelected = false;
      }
    }
  }


  for (int i = 0; i < block.size(); i++)
  {
    for (int j = 0; j < checker.size(); j++)
    {
      if (c.available() > 0) 
      {
        input = c.readString();
        input = input.substring(0, input.indexOf("\n")); // Only up to the newline
        data = int(split(input, ' ')); // Split values into an array;
        checker.get(data[2])._pos.x = block.get(data[1])._posX + 25;
        checker.get(data[2])._pos.y = block.get(data[1])._posY + 25;
      }
    }
  }
}

void mouseClicked()
{
  for (int i = 0; i < checker.size(); i++)
  {
    checker.get(i)._isSelected = false;

    if (checker.get(i).checkerCollision())
    {
      currSelected = checker.get(i)._ID;
      checker.get(currSelected)._isSelected = true;
    }
  }
}