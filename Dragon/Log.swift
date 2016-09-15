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
    
    internal class func position(file file: String, function: String, line: Int) -> String
    {
        let path = file.componentsSeparatedByString("/")
        if let file = path[safe: path.count - 1]?.stringByReplacingOccurrencesOfString(".swift", withString: "")
        {
            return "<\(file):\(line)>"
        }
        return ""
    }
    
    internal class func logFirst(type: LogType, file: String, function: String, line: Int, strArr: [String]?)
    {
        if let first = strArr?[safe: 0]
        {
            print("Log.\(type.rawValue)\(position(file: file, function: function, line: line)): \(first)")
        }
        else
        {
            print("Log.\(type.rawValue)\(position(file: file, function: function, line: line)): Could not parse string")
        }
    }
    
    internal class func logRemaining(strArr: [String]?)
    {
        if let count = strArr?.count where count > 1
        {
            for newLine in 1..<count
            {
                if let line = strArr?[safe: newLine]
                {
                    print(line)
                }
            }
        }
    }
    
    internal class func log(type type: LogType, string: String?, file: String, function: String, line: Int)
    {
        let strArr = string?.componentsSeparatedByString("\n")
        self.logFirst(type, file: file, function: function, line: line, strArr: strArr)
        self.logRemaining(strArr)
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
