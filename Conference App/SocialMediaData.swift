//
//  SocialMediaData.swift
//  Conference App
//
//  Created by Christopher Rijos on 4/21/16.
//  Copyright © 2016 Chrystech Systems. All rights reserved.
//

import Foundation

class SocialMediaData {
    
    // This is the value that will be displayed on the AboutViewController page
    var content = ""
    var logo = ""
    var dictionary: NSDictionary = [:]
    
    init() {
        // Get the JSON File
        let urlString = "http://djmobilesoftware.com/jsondata.json"
        let url = NSURL(string: urlString)
        
        // Start a NSURLSession to Download JSON
        if let url = url {
            let session = NSURLSession.sharedSession()
            let task = session.dataTaskWithURL(url, completionHandler: { (data, response, error) -> Void in
                if let error =  error {
                    print("error: \(error.localizedDescription): \(error.userInfo)")
                }
                else if let data = data {
                    if let str = NSString(data: data, encoding: NSUTF8StringEncoding) {
                        //print("Received data:\n\(str)")
                        
                        do {
                            // Convert the JSON to Dictionary
                            self.dictionary =  try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as! NSDictionary
                            
                            // Parse About JSON Portion
                            let about = self.parseFacebook()
                            let logo = self.parseLogo(self.dictionary)
                            // This is the final value with the text needed
                            self.content = about
                            self.logo = logo
                        }
                        catch let error as NSError {
                            print(error)
                            
                            // This is used incase Internet Connection is not available
                            self.content = "http://www.facebook.com/itenwired"
                        }
                        
                    }
                    else {
                        print("AboutData.swift: Unable to Convert Data to Text - JL")
                    }
                }
            })
            task.resume()
            
        }
        
    }
    init(c: String) {
        self.content = c
    }
    
    // Receives a NSDictionary that contains the JSON and converts 'conference_description' to String
    
    func parseFacebook()->String {
        var fURL: String = ""
        if let facebookURL = dictionary.objectForKey("facebook") {
            fURL = facebookURL as! String
        }
        return fURL
    }
    func parseLogo(dictionary:NSDictionary)->String {
        var logo: String = ""
        if let logoInfo = dictionary.objectForKey("header_image_path") {
            logo = logoInfo as! String
        }
        return logo
    }
    
    // Used this for testing, shows the content variable
    func showContent()->String {
        return self.content
    }
    
    
}