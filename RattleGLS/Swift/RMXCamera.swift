//
//  RMXCamera.swift
//  RattleGL
//
//  Created by Max Bilbow on 13/03/2015.
//  Copyright (c) 2015 Rattle Media. All rights reserved.
//

import Foundation

@objc public class RMXCamera {
    
    var world: RMXWorld?
    var pov: RMSParticle?
    var near, far, fieldOfView: Float
    var facingVector: GLKVector3 = RMXVector3Zero()
    var effect: GLKBaseEffect! = nil
//    var gameView: GameView! = nil
    var aspectRatio: Float  {
        return Float(self.viewWidth) / Float(self.viewHeight)
    }
    var viewWidth: Float
    var viewHeight: Float

    var projectionMatrix: GLKMatrix4 {
        return GLKMatrix4MakePerspective(GLKMathDegreesToRadians(self.fieldOfView), self.aspectRatio, self.near, self.far)
    }
    
    func getProjectionMatrix(width: Float, height: Float) -> GLKMatrix4 {
        self.viewWidth = width
        self.viewHeight = height
        return self.projectionMatrix
    }
    var modelViewMatrix: GLKMatrix4 {
        return GLKMatrix4MakeLookAt(
            self.eye.x, self.eye.y, self.eye.z,
            self.center.x,  self.center.y, self.center.z,
            self.up.x,      self.up.y,     self.up.z)
    }
    init(world: RMSWorld?, pov: RMSParticle! = nil,viewSize: (Float,Float) = (1280, 750), farPane far: Float = 2000 ){
        self.world = world ?? pov as! RMSWorld
        self.far = far
        self.near = 1
        self.fieldOfView = 65.0
        self.pov = pov ?? world?.activeSprite
        self.viewHeight = viewSize.1
        self.viewWidth = viewSize.0
    }
    
    
    
    public var eye: GLKVector3 {
        return self.pov!.body.position
    
    }
    
    public var center: GLKVector3{
        return GLKVector3Add(GLKVector3Make(Float(self.pov!.body.orientation.m13), Float(self.pov!.body.orientation.m23), Float(self.pov!.body.orientation.m33)), self.pov!.body.position)
    }
    
    public var up: GLKVector3 {
        let simple = true
        if simple {
            return GLKVector3Make(0,1,0)
        } else {
            //return SCNVector3Make(pov.body.orientation.m12,pov.body.orientation.m22,pov.body.orientation.m32)
        }
    }
    
//    private func makeLookAtGl(lookAt: CFunctionPointer<(Double, Double, Double, Double, Double, Double, Double, Double, Double) -> Void>) -> Void {
//     //   RMSMakeLookAtGL(self)
//        RMXMakeLookAtGL(lookAt,
//            Double(self.eye.x),     Double(self.eye.y),    Double(self.eye.z),
//            Double(self.center.x),  Double(self.center.y), Double(self.center.z),
//            Double(self.up.x),      Double(self.up.y),     Double(self.up.z)
//        )
//    
//        
//    }
    
    
    func updateView(){
        if RMX.usingDepreciated {
            RMXGLMakeLookAt(self)
        } else if self.effect != nil {
            self.effect.transform.modelviewMatrix = GLKMatrix4MakeLookAt(
                self.eye.x, self.eye.y, self.eye.z,
                self.center.x,  self.center.y, self.center.z,
                self.up.x,      self.up.y,     self.up.z)
        } else {
            fatalError("Camera Error in \(__FILE__)")
        }

    }
    var viewDescription: String {
        return "\n      EYE x\(self.eye.x), y\(self.eye.y), z\(self.eye.z)\n   CENTRE x\(self.center.x), y\(self.center.y), z\(self.center.z)\n      UP: x\(self.up.x), y\(self.up.y), z\(self.up.z)\n"
    }
    

    
    func makePerspective(width: Int32, height:Int32, inout effect: GLKBaseEffect?){
        if RMX.usingDepreciated {
            RMXGLMakePerspective(self.fieldOfView, Float(width) / Float(height), self.near, self.far)
        } else {
            effect?.transform.projectionMatrix = GLKMatrix4MakePerspective(self.fieldOfView, Float(width) / Float(height), self.near, self.far)
        }
    }
    
   /*
    var position: RMXVector3 {
        return (self.pov?.body.position)!
    }
    */
    var position: GLKVector3 {
        return (self.pov?.body.position)!
    }
    
    var orientation: GLKQuaternion {
        return GLKQuaternionMakeWithMatrix4((self.pov?.body.orientation)!)
    }

}