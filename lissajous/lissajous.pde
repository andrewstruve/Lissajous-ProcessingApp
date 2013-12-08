import themidibus.*;
int midi[] = new int[1024];

MidiBus myBus;

float updateSpeed = 1.0; 
float A1 = 400.0;
float A2 = 100.0;
float phi1 = 0.0;
float phi2 = 0.0;
float phi1_val = 0.0;
float phi2_val = 0.0;
float offset1 = 0.0;
float offset2 = 3.14159 / 2.0;
int lastTime = 0;
int start_time = 0;
dot[] dots;
int count = 600;
int c=0;
int mode = 0; 
int i = 0;

void setup()
{
   // Init Midi Control
   MidiBus.list();
   myBus = new MidiBus(this, 0,3);
   // create an 800 by 600 window
   //size (800,600);
   size(displayWidth, displayHeight);
   noStroke();
   background(0);
   lastTime = millis();
   // initialize dots object array
   dots = new dot[count];
   // initialize the dots to 0,0
   for(int i = 0; i < count; i++)
   {
     dots[i] = new dot(0.0,0.0,255,255,255);
   }
   // set initial parameters
   setPreset4();
   
}
void draw()
{
    background(0);
    for(int i = 0; i < count; i++)
    {
       phi1_val += phi1;
       if(phi1_val > 2*3.14159)
          phi1_val = 0.0;
       phi2_val += phi2;
       if(phi2_val > 2*3.14159)
          phi2_val = 0.0;
      c+= 2;
      if(c > 255)
          c = 0;
      dots[i].update(c+100,c+20,c+40);
      dots[i].draw();
    }
    
}
void update()
{
      if(mode == 0)
      {
       
        
      }  
      else if(mode == 1)
      {
        
      }
}
class dot
{
  // position
  float x;
  float y; 
  // color
  int r;
  int g;
  int b;
  //constructor
  dot(float x_temp, float y_temp, int r_temp, int g_temp, int b_temp)
  {
    x = x_temp;
    y = y_temp;
    r = r_temp;
    g = g_temp;
    b = b_temp; 
  }
  void update(int r_temp, int g_temp, int b_temp)
  {
     x = A1 * sin(phi1_val) + offset1+400;
     y = A2 * sin(phi2_val) + offset2+300;
     r = r_temp;
     g = g_temp;
     b = b_temp;
  }
  void draw()
  {
     fill(r,g,b);
     ellipse(x,y,6,6);
  }
}
void setUpdateSpeed(float speed)
{
  updateSpeed = speed;
}
float getUpdateSpeed()
{
  return updateSpeed;
}
void setAmplitude1(float amplitude)
{
  A1 = amplitude;
}
float getAmplitude1()
{
  return A1;
}
void setAmplitude2(float amplitude)
{
  A2 = amplitude;
}
float getAmplitude2()
{
  return A2;
}
void setPhi1(float phi)
{
 phi1 = phi; 
}
float getPhi1()
{
  return phi1;
}
void setPhi2(float phi)
{
  phi2 = phi;
}
float getPhi2()
{
  return phi2;
}
void setOffset1(float offset)
{
 offset1 = offset; 
}
float getOffset1()
{
  return offset1;
}
void setOffset2(float offset)
{
  offset2 = offset;
}
float getOffset2()
{
  return offset2; 
}
void keyPressed()
{
  switch(key)
  {
    case '1':
      setPreset1();
      break;
    case '2':
      setPreset2();
      break;
    case '3':
      setPreset3();
      break;
    case '4':
      setPreset4();
      break;
    case '5':
      setPreset5();
      break;   
    case '6':
      setPreset6();
      break;   
  } 
}
void rawMidi(byte[] data) { // You can also use rawMidi(byte[] data, String bus_name)
  int Stat_midCom = 0;
  int param2 = 0;
  int param3 = 0;
  // Receive some raw data
  // data[0] will be the status byte
  // data[1] and data[2] will contain the parameter of the message (e.g. pitch and volume for noteOn noteOff)
  println();
  println("Raw Midi Data:");
  println("--------");
  println("Status Byte/MIDI Command:"+(int)(data[0] & 0xFF));
  Stat_midCom = (int)(data[0] & 0xFF);
  // N.B. In some cases (noteOn, noteOff, controllerChange, etc) the first half of the status byte is the command and the second half if the channel
  // In these cases (data[0] & 0xF0) gives you the command and (data[0] & 0x0F) gives you the channel
  for (int i = 1;i < data.length;i++) {
    println("Param "+(i+1)+": "+(int)(data[i] & 0xFF));
    
  }
  param2 = (int)(data[1] & 0xFF);
  param3 = (int)(data[2] & 0xFF);
  midi[param2] = (int) map(param3,0,127,0,(int)width);
  println("Stat_midCom  ="+ Stat_midCom);
}

// preset parameters that prove to
// show cool patterns. usually slow changing
void setPreset1()
{
  phi1 = 0.003;
  phi2 = 0.01205;
  A1 = 400.0;
  A2 = 100.0;
  offset1 = 0.0;
  offset2 = 3.14159 / 2.0;
}
void setPreset2()
{
  phi1 = 0.006;
  phi2 = 0.01205;
  A1 = 400.0;
  A2 = 100.0;
  offset1 = 0.0;
  offset2 = 3.14159 / 2.0;  
}
void setPreset3()
{
  phi1 = 0.009;
  phi2 = 0.01205;
  A1 = 400.0;
  A2 = 100.0;
  offset1 = 0.0;
  offset2 = 3.14159 / 2.0; 
}
void setPreset4()
{
  phi1 = 0.00600;
  phi2 = 0.00605;
  A1 = 400.0;
  A2 = 100.0;
  offset1 = 0.0;
  offset2 = 3.14159 / 2.0;   
}
void setPreset5()
{
  phi1 = 0.02400;
  phi2 = 0.00605;
  A1 = 400.0;
  A2 = 200.0;
  offset1 = 0.0;
  offset2 = 3.14159 / 4.0;  
}
void setPreset6()
{
  phi2 = 0.02400;
  phi1 = 0.00605;
  A1 = 400.0;
  A2 = 200.0;
  offset1 = 0.0;
  offset2 = 3.14159 / 4.0;  
}
