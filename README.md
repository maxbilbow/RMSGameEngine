# RMSGameEngine
First commit GLS4.0 - Evolved from RattleGL3.0

Slowly building physics fromt the ground up. 
  • Started in C/C++ at uni (2007)
  • Re-coded in C++ (Vesion: OpenGL 2.0)
  • Translated into Objective-C for use on iOS (Version: RattleGL 3.3 https://www.youtube.com/watch?v=Wz75gmL7uVQ)
  • Translated into Swift for better performance alround (Version 4.1)

I've got a coupel of classes for controlling from an iOS decive. However I need to either commit to OpenGLES or Metal. Both of which give me headaches at the moment.

However the only classes that will need changing are RMXShapes, RMXGLProxy and RMXCamera; all of which are designed for C-based OpenGL calls.
