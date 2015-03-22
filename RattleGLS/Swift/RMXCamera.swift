//
//  RMXCamera.swift
//  RattleGL
//
//  Created by Max Bilbow on 13/03/2015.
//  Copyright (c) 2015 Rattle Media. All rights reserved.
//

import Foundation

@objc public class RMXCamera {
    
    var scene: RMXGLView?
    var pov: RMSParticle?
    var near, far, fieldOfView: Float
    var facingVector: GLKVector3 = RMXVector3Zero()
    var scnCameraNode: SCNNode! = nil
    var effect: GLKBaseEffect! = nil
    var gameView: GameView! = nil
    var aspectRatio: Float  {
        return Float(self.viewWidth) / Float(self.viewHeight)
    }
    var viewWidth: Float
    var viewHeight: Float

    var projectionMatrix: GLKMatrix4 {
        return GLKMatrix4MakePerspective(self.fieldOfView, self.aspectRatio, self.near, self.far)
    }
    
    var modelViewMatrix: GLKMatrix4 {
        return GLKMatrix4MakeLookAt(
            self.eye.x, self.eye.y, self.eye.z,
            self.center.x,  self.center.y, self.center.z,
            self.up.x,      self.up.y,     self.up.z)
    }
    init(world: RMXGLView?, pov: RMSParticle! = nil,viewSize: (Float,Float) = (1280, 750), farPane far: Float = 2000 ){
        self.scene = world ?? pov as! RMXWorld
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
    
    private func makeLookAtGl(lookAt: CFunctionPointer<(Double, Double, Double, Double, Double, Double, Double, Double, Double) -> Void>) -> Void {
     //   RMSMakeLookAtGL(self)
        RMXMakeLookAtGL(lookAt,
            Double(self.eye.x),     Double(self.eye.y),    Double(self.eye.z),
            Double(self.center.x),  Double(self.center.y), Double(self.center.z),
            Double(self.up.x),      Double(self.up.y),     Double(self.up.z)
        )
    
        
    }
    
    /*
    func updateSCNView(gameView: GameView! = nil){
        if gameView != nil && self.gameView == nil {
            self.gameView = gameView
        }
        if self.gameView == nil {
            fatalError("Camera not initialised in \(self.pov?.name)")
        }
        //self.scnCameraNode!.position = SCNVector3FromGLKVector3(self.position)
        //let cam = self.viewController.cameraNode
        //cam.position = SCNVector3FromGLKVector3((self.pov?.body.position)!)
        let view = self.gameView.pointOfView!
        
        //view!.setProjectionTransform(SCNMatrix4FromGLKMatrix4(self.modelViewMatrix))
        view.position = SCNVector3FromGLKVector3((self.pov?.body.position)!)
        //view.orientation = self.pov?.body.orientation
        //RMXLog("gameView(view): \(view)")
        
        //self.viewController.cameraNode.position = SCNVector3FromGLKVector3((self.pov?.body.position)!)
        //RMXLog("SCN Camera is received and set")
        
    } */
    
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
    var position: SCNVector3 {
        return SCNVector3FromGLKVector3((self.pov?.body.position)!)
    }
    
    var orientation: GLKQuaternion {
        return GLKQuaternionMakeWithMatrix4( SCNMatrix4ToGLKMatrix4((self.pov?.body.orientation)!))
    }

}