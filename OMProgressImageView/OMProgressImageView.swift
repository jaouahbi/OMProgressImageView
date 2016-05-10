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

class OMProgressImageView : UIView
{
    override class func layerClass() -> AnyClass{
        return OMProgressImageLayer.self
    }
    
    var type:OMProgressType  = .Vertical {
        didSet {
            let theLayer  = self.layer as! OMProgressImageLayer
            theLayer.type = type
        }
    }
    
    var progress:Double = 0
    {
        didSet {
            let theLayer = self.layer as! OMProgressImageLayer
            
            // clamp(0,1)
            
            theLayer.progress = min(abs(progress),1.0)
        }
    }
    
    var grayScale:Bool = true {
        didSet {
            let theLayer = self.layer as! OMProgressImageLayer
            theLayer.grayScale = grayScale
        }
    }
    
    var clockwise:Bool = true {
        didSet {
            let theLayer = self.layer as! OMProgressImageLayer
            theLayer.clockwise = clockwise
        }
    }
    
    var showing:Bool = true {
        didSet {
            let theLayer = self.layer as! OMProgressImageLayer
            theLayer.showing = showing
        }
    }
    
    var duration:CFTimeInterval = 5.0
    
    func setProgress(progress:Double, animate:Bool)
    {
        let theLayer = self.layer as! OMProgressImageLayer
        let clamped = min(abs(progress),1.0)
        if ( animate ) {
            theLayer.animateProgress(0, toValue: clamped, beginTime: 0, duration: duration, delegate: nil)
        } else {
            theLayer.progress = clamped
        }
    }
    
    var image:UIImage?
    {
        didSet {
        
            let theLayer = self.layer as! OMProgressImageLayer
            self.layoutIfNeeded()
            let newImage = image?.resizedImage(self.bounds.size,interpolationQuality: CGInterpolationQuality.Default)
            
            //print("new image : \(newImage)")
            
            theLayer.image = newImage
        }
    }
}
