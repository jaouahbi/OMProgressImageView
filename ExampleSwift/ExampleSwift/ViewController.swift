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
//  ViewController.swift
//  OMProgressImageView
//
//  Created by Jorge Ouahbi on 27/3/15.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var progressH:OMProgressImageView?
    @IBOutlet weak var progressV:OMProgressImageView?
    @IBOutlet weak var progressR:OMProgressImageView?
    @IBOutlet weak var progressC:OMProgressImageView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let image:UIImage = UIImage(named: "1")!
        
        progressH?.type            = .Horizontal
        progressH?.image           = image;
        progressH?.backgroundColor = UIColor.blackColor()
        progressH?.grayScale       = false
        progressH?.showing         = true
        
        progressV?.type            = .Vertical
        progressV?.image           = image;
        progressV?.backgroundColor = UIColor.clearColor()
        progressV?.grayScale       = false
        progressV?.showing         = false
        
        progressR?.type            = .Radial
        progressR?.image           = image;
        progressR?.backgroundColor = UIColor.blueColor()
        progressR?.grayScale       = false
        progressR?.showing         = false
        
        progressC?.type            = .Circular
        progressC?.image           = image;
        progressC?.backgroundColor = UIColor.grayColor()
        progressC?.grayScale       = false
        progressC?.showing         = true
        
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(NSEC_PER_SEC))
        
        dispatch_after(time, dispatch_get_main_queue()) {
     
            self.progressH?.setProgress(1.0, animate: true)
            self.progressV?.setProgress(1.0, animate: true)
            self.progressR?.setProgress(1.0, animate: true)
            self.progressC?.setProgress(1.0, animate: true)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

