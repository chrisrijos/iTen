//
//  AboutData.swift
//  Conference App
//
//  Created by Julian L on 4/12/16.
//  Copyright © 2016 Chrystech Systems. All rights reserved.
//

import Foundation

class MapData {
    
    var conferenceLocations: [loc] = []
    
    init() {
        
        // Get the JSON File
        let urlString = "http://pensacolacandidatewatcher.com/sample.json"
        // let urlString = "http://djmobilesoftware.com/jsondata.json"
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
                            let dictionary =  try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as! NSDictionary
                            
                            // Parse About JSON Portion
                            let locations = self.parseLocations(dictionary)
                            
                            // Array of locations
                            for locs in locations {
                                self.conferenceLocations.append(locs)
                            }
                            
                        }
                        catch let error as NSError {
                            print(error)
                            
                        }
                        
                    }
                    else {
                        print("MapData.swift: Unable to Convert Data to Text - JL")
                    }
                }
            })
            task.resume()
            
        }
        
    }
    init(c: String) {
        
    }
    
    func parseLocations(dictionary:NSDictionary)->[loc] {
        // Array of locations
        var tempLoc: [loc] = []
        
        if let locations = dictionary.objectForKey("locations") as? NSArray {
            for locs in locations {
                let locationName = locs["name"] as? String
                let locationLat = locs["latitude"] as? String
                let locationLong = locs["longitude"] as? String
                let locationDate = locs["date"] as? String
                let locationDesc = locs["description"] as? String
                
                tempLoc.append(loc(n:locationName!, lat: locationLat!, long: locationLong!, date: locationDate!, desc: locationDesc!))
            }
        }
        return tempLoc
        
    }
    
    
}