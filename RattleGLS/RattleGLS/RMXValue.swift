//
//  RMXCoreExtensions.swift
//  OC to Swift oGL
//
//  Created by Max Bilbow on 17/02/2015.
//  Copyright (c) 2015 Rattle Media Ltd. All rights reserved.
//

import Foundation
//import SceneKit
import UIKit

class RMXValue<T: Comparable> {
   // var n: NSValue = 0
    class func isNegative(n:Int) -> Bool {
        return n < 0
    }
    
    class func isNegative(n:Float) -> Bool {
        return n < 0
    }
    
    class func isNegative(n:Double) -> Bool {
        return n < 0
    }
    
    class func isNegative(n:T) -> Bool {
        return false
    }
    
    class func toData(sender:T, dp:String) -> String {
        
        
//        func isNegative(n:Double) -> Bool {
//            return n < 0.0
//        }
        //switch sender
        var s: String = ""
        if sender is Int {
            //s = isNegative(sender as Int) ? "" : " "
            s += NSString(format: "\(s)%\(dp)i",sender as! Int) as! String
        } else if (sender is Float) {
            //s = isNegative(sender as Float) ? "" : " "
            s += NSString(format: "\(s)%\(dp)f",sender as! Float)as! String
        } else if (sender is CGFloat) {
            //s = isNegative(sender as Float) ? "" : " "
            s += NSString(format: "\(s)%\(dp)f",sender as! CGFloat)as! String
        }else if sender is Double {
            //s = isNegative(sender as Double) ? "" : " "
            s += NSString(format: "\(s)%\(dp)f",sender as! Double)as! String
        } else {
            s = "ERROR: number is not Int, Foat of Double. "
        }
        return s
    }

}

extension Int {
    func toData(dp:String="05") -> String {
        return RMXValue.toData(self, dp: dp)///NSString(format: "%.\(dp)f", self)
    }
}

extension Float {
    func toData(dp:String="05.2") -> String {
        return RMXValue.toData(self, dp: dp)///NSString(format: "%.\(dp)f", self)
    }
}

extension CGFloat {
    func toData(dp:String="05.2") -> String {
        return RMXValue.toData(self, dp: dp)///NSString(format: "%.\(dp)f", self)
    }
}



extension Double {
    func toData(dp:String="05.2") -> String {
        return RMXValue.toData(self, dp: dp)
    }
    
//    var cgFloat: CGFloat {
//        let f: CGFloat(self)
//        return f
//    }
}