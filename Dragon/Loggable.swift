//
//  Loggable.swift
//  Dragon
//
//  Created by Michael Fourre on 2/4/17.
//  Copyright © 2017 MealSloth. All rights reserved.
//

protocol Loggable {
    
}

extension Loggable {
    internal static func position(file: String, function: String, line: Int) -> String {
        let path = file.components(separatedBy: "/")
        if let file = path[safe: path.count - 1]?.replacingOccurrences(of: ".swift", with: "") {
            return "<\(file):\(line)>"
        }
        return ""
    }
    
    internal static func logFirst(_ type: String, file: String, function: String, line: Int, strArr: [String]?) {
        print("Log.\(type)\(position(file: file, function: function, line: line)): \(strArr?.first ?? "Could not parse string")")
    }
    
    internal static func logRemaining(_ strArr: [String]?) {
        guard let count = strArr?.count , count > 1 else { return }
        for newLine in 1..<count {
            if let line = strArr?[safe: newLine] {
                print(line)
            }
        }
    }
    
    internal static func log(type: String, string: String?, file: String, function: String, line: Int) {
        let strArr = string?.components(separatedBy: "\n")
        self.logFirst(type, file: file, function: function, line: line, strArr: strArr)
        self.logRemaining(strArr)
    }
}
