//
//  Log.swift
//  Dragon
//
//  Created by Michael Fourre on 7/15/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

struct Log {
    enum LogType: String {
        case debug = "Debug"
        case error = "Error"
        case info = "Info"
        case normal = "Normal"
        case verbose = "Verbose"
        case warning = "Warning"
    }
    
    internal static func position(file: String, function: String, line: Int) -> String {
        let path = file.components(separatedBy: "/")
        if let file = path[safe: path.count - 1]?.replacingOccurrences(of: ".swift", with: "") {
            return "<\(file):\(line)>"
        }
        return ""
    }
    
    internal static func logFirst(_ type: LogType, file: String, function: String, line: Int, strArr: [String]?) {
        if let first = strArr?.first {
            print("Log.\(type.rawValue)\(position(file: file, function: function, line: line)): \(first)")
        } else {
            print("Log.\(type.rawValue)\(position(file: file, function: function, line: line)): Could not parse string")
        }
    }
    
    internal static func logRemaining(_ strArr: [String]?) {
        if let count = strArr?.count , count > 1 {
            for newLine in 1..<count {
                if let line = strArr?[safe: newLine] {
                    print(line)
                }
            }
        }
    }
    
    internal static func log(type: LogType, string: String?, file: String, function: String, line: Int) {
        let strArr = string?.components(separatedBy: "\n")
        self.logFirst(type, file: file, function: function, line: line, strArr: strArr)
        self.logRemaining(strArr)
    }
    
    static func debug(_ string: String?, file: String = #file, function: String = #function, line: Int = #line) {
        self.log(type: .debug, string: string, file: file, function: function, line: line)
    }
    
    static func error(_ string: String?, file: String = #file, function: String = #function, line: Int = #line) {
        self.log(type: .error, string: string, file: file, function: function, line: line)
    }
    
    static func info(_ string: String?, file: String = #file, function: String = #function, line: Int = #line) {
        self.log(type: .info, string: string, file: file, function: function, line: line)
    }
    
    static func normal(_ string: String?, file: String = #file, function: String = #function, line: Int = #line) {
        self.log(type: .normal, string: string, file: file, function: function, line: line)
    }
    
    static func verbose(_ string: String?, file: String = #file, function: String = #function, line: Int = #line) {
        self.log(type: .verbose, string: string, file: file, function: function, line: line)
    }
    
    static func warning(_ string: String?, file: String = #file, function: String = #function, line: Int = #line) {
        self.log(type: .warning, string: string, file: file, function: function, line: line)
    }
}
