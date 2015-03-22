//
//  GameViewController.swift
//  RMS SceneKit
//
//  Created by Max Bilbow on 21/03/2015.
//  Copyright (c) 2015 Rattle Media. All rights reserved.
//

import SceneKit
import QuartzCore

class GameViewController: NSViewController, SCNSceneRendererDelegate {
    
    @IBOutlet weak var gameView: GameView!
    
    var cameraNode: SCNNode! = nil
    
    func renderer(aRenderer: SCNSceneRenderer, updateAtTime time: NSTimeInterval) {
        if self.gameView != nil && self.gameView.camera?.pov != nil {
            self.gameView.update()///.camera?.updateSCNView(gameView: self.gameView)
            //RMXLog(self.gameView.camera!.viewDescription)
            //        cameraNode.position.x = self.observer()!.position[0]
            //        cameraNode.position.y = self.observer()!.position[1]
            //        cameraNode.position.z = self.observer()!.position[2]
            //cameraNode.position = (self.view as SCNView).pointOfView!.position
            //cameraNode.position.z += 15
            //RMXLog("--- Camera Orientation")
            //RMXLog("w\(self.cameraNode.orientation.w.toData()), x\(self.cameraNode.orientation.w.toData()), y\(self.cameraNode.orientation.w.toData()), z\(self.cameraNode.orientation.w.toData())")
            //(self.gameView.scene as! RMXScene).update()
        }
        else {
            RMXLog("--- Warning: observer may not be initialised")
        }
    }
    
    override func awakeFromNib(){
        // create a new scene
        let scene = RMXScene(named: "art.scnassets/ship.dae")!
        
        // create and add a camera to the scene
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        scene.rootNode.addChildNode(cameraNode)
        self.cameraNode = cameraNode
        // place the camera
        //cameraNode.position = SCNVector3FromGLKVector3((scene.camera?.position)!)
    
       
        // create and add a light to the scene
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light!.type = SCNLightTypeOmni
        lightNode.position = SCNVector3(x: 0, y: 10, z: 10)
        scene.rootNode.addChildNode(lightNode)
        
        // create and add an ambient light to the scene
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light!.type = SCNLightTypeAmbient
        ambientLightNode.light!.color = NSColor.darkGrayColor()
        scene.rootNode.addChildNode(ambientLightNode)
        
//         retrieve the ship node
        let ship = scene.rootNode.childNodeWithName("ship", recursively: true)!
        // animate the 3d object
        ship.runAction(SCNAction.repeatActionForever(SCNAction.rotateByX(0, y: 2, z: 0, duration: 1000)))
        
                // set the scene to the view
        self.gameView!.scene = scene
        scene.buildScene()
        // allows the user to manipulate the camera
        self.gameView!.allowsCameraControl = false
        
        // show statistics such as fps and timing information
        self.gameView!.showsStatistics = true
        
        // configure the view
        self.gameView!.backgroundColor = NSColor.blackColor()
        self.gameView!.delegate = self
//        scene.activeCamera?.updateSCNView(gameView: self.gameView)
    }

    
    
}
