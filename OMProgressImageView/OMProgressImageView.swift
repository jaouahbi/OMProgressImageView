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
//  OMProgressImageView.swift
//
//  Created by Jorge Ouahbi on 27/3/15.
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
