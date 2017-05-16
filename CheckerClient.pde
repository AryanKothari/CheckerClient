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

import processing.net.*;

Client c;
String input;
int data[] = new int[3];


ArrayList<Checker_Black> checker = new ArrayList<Checker_Black>();
ArrayList<Square> block = new ArrayList<Square>();

void setup() 
{
  size (400, 400);
  background(0);
  smooth();

  data[0] = 0;


  c = new Client(this, "127.0.0.1", 12345); 

  for (int x = 0; x < width; x += size) 
  {
    for (int y = 0; y < height; y += size) 
    { 
      if ((x+y) % 20 ==0) 
      {
        block.add(new Square(x, y, color(255, 0, 0), size, ID, "RED"));
        BlockID += 1;
        if (y < 150)
        {
          checker.add(new Checker_Black(new PVector(x + size/2, y + size/2), color(0, 0, 155), ID, 0));
          ID += 1;
        } else if (y >= 250)
        {
          checker.add(new Checker_Black(new PVector(x + size/2, y + size/2), color(0, 0, 0), ID, 1));
          ID += 1;
        }
      } else
      {
        block.add(new Square(x, y, color(0, 0, 0), size, ID, "BLACK"));
        BlockID += 1;
      }
    }
  }
}

void draw() 
{
  background(0);
  noStroke();

  for (int i = 0; i < block.size(); i++)
  {

    block.get(i).Draw();

    if (mousePressed)
    {
      if (block.get(i).spaceCollision())
      {
        currSelectedBlock = block.get(i)._ID;
        println(block.get(i)._ID);
      }
    }
  }

  for (int i = 0; i<checker.size(); i++)
  {
    checker.get(i).Draw();
    checker.get(i).select();
    checker.get(i).Move();

    if (data[0] == 0)
    {
      checker.get(i)._isSelected = false;
    }

    if (c.available() > 0) {
      input = c.readString();
      input = input.substring(0, input.indexOf("\n")); // Only up to the newline
      data = int(split(input, ' ')); // Split values into an array;
      //println(data[2], data[3]);
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