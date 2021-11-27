PImage image1, image2;
ArrayList<Dot> dots;
ArrayList<PVector> targets1, targets2;
int scaler = 5; 
int threshold = 200;
boolean imageToggled = false;
color col1, col2;

void setup() 
{
  size(50, 50, P2D);  
  image1 = loadImage("Forest1(2).png");
  image2 = loadImage("Forest2.png");
  
  int w, h;
  if (image1.width > image2.width) 
  {
    w = image1.width;
  } else 
  {
    w = image2.width;
  }
  if (image1.height > image2.height) 
  {
    h = image1.height;
  } else
  {
    h = image2.height;
  }
  surface.setSize(w, h);
  
  image1.loadPixels();
  image2.loadPixels();
  
  targets1 = new ArrayList<PVector>();
  targets2 = new ArrayList<PVector>();
  
  for (int x = 0; x < image2.width; x += scaler) {
    for (int y = 0; y < image2.height; y += scaler) {
      int loc = x + y * image2.width;

      if (brightness(image2.pixels[loc]) > threshold) {
        targets2.add(new PVector(x, y));
      }
    }
  }

  dots = new ArrayList<Dot>();

  for (int x = 0; x < image1.width; x += scaler) 
  {
    for (int y = 0; y < image1.height; y += scaler) 
    {
      int loc = x + y * image1.width;
      
      if (brightness(image1.pixels[loc]) > threshold) 
      {
        int targetIndex = int(random(0, targets2.size()));
        targets1.add(new PVector(x, y));
        color experiment = color(int(random(100)),(int(random(255))),(int(random(215))));
        Dot dot = new Dot(x, y, experiment, targets2.get(targetIndex));
        dots.add(dot);
      }
    }
  }
}

void draw() 
{ 
  background(0);
  blendMode(ADD);
  boolean flipTargets = true;

  for (Dot dot : dots) 
  {
    dot.run();
    if (!dot.ready) flipTargets = false;
  }
  
  if (flipTargets) 
  {
    for (Dot dot : dots)
    {
      color experiment = color(int(random(100)),(int(random(255))),(int(random(215))));
      if (!imageToggled) 
      {
        int targetIndex = int(random(0, targets1.size()));
        dot.target = targets1.get(targetIndex);
        dot.col = experiment;
      } else {
        int targetIndex = int(random(0, targets2.size()));
        dot.target = targets2.get(targetIndex);
        dot.col = experiment;
      }
    }
    imageToggled = !imageToggled;
  }
    
  surface.setTitle("" + frameRate);
}
