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
        
        let data:NSString = "|id|\(event.id)|Date|\(event.date)\n"
        do{
            try data.writeToFile(path as String, atomically: false, encoding: NSUTF8StringEncoding)
        }
        catch {}
    }
    func removeData(id: Int)
    {
        do
        {
            let file = try String(contentsOfFile: path as String)
            let newLine:NSCharacterSet = NSCharacterSet.newlineCharacterSet()
            var data = file.utf16.split{newLine.characterIsMember($0)}.flatMap(String.init)
            for index in 0 ... data.count
            {
                if(data[index].componentsSeparatedByString("|Date|")[0].containsString("\(id)"))
                {
                    data[index] = ""
                    
                }
            }
            let finalData = data.sort().joinWithSeparator("\n")

            
            try finalData.writeToFile(path as String, atomically: false, encoding: NSUTF8StringEncoding)
        }
        catch{}
        
    }
    
}
