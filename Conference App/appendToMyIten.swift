//
//  appendToMyIten.swift
//  Conference App
//
//  Created by George Gruse on 4/15/16.
//  Copyright © 2016 Chrystech Systems. All rights reserved.
//

import Foundation
class appendToMyIten {
    //var path
    var mainFile: String
    
    init()
    {
        let dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true).first!
        mainFile = "data.dat"
        //path = dir.stringByAppendingPathComponent(mainFile);
        
        
    }
    
    
    
    
    //Credit to http://stackoverflow.com/questions/24097826/read-and-write-data-from-text-file by user Adam on the stack
    //overflow site
    
    func appendAgenda(event :Event)
    {
        /*
        var data:NSString = "|id|"+event.id+""+event.date+""++""++""++""
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
