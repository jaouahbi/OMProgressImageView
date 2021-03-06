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
//  CGSize.swift
//
//  Created by Jorge Ouahbi on 4/2/15.
//
//  0.1 Added center func (29-03-2015)
//


import QuartzCore

extension CGSize
{
    func min() -> CGFloat
                                                              {
        return Swift.min(height,width);
    }
    
    func max() -> CGFloat
    {
        return Swift.max(height,width);
    }
    
    func max(other : CGSize) -> CGSize
    {
        return self.max() >= other.max()  ? self : other;
    }
    
    func hypot() -> CGFloat
    {
        return CoreGraphics.hypot(height,width)
    }
    
    func center() -> CGPoint
    {
        return CGPoint(x:width * 0.5,y:height * 0.5)
    }
    
}