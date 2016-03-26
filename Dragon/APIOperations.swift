//
//  APIOperations.swift
//  Dragon
//
//  Created by Hongyi on 16/3/24.
//  Copyright © 2016年 MealSloth. All rights reserved.
//

import Foundation

class APIOperations{
    
    class func postRequest(json : Dictionary<String, AnyObject>, url : String) -> NSDictionary {
        
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        request.HTTPMethod = "POST"
        request.addValue("application/json",forHTTPHeaderField: "Content-Type")
        request.addValue("application/json",forHTTPHeaderField: "Accept")
        do{
            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(json, options: NSJSONWritingOptions.PrettyPrinted)
        }catch{}
        
        var result : NSDictionary = NSDictionary()
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            guard data != nil else {
                print("no data found: \(error)")
                return
            }
            do {
                if let jsonResult : NSDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary {
                    
                    result = jsonResult
                    
                }
            } catch let parseError {
                print(parseError)
            }
        }
        
        task.resume()
        
        while(result.count == 0){}
        
        return result
    }
    
    
}
