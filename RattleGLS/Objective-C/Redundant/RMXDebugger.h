//
//  RMXDebugger.h
//  RattleGL3.0
//
//  Created by Max Bilbow on 09/03/2015.
//  Copyright (c) 2015 Rattle Media. All rights reserved.
//

#ifndef RattleGL3_0_RMXDebugger_h
#define RattleGL3_0_RMXDebugger_h


#endif

#define RMX_DEBUGGING           0
#define RMX_FULL_SCREEN         0


#define RMX_TOTAL_CHECKS        7
#define RMX_ERROR               0
#define RMX_OBSERVER            1
#define RMX_WORLD               2
#define RMX_PHYSICS             3
#define RMX_ART                 4
#define RMX_SHAPE               5
#define RMX_LIGHT               6
#define RMX_PARTICLE            7

#define RMX_DISPLAY             11
#define RMX_MOUSE_PROCESSOR     12
#define RMX_MOUSE               5
#define RMX_KEY_PROCESSOR       4
#define RMX_DISPLAY_PROCESSOR   3
#define RMX_SIMPLE_PARTICLE     2
#define RMX_WINDOW              12


#define U_DEPTH                 2
#define U_HORIZONTAL            0
#define U_VERTICAL              1
#define TWIST_AXIS              1
#define NOD_AXIS                0
#define ROLL_AXIS               2
#define U_SPEED                 0.05

#define RMX_DEPRECATED(from, to) __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_##from, __MAC_##to, __IPHONE_NA, __IPHONE_NA)


//@protocol RMXDebuggerProtocol
//@property const bool isDebugging;
//+ (void)add:(int)index n:(id)name t:(NSString*)text;//, ...;
//+ (void)cycle:(int)dir;
//+ (void)feedback;
//@end

//const RMXDebugger *rmxDebugger;
