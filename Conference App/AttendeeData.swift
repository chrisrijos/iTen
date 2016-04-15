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
                            
                            let event = self.SponsorsparseEvent(eventData)
                            self.attendee.addEvent(event)
                        }
                        
                        
                    }
                    if let events = json["exhibitors"] as? [[String: AnyObject]] {
                        
                        
                        for eventData in events {
                            
                            let event = self.ExhibitorsparseEvent(eventData)
                            self.attendee.addEvent(event)
                        }
                        
                        
                    }
                    if let events = json["speakers"] as? [[String: AnyObject]] {
                        
                        
                        for eventData in events {
                            
                            let event = self.SpeakersparseEvent(eventData)
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
    
    private func SponsorsparseEvent(data:[String: AnyObject]) -> Event{
        
        let id = data["id"] as? String
        let name = data["name"] as? String
        let website = data["website"] as? String
        let logo = data["logo"] as? String
        let description = data["description"] as? String
        let jobTitle = data["level"] as? String
        let event:Event = Event(id: Int(id!)!)
        
        event.name = name!
        event.website = website!
        event.logo = logo!
        event.jobTitle = jobTitle!
        event.description = description!
        
        return event
    }
    private func SpeakersparseEvent(data:[String: AnyObject]) -> Event{
        
        let id = data["id"] as? String
        let name = data["name"] as? String
        let website = data["website"] as? String
        let jobTitle = data["jobtitle"] as? String
        let description = data["bio"] as? String
        let linkedin = data["linkedin"] as? String
        let email = data ["email"] as? String
        
        
        let event:Event = Event(id: Int(id!)!)
        
        if (name != nil) {
            event.name = name!
        }
        
        if (website != nil)  {
            event.website = website!
        }
        if (jobTitle != nil)  {
            event.jobTitle = jobTitle!
        }
        if (description != nil) {
            event.description = description!
        }
        if (linkedin != nil)  {
            event.linkedin = linkedin!
        }
        if (email != nil)  {
             event.email = email!
        }
       
        
        
        return event
    }
    private func ExhibitorsparseEvent(data:[String: AnyObject]) -> Event{
        
        let id = data["id"] as? String
        let name = data["name"] as? String
        let website = data["website"] as? String
        let logo = data["logo"] as? String
        let description = data["description"] as? String
        
        let event:Event = Event(id: Int(id!)!)
        
        event.name = name!
        event.website = website!
        event.logo = logo!
        event.description = description!
        
        return event
    }
    
    func getAttendee() -> Attendee {
        return self.attendee
    }
}