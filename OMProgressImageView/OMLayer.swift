//
//    Copyright 2015 - Jorge Ouahbi
//
//   Licensed under the Apache License, Version 2.0 (the "License");
//   you may not use this file except in compliance with the License.
//   You may obtain a copy of the License at
//
//       http://www.apache.org/licenses/LICENSE-2.0
//
//   Unless required by applicable law or agreed to in writing, software
//   distributed under the License is distributed on an "AS IS" BASIS,
//   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//   See the License for the specific language governing permissions and
//   limitations under the License.
//


//
//  OMLayer.swift
//
//  Created by Jorge Ouahbi on 26/3/15.
//
//  Description:
//  Simple derived CALayer class used as base class
//
//  Versión 0.1 (29-3-2015)
//
//  Added context flip
//

import UIKit


class OMLayer: CALayer {
    
    /// Radians
    
    var angleOrientation:Double = 0.0
    {
        didSet {
            
            if(angleOrientation != 0.0) {
                
                var affineTransform = CGAffineTransformMakeRotation(CGFloat(angleOrientation))
                
                //                if(UIDevice.currentDevice().orientation == UIDeviceOrientation.LandscapeLeft)
                //                {
                //                     affineTransform = CGAffineTransformRotate(affineTransform,CGFloat(M_PI_2));
                //
                //                }else if(UIDevice.currentDevice().orientation == UIDeviceOrientation.LandscapeRight){
                //
                //                    affineTransform = CGAffineTransformRotate(affineTransform, CGFloat(-M_PI_2));
                //                }
                
                setAffineTransform(affineTransform)
                
                setNeedsDisplay()
            }
        }
    }
    
    override init()
    {
        super.init()
        self.contentsScale = UIScreen.mainScreen().scale
        self.needsDisplayOnBoundsChange = true;
        
        // DEBUG
        //self.borderColor = UIColor.yellowColor().CGColor!
        //self.borderWidth = 1
        
        
        // Disable animating view refreshes
        //self.actions = ["contents" as NSString : NSNull()]
    }
    
    
    override init!(layer: AnyObject!) {
        super.init(layer: layer)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
    }
    
    
    func flipContextIfNeed(context:CGContext!)
    {
        // Core Text Coordinate System and Core Graphics are OSX style
        
        #if os(iOS)
            CGContextTranslateCTM(context, 0, self.bounds.size.height);
            CGContextScaleCTM(context, 1.0, -1.0);
        #endif
    }
    
    
    func animateKeyPath(keyPath : String, fromValue : Double, toValue:Double, beginTime:NSTimeInterval, duration:NSTimeInterval, delegate:AnyObject?)
    {
        let animation = CABasicAnimation(keyPath:keyPath);
        
        var currentValue: AnyObject? = self.presentationLayer()?.valueForKey(keyPath)
        
        if (currentValue == nil) {
            currentValue = fromValue
        }
        
        animation.fromValue = currentValue
        animation.toValue = toValue
        animation.delegate = delegate
        
        if(duration > 0.0){
            animation.duration = duration
        }
        if(beginTime > 0.0){
            animation.beginTime = beginTime
        }
        
        animation.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionLinear)
        animation.setValue(self,forKey:keyPath)
        self.addAnimation(animation, forKey:keyPath)
        
        ///
        
        self.setValue(toValue,forKey:keyPath)
    }
    
    override func drawInContext(ctx: CGContext!) {
        super.drawInContext(ctx)
    }
    //DEBUG
    override func display() {
        super.display()
        if(self.bounds.isEmpty) {
            println("WARNING: empty layer.")
        }
    }
}
