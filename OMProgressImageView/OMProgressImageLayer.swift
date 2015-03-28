//
//  OMProgressImageLayer.swift
//
//  Created by Jorge Ouahbi on 26/3/15.
//  Copyright (c) 2015 Jorge Ouahbi. All rights reserved.
//

#if os(iOS)
    import UIKit
#elseif os(OSX)
    import AppKit
#endif


public enum OMProgressType : Int
{
    case OMHorizontal
    case OMVertical
    case OMCircular
}

private struct OMProgressImageLayerProperties {
    static var Progress = "progress"
}

class OMProgressImageLayer: OMLayer
{
    var image:UIImage?       = nil
    {
        didSet {
            setNeedsDisplay()
        }
    }
    var progress: Double     = 0.0
    {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var beginRadians: Double = -M_PI_2
    
    var type:OMProgressType  = OMProgressType.OMVertical
    {
        didSet {
            setNeedsDisplay()
        }
    }

    var grayScale:Bool = false
    {
        didSet {
            setNeedsDisplay()
        }
    }

    
    func animateProgress(fromValue:Double,toValue:Double,beginTime:NSTimeInterval,duration:NSTimeInterval, delegate:AnyObject?)
    {
        self.animateKeyPath(OMProgressImageLayerProperties.Progress,
            fromValue:fromValue,
            toValue:toValue,
            beginTime:beginTime,
            duration:duration,
            delegate:delegate)
    }
    
    
    override init(){
        super.init()
    }
    
    convenience init(image:UIImage){
        self.init()
        self.image = image
    }
    
    override init!(layer: AnyObject!) {
        super.init(layer: layer)
        if let other = layer as? OMProgressImageLayer {
            self.progress       = other.progress
            self.image          = other.image
            self.type           = other.type
            self.beginRadians   = other.beginRadians
            self.grayScale      = other.grayScale
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
    }
    
    override class func needsDisplayForKey(event: String!) -> Bool
    {
        if(event == OMProgressImageLayerProperties.Progress){
            return true
        }
        return super.needsDisplayForKey(event)
    }
    
    override func actionForKey(event: String!) -> CAAction!
    {
        if(event == OMProgressImageLayerProperties.Progress){
            let animation = CABasicAnimation(keyPath: event)
            animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
            animation.fromValue = self.presentationLayer().valueForKey(event);
            
            return animation
        }
        return super.actionForKey(event)
    }
    
    override func display() {
        
        super.display()
        
        var newImage:UIImage? = nil
        var newProgress:Double = self.progress
        
        if let presentationLayer: AnyObject = self.presentationLayer(){
            newProgress = presentationLayer.progress
        }
        
        
        if(newProgress > 0)
        {
            switch(self.type)
            {
            case .OMCircular:
                
                let radius = max(self.image!.size.width,self.image!.size.height)//* CGFloat(newProgress)
            
                let center = CGPoint(x:self.image!.size.width * 0.5,y:self.image!.size.height * 0.5)
            
                let startAngle = beginRadians
            
                let endAngle  =  Double(M_PI * 2.0 * newProgress + beginRadians)
            
                let path = UIBezierPath(arcCenter: center,
                    radius: radius ,
                    startAngle: CGFloat(startAngle),
                    endAngle: CGFloat(endAngle),
                    clockwise: true)
        
                path.addLineToPoint(center)
                path.closePath()
            
                newImage = self.image!.maskImage(path)

                break;
                
            case .OMVertical:
                
                let newHeight = Double(self.bounds.size.height) * newProgress
                
                let path = UIBezierPath(rect: CGRect(x:0,y:0,width: self.bounds.size.width, height:CGFloat(newHeight)))
                
                newImage = self.image!.maskImage(path)
                break;
                
            case .OMHorizontal:
                
                let newWidth = Double(self.bounds.size.width) * newProgress
          
                let path = UIBezierPath(rect: CGRect(x:0,y:0,width: CGFloat(newWidth),height:self.bounds.size.height))
                
                newImage = self.image!.maskImage(path)
                break;
            }
        }
        
        
        if(newImage != nil) {
            if ( grayScale ){
                self.contents =  self.image?.grayScaleImage().mergeWithImage(newImage!).CGImage
            }else{
                self.contents =  newImage!.CGImage
            }
        }
        
        // DEBUG
        // println("progress: \(newProgress)")
    }
}