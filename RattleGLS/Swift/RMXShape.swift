//
//  RMXShape.swift
//  RattleGL
//
//  Created by Max Bilbow on 13/03/2015.
//  Copyright (c) 2015 Rattle Media. All rights reserved.
//

import Foundation

//@objc public protocol RMXRenderable {
//    var render: CFunctionPointer<(Float)->Void> { get set }
//}

public class RMXShape {
    
    var node: SCNNode?
    var color: GLKVector4 = GLKVector4Make(0,0,0,0)
    var isLight: Bool = false
    var type, gl_light: Int32
    public var render: ((Float) -> Void)?//UnsafeMutablePointer<(Float) -> Void> = UnsafeMutablePointer<(Float) -> Void>()//.alloc(sizeof(<(Float) -> Void>))
    var parent: RMSParticle!
    var world: RMXWorld?
    var visible: Bool = true;
    //var shine: CFunctionPointer<(Int32, Int32, [Float])->Void>
    var brigtness: Float = 1
    
    init(parent: RMSParticle?, world: RMXWorld?)    {
        self.parent = parent!
        self.world = world
        self.type = GL_POSITION
        self.gl_light = GL_LIGHT0
    }
    
   
//    class func Shape(parent: RMSParticle!, world: RMXWorld!, render: CFunctionPointer<(Float)->Void> = nil) -> RMXShape {
//        let s = RMXShape(parent: parent, world: world)
//        s.render = render
//        return s
//    }
    
    func makeAsSun(rDist: Float = 1000, isRotating: Bool = true){
        self.parent.rotationCenterDistance = rDist
        self.parent.isRotating = isRotating
        self.parent.rotationSpeed = 1
        self.parent.hasGravity = false //TODO check
        self.isLight = true
        
    }
    
    func draw() {
        if !self.visible { return }
        if self.node != nil {
            self.node!.position = SCNVector3FromGLKVector3(self.parent.body.position)
//            let q = self.parent.camera!.orientation
//            self.node!.orientation = SCNVector4Make(CGFloat(q.x), CGFloat(q.y), CGFloat(q.z), CGFloat(q.w))
            let r: CGFloat = CGFloat(self.parent.body.radius)
            self.node!.scale = SCNVector3(x: r,y: r,z: r)
            
        } else if RMX.usingDepreciated {
            if self.isLight {
                RMXGLShine(self.gl_light, self.type, GLKVector4MakeWithVector3(self.parent.body.position, 1))
            }
            if self.render != nil {
                glPushMatrix();
                RMXGLTranslate(parent.anchor)
                RMXGLTranslate(parent.body.position)
                self.setMaterial()
    //            RMXGLRender(self.render, Float(self.parent.body.radius))
                self.render!(Float(self.parent.body.radius))
                self.unsetMaterial()
                glPopMatrix();
            }
        }
    
    }
        
    private func setMaterial()
    {
        if self.isLight {
            RMXGLMaterialfv(GL_FRONT, GL_EMISSION, self.color)
        }
        
            RMXGLMaterialfv(GL_FRONT, GL_SPECULAR, self.color)
            RMXGLMaterialfv(GL_FRONT, GL_DIFFUSE, self.color)
        
    }
    
    private func unsetMaterial()    {
        let nill = GLKVector4Make( 0,0,0,0);
        RMXGLMaterialfv(GL_FRONT, GL_EMISSION, nill);
        RMXGLMaterialfv(GL_FRONT, GL_SPECULAR, nill);
        RMXGLMaterialfv(GL_FRONT, GL_DIFFUSE, nill);
    }
    
    func getColorfv() -> GLKVector4 {
        return self.color
    }
    
    func setRenderer(render: (Float)->()) {
        
//       self.render.put(render
        self.render = render
    }
    func setColorfv(c: [Float]) {
        self.color = GLKVector4Make(c[0],c[1],c[2],c[3])
        
    }
    
}