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
        let dir:NSString = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true).first!
        mainFile = "data.dat"
        path = dir.stringByAppendingPathComponent(mainFile);
    }
    //Credit to http://stackoverflow.com/questions/24097826/read-and-write-data-from-text-file by user Adam on the stack
    //overflow site
    
    func appendAgenda(event :Event)
    {
        
        let data:NSString = "|id|\(event.id)\n"
        do{
            try data.writeToFile(path as String, atomically: false, encoding: NSUTF8StringEncoding)
            
        }
        catch {}
        
    }
    
}
