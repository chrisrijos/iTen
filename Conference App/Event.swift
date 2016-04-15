//
//  Event.swift
//  Agenda1
//
//  Created by Felipe Neves Brito on 4/5/16.
//  Copyright © 2016 Felipe Neves Brito. All rights reserved.
//

import Foundation

class Event{

    var id:Int = 0
    var name:String = ""
    var summary:String = ""
    var timeStart:String = ""
    var timeStop:String = ""
    var date:String = ""
    
    //attendees
    var logo:String = ""
    var level: String = ""
    var description: String = ""
    var jobTitle : String = ""
    var company: String = ""
    var linkedin : String = ""
    var email : String = ""
    var website:String = ""
    var type:String = ""
    
    init(id:Int){
        self.id = id
    }
    
    init(dictionary: NSDictionary){
        if let id = dictionary.objectForKey(EventEnum.id.rawValue) as? Int{
            self.id = id
        }
        
        if let name = dictionary.objectForKey(EventEnum.name.rawValue) as? String{
            self.name = name
        }
        
        if let summary = dictionary.objectForKey(EventEnum.summary.rawValue) as? String{
            self.summary = summary
        }
        
        if let timeStart = dictionary.objectForKey(EventEnum.timeStart.rawValue) as? String{
            self.timeStart = timeStart
        }
        
        if let timeStop = dictionary.objectForKey(EventEnum.timeStop.rawValue) as? String{
            self.timeStop = timeStop
        }
        
        if let date = dictionary.objectForKey(EventEnum.date.rawValue) as? String{
            self.date = date
        }
    }
}


enum EventEnum : String{
    case id
    case name
    case summary
    case timeStart
    case timeStop
    case date
}
