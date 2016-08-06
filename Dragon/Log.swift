//
//  Log.swift
//  Dragon
//
//  Created by Michael Fourre on 7/15/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation

class Log
{
    enum LogType: String
    {
        case debug = "Debug"
        case error = "Error"
        case info = "Info"
        case normal = "Normal"
        case verbose = "Verbose"
        case warning = "Warning"
    }
    
    /* Objects which do not implement protocol CustomStringConvertible will need to be handled manually
       with the data parameter. A commented example is given below showing how this would work. */
    internal class func log(type type: LogType, string: String, data: Dictionary<String, String?> = [:])
    {
        var log = "Log.\(type.rawValue): \(string)"
        for (key, value) in data
        {
            let val = (value == nil) ? "" : value!
            log = log.stringByReplacingOccurrencesOfString(key, withString: val)
        }
        print(log)
    }
    
    class func Debug(string: String)
    {
        self.log(type: .debug, string: string)
    }
    
    class func Error(string: String)
    {
        self.log(type: .error, string: string)
    }
    
    class func Info(string: String)
    {
        self.log(type: .info, string: string)
    }
    
    class func Normal(string: String)
    {
        self.log(type: .normal, string: string)
    }
    
    class func Verbose(string: String)
    {
        self.log(type: .verbose, string: string)
    }
    
    class func Warning(string: String)
    {
        self.log(type: .warning, string: string)
    }
    
//    class func string(string: String, type: LogType = .info)
//    {
//        let str = ":str"
//        
//        var data: Dictionary<String, String> = [:]
//        data[str] = string
//        
//        self.log(type: type, string: "\(str)", data: data)
//    }
}