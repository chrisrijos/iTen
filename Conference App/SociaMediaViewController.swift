//
//  SociaMedia.swift
//  Conference App
//
//  Created by user115597 on 4/16/16.
//  Copyright © 2016 Chrystech Systems. All rights reserved.
//

import UIKit
import Social

class SociaMediaViewController: UIViewController {
    
    
    @IBOutlet weak var backButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func postToFacebookTapped(sender: UIButton) {
        post(toService: SLServiceTypeFacebook)
    }
    
    @IBAction func postToTwitterTapped(sender: UIButton) {
        post(toService: SLServiceTypeTwitter)
    }
    func post(toService service: String) {
        let socialController = SLComposeViewController(forServiceType: service)
        //            socialController.setInitialText("Hello World!")
        //            socialController.addImage(someUIImageInstance)
        //            socialController.addURL(someNSURLInstance)
        self.presentViewController(socialController, animated: true, completion: nil)
    }

}
