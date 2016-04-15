//
//  AboutViewController.swift
//  Conference App
//
//  Created by Julian L on 4/8/16.
//  Copyright © 2016 Chrystech Systems. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    
    var about: AboutData = AboutData()
    
    @IBOutlet var aboutTextView: UITextView!
    
    @IBOutlet var imageURL: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        var tempDictionary = AppDataRequesting()
//        var dictionaryResult = tempDictionary.getDataFromFile()
//        print(dictionaryResult)
//        if let newLocations  = dictionaryResult.objectForKey("locations") as? NSArray {
//            for locs in newLocations {
//                let locationName = locs["name"] as? String
//                let locationLat = locs["latitude"] as? String
//                let locationLong = locs["longitude"] as? String
//                let locationDate = locs["date"] as? String
//                let locationDesc = locs["description"] as? String
//                print(locationName)
//                
//                if let newName = locationName {
//                    print(newName)
//                }
//                print(locationLat)
//                print(locationLong)
//                print(locationDate)
//                print(locationDesc)
//                //tempLoc.append(loc(n:locationName!, lat: locationLat!, long: locationLong!, date: locationDate!, desc: locationDesc!))
//            }
//        }

        
        self.view.backgroundColor = UIColor(red: 0.15, green: 0.353, blue: 0.6, alpha: 100)
        aboutTextView.textColor = UIColor(red: 1, green: 0.63, blue: 0, alpha: 100)
        //aboutTextView.text = "Test"
        
        if let aboutText = about.content as? String {
            aboutTextView.text = aboutText
        }
        if let logoText = about.logo as? String {
            let url = NSURL(string:logoText)
            let data = NSData(contentsOfURL:url!)
            if (data != nil) {
                let tempImg = UIImage(data:data!)
                imageURL.image = UIImage(data:data!)
                imageURL.contentMode = .ScaleAspectFit
            }
        }
        
       aboutTextView.scrollRangeToVisible(NSMakeRange(0, 0))
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
