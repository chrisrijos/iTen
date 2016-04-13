//
//  Event.swift
//  Agenda1
//
//  Created by Felipe Neves Brito on 4/5/16.
//  Copyright © 2016 Felipe Neves Brito. All rights reserved.
//

class Event{

    var id:Int
    var name:String = ""
    var summary:String = ""
    var timeStart:String = ""
    var timeStop:String = ""
    var date:String = ""
    
    //attendees
    var logo:String = ""
    var website:String = ""
    var type:String = ""
    
    init(id:Int){
        self.id = id
    }
    
    
}
