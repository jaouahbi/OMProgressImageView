//
//  OMLayer.swift
//  ExampleSwift
//
//  Created by Jorge Ouahbi on 26/3/15.
//  Copyright (c) 2015 Jorge Ouahbi. All rights reserved.
//
//  Description:
//  Simple derived CALayer class used as base class
//

import UIKit



class OMLayer: CALayer {
   
    override init()
    {
        super.init()
        self.contentsScale = UIScreen.mainScreen().scale
        self.needsDisplayOnBoundsChange = true;
    }
    
    
    override init!(layer: AnyObject!) {
        super.init(layer: layer)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
    }
    
    func animateKeyPath(keyPath : String, fromValue : Double,toValue:Double,beginTime:NSTimeInterval,duration:NSTimeInterval, delegate:AnyObject?)
    {
        let animation = CABasicAnimation(keyPath:keyPath);
        var currentValue: AnyObject? = self.presentationLayer()?.valueForKey(keyPath)
        
        if (currentValue == nil) {
            currentValue = fromValue
        }
        
        animation.fromValue = currentValue
        animation.toValue = toValue
        animation.delegate = delegate
        
        if(duration > 0){
            animation.duration = duration
        }
        if(beginTime > 0){
            animation.beginTime = beginTime
        }
        
        animation.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionLinear)
        animation.setValue(self,forKey:keyPath)
        self.addAnimation(animation, forKey:keyPath)
        self.setValue(toValue,forKey:keyPath)
    }
    
    //DEBUG
    override func display() {
        super.display()
        if(self.bounds.isEmpty) {
            println("WARNING: empty layer.")
        }
    }
}
