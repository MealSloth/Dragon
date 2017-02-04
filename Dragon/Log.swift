//
//  Log.swift
//  Dragon
//
//  Created by Michael Fourre on 7/15/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

struct Log: Loggable {
    enum LogType: String {
        case debug = "Debug"
        case error = "Error"
        case info = "Info"
        case normal = "Normal"
        case verbose = "Verbose"
        case warning = "Warning"
    }
    
    static func debug(_ string: String?, file: String = #file, function: String = #function, line: Int = #line) {
        self.log(type: LogType.debug.rawValue, string: string, file: file, function: function, line: line)
    }
    
    static func error(_ string: String?, file: String = #file, function: String = #function, line: Int = #line) {
        self.log(type: LogType.error.rawValue, string: string, file: file, function: function, line: line)
    }
    
    static func info(_ string: String?, file: String = #file, function: String = #function, line: Int = #line) {
        self.log(type: LogType.info.rawValue, string: string, file: file, function: function, line: line)
    }
    
    static func normal(_ string: String?, file: String = #file, function: String = #function, line: Int = #line) {
        self.log(type: LogType.normal.rawValue, string: string, file: file, function: function, line: line)
    }
    
    static func verbose(_ string: String?, file: String = #file, function: String = #function, line: Int = #line) {
        self.log(type: LogType.verbose.rawValue, string: string, file: file, function: function, line: line)
    }
    
    static func warning(_ string: String?, file: String = #file, function: String = #function, line: Int = #line) {
        self.log(type: LogType.warning.rawValue, string: string, file: file, function: function, line: line)
    }
}
