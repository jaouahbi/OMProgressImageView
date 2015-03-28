//
//  ViewController.swift
//  OMProgressImageView
//
//  Created by Jorge on 27/3/15.
//  Copyright (c) 2015 Jorge Ouahbi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var myView:OMProgressImageView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let image:UIImage = UIImage(named: "1")!
        
        myView?.type = OMProgressType.OMCircular
        myView?.image = image;
        
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(NSEC_PER_SEC))
        
        dispatch_after(time, dispatch_get_main_queue()) {
            self.myView?.setProgress(1.0, animate: true)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

