//
//  OMProgressImageView.swift
//  OMProgressImageView
//
//  Created by Jorge Ouahbi on 27/3/15.
//  Copyright (c) 2015 Jorge Ouahbi. All rights reserved.
//

import UIKit

class OMProgressImageView: UIView
{
    override class func layerClass() -> AnyClass{
        return OMProgressImageLayer.self
    }
    
    var type:OMProgressType  = OMProgressType.OMVertical
    {
        didSet {
            (self.layer as! OMProgressImageLayer).type = type
        }
    }
    
    var duration:CFTimeInterval = 10.0
    
    func setProgress(progress:Double, animate:Bool)
    {
        let theLayer = self.layer as! OMProgressImageLayer
        
        if(animate) {
            
            theLayer.animateProgress(0, toValue: progress, beginTime: 0, duration: duration, delegate: nil)
        }
        else {
            theLayer.progress = progress
        }
    }
    
    var image:UIImage?
    {
        didSet {
        
            self.layoutIfNeeded()
    
            let newImage = image?.resizedImage(self.bounds.size,interpolationQuality: kCGInterpolationDefault)
            
            println("new image : \(newImage)")
            
            (self.layer as! OMProgressImageLayer).image = newImage
        }
    }
}
