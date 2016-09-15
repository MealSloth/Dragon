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
    static var file: String = #file
    static var function: String = #function
    static var line: Int = #line
    
    enum LogType: String
    {
        case debug = "Debug"
        case error = "Error"
        case info = "Info"
        case normal = "Normal"
        case verbose = "Verbose"
        case warning = "Warning"
    }
    
    internal class func position(file file: String, function: String, line: Int) -> String
    {
        let path = file.componentsSeparatedByString("/")
        if let file = path[safe: path.count - 1]?.stringByReplacingOccurrencesOfString(".swift", withString: "")
        {
            //return "<\(file).\(function):\(line)?"
            return "<\(file):\(line)?"
        }
        return ""
    }
    
    internal class func log(type type: LogType, string: String?, file: String, function: String, line: Int)
    {
        print("Log.\(type.rawValue) \(position(file: file, function: function, line: line)): \(string)")
    }
    
    class func Debug(string: String?, file: String = #file, function: String = #function, line: Int = #line)
    {
        self.log(type: .debug, string: string, file: file, function: function, line: line)
    }
    
    class func Error(string: String?, file: String = #file, function: String = #function, line: Int = #line)
    {
        self.log(type: .error, string: string, file: file, function: function, line: line)
    }
    
    class func Info(string: String?, file: String = #file, function: String = #function, line: Int = #line)
    {
        self.log(type: .info, string: string, file: file, function: function, line: line)
    }
    
    class func Normal(string: String?, file: String = #file, function: String = #function, line: Int = #line)
    {
        self.log(type: .normal, string: string, file: file, function: function, line: line)
    }
    
    class func Verbose(string: String?, file: String = #file, function: String = #function, line: Int = #line)
    {
        self.log(type: .verbose, string: string, file: file, function: function, line: line)
    }
    
    class func Warning(string: String?, file: String = #file, function: String = #function, line: Int = #line)
    {
        self.log(type: .warning, string: string, file: file, function: function, line: line)
    }
}
