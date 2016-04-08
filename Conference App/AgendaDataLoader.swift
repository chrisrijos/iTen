//
//  AgendaDataLoader.swift
//  Agenda1
//
//  Created by Felipe Neves Brito on 4/5/16.
//  Copyright © 2016 Felipe Neves Brito. All rights reserved.
//

import Foundation

class AgendaDataLoader{

    var agenda:Agenda = Agenda()
    
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
                    
                    if let events = json["events"] as? [[String: AnyObject]] {
                        
                        
                        for eventData in events {
                            
                            let event = self.parseEvent(eventData)
                            self.agenda.addEvent(event)
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
        let summary = data["summary"] as? String
        let timeStart = data["timeStart"] as? String
        let timeStop = data["timeStop"] as? String
        let date = data["date"] as? String

        let event:Event = Event(id: Int(id!)!)
        
        event.name = name!

        event.summary = summary!
        event.timeStart = timeStart!
        event.timeStop = timeStop!
        event.date = date!
        
        return event
    }

    func getAgenda() -> Agenda {
        return self.agenda
    }
}