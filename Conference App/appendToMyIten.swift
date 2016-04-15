//
//  appendToMyIten.swift
//  Conference App
//
//  Created by George Gruse on 4/15/16.
//  Copyright © 2016 Chrystech Systems. All rights reserved.
//

import Foundation
class appendToMyIten {
    var path: NSString
    var mainFile: String
    
    init()
    {
        //let dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true).first!
        mainFile = "data.dat"
        //path = dir.stringByAppendingPathComponent(mainFile);
        path = ""
        
        
    }
    
    
    
    
    //Credit to http://stackoverflow.com/questions/24097826/read-and-write-data-from-text-file by user Adam on the stack
    //overflow site
    
    func appendAgenda(event :Event)
    {
        /*
        var data:NSString = "|id|"+event.id+"|name|"+event.name+"|summary|"+event.summary+"|timeStart|"+event.timeStart+"|timeStop|"+event.timeStop+"|date|"+event.date+"|logo|"+event.logo+"|website|"+event.website+"|type|"+event.type+"\n"
        do{
            try data.writeToFile(path, atomically: false, encoding: NSUTF8StringEncoding)
            
        }
        catch {}
        
        //reading
        do {
            let text2 = try NSString(contentsOfFile: path, encoding: NSUTF8StringEncoding)
        }
        catch {/* error handling here */}
        */
    }
    
}
