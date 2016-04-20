//
//  SociaMedia.swift
//  Conference App
//
//  Created by user115597 on 4/16/16.
//  Copyright © 2016 Chrystech Systems. All rights reserved.
//

import UIKit
import Social

class SocialMediaViewController: UIViewController {
    
    @IBOutlet weak var facebook: UIButton!
    @IBOutlet weak var twitter: UIButton!
    @IBOutlet weak var google: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 0.15, green: 0.353, blue: 0.6, alpha: 50)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func postToTwitter(sender: AnyObject) {
        post(toService: SLServiceTypeTwitter)
    }
    
    @IBAction func postToFacebook(sender: AnyObject) {
        post(toService: SLServiceTypeFacebook)
    }
    
    func post(toService service: String) {
        let socialController = SLComposeViewController(forServiceType: service)
                   socialController.setInitialText("tell your friends about us www.itenwired.com")
        self.presentViewController(socialController, animated: true, completion: nil)
    }

}
