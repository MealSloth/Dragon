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
    var type: LogType = .normal
    
    enum LogType: String
    {
        case debug = "Debug"
        case error = "Error"
        case info = "Info"
        case normal = "Normal"
        case verbose = "Verbose"
        case warning = "Warning"
    }
    
    internal class func log(type type: LogType, string: String, data: Dictionary<String, String> = [:])
    {
        var log = "Log.\(type.rawValue): \(string)"
        for (key, value) in data
        {
            log = log.stringByReplacingOccurrencesOfString(key, withString: value)
        }
        print(log)
    }
    
    class func string(string: String?, type: LogType = .info)
    {
        let str = ":str"
        
        var data: Dictionary<String, String> = [:]
        data[str] = string
        
        self.log(type: type, string: "\(str)", data: data)
    }
    
    class func error(error: NSError?, type: LogType = .error)
    {
        let desc = ":desc"
        
        var data: Dictionary<String, String> = [:]
        data[desc] = error?.localizedDescription
        
        self.log(type: type, string: "\(desc)", data: data)
    }
    
    class func array(array: [AnyObject]?, type: LogType = .info)
    {
        let arr = ":arr"
        
        var data: Dictionary<String, String> = [:]
        data[arr] = array?.description
        
        self.log(type: type, string: "\(arr)", data: data)
    }
    
    class func dictionary(dictionary: Dictionary<String, AnyObject>?, type: LogType = .info)
    {
        let dict = ":dict"

        var data: Dictionary<String, String> = [:]
        data[dict] = dictionary?.description
            
        self.log(type: type, string: "\(dict)", data: data)
    }
}