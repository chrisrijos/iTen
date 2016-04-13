//
//  AttendeeData.swift
//  Conference App
//
//  Created by tuong on 4/13/16.
//  Copyright © 2016 Chrystech Systems. All rights reserved.
//

import Foundation


class AttendeeData{
    
    var attendee:Attendee = Attendee()
    
    init(){
        
        let requestURL: NSURL = NSURL(string: "http://djmobilesoftware.com/jsondata.json")!
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(URL: requestURL)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(urlRequest) {
            (data, response, error) -> Void in
            
            let httpResponse = response as! NSHTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            if (statusCode == 200) {
                
                do{
                    
                    let json = try NSJSONSerialization.JSONObjectWithData(data!, options:.AllowFragments)
                    
                    if let events = json["sponsors"] as? [[String: AnyObject]] {
                        
                        
                        for eventData in events {
                            
                            let event = self.parseEvent(eventData)
                            self.attendee.addEvent(event)
                        }
                    }
                    
                } catch {
                    print("Error with Json: \(error)")
                }
            }
        }
        
        
        task.resume()
    }
    
    private func parseEvent(data:[String: AnyObject]) -> Event{
        
        let id = data["id"] as? String
        let name = data["name"] as? String
        let website = data["website"] as? String
        let logo = data["logo"] as? String
        
        let event:Event = Event(id: Int(id!)!)
        
        event.name = name!
        event.website = website!
        event.logo = logo!
        
        return event
    }
    
    func getAttendee() -> Attendee {
        return self.attendee
    }
}