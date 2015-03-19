//
//  AppDelegate.swift
//  Rattle Physics Beta
//
//  Created by Max Bilbow on 18/03/2015.
//  Copyright (c) 2015 Rattle Media. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {



    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
        func start() {
            autoreleasepool {
                let scene = RMXArt.initializeTestingEnvironment()
                for sprite in scene.sprites {
                    if sprite.rmxID != scene.observer?.rmxID {
                        
                        if sprite.isAnimated {
                            sprite.addBehaviour({
                                let dist = sprite.body.distanceTo(scene.observer!)
                                let distTest = sprite.body.radius + (scene.observer?.body.radius)! + (scene.observer?.actions?.reach)!
                                if dist <= distTest {
                                    sprite.body.velocity = RMXVector3Add(sprite.body.velocity, (scene.observer?.body.velocity)!)
                                } else if dist < distTest * 10 {
                                    sprite.actions?.prepareToJump()
                                }
                            })
                            
                            sprite.addBehaviour({
                                if !sprite.hasGravity && scene.observer?.actions!.item != nil {
                                    if sprite.body.distanceTo((scene.observer?.actions?.item)!) < 50 {
                                        sprite.hasGravity = true
                                    }
                                }
                            })
                            
                            
                        }
                    }
                }
                RMXGLProxy.initialize(scene,callbacks: RepeatedKeys)
                RMXRun(Process.argc, Process.unsafeArgv)
            }
        }
        start()
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }


}

