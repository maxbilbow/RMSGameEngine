//
//  RMSActionProcessor.swift
//  RattleGL
//
//  Created by Max Bilbow on 22/03/2015.
//  Copyright (c) 2015 Rattle Media. All rights reserved.
//

import Foundation


public class RMSActionProcessor {
    let keys: RMSKeys = RMSKeys()
    var activeSprite: RMSParticle {
        return self.world.activeSprite!
    }
    var world: RMXWorld
    
    init(world: RMXWorld){
        self.world = world
        RMXLog()
    }
    
    
    func movement(speed: Float, action: String!, point: CGPoint? = nil){
        //if (keys.keyStates[keys.forward])  [observer accelerateForward:speed];
        if action == nil { return }
        RMXLog("\n\(action!) \(speed), \(self.world.activeSprite!.body.position.z)\n")
        
        if (action == "forward") {
            if speed == 0 {
                self.activeSprite.body.forwardStop()
            }
            else {
                self.activeSprite.body.accelerateForward(speed)
            }
        }
        
        if (action == "back") {
            if speed == 0 {
                self.activeSprite.body.forwardStop()
            }
            else {
                self.activeSprite.body.accelerateForward(-speed)
            }
        }
        if (action == "left") {
            if speed == 0 {
                self.activeSprite.body.leftStop()
            }
            else {
                self.activeSprite.body.accelerateLeft(speed)
            }
        }
        if (action == "right") {
            if speed == 0 {
                self.activeSprite.body.leftStop()
            }
            else {
                self.activeSprite.body.accelerateLeft(-speed)
            }
        }
        
        if (action == "up") {
            if speed == 0 {
                self.activeSprite.body.upStop()
            }
            else {
                self.activeSprite.body.accelerateUp(-speed)
            }
        }
        if (action == "down") {
            if speed == 0 {
                self.activeSprite.body.upStop()
            }
            else {
                self.activeSprite.body.accelerateUp(speed)
            }
        }
        if (action == "jump") {
            if speed == 0 {
                self.activeSprite.actions?.jump()
            }
            else {
                self.activeSprite.actions?.prepareToJump()
            }
        }
        if action == "toggleGravity" && speed == 0{
            self.activeSprite.toggleGravity()
        }
        if action == "universalGravity" && speed == 0 {
            self.world.toggleGravity()
        }
        
        
        if action == "look" && point != nil {
            self.activeSprite.plusAngle(point!, speed: speed)
            RMXLog(self.activeSprite.camera!.viewDescription)
        }
//        else {
//            [RMXGLProxy.activeSprite.mouse setMousePos:x y:y];
    }

}