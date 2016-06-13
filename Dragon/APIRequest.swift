//
//  APIRequest.swift
//  Dragon
//
//  Created by Michael Fourre on 4/29/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation

class APIRequest
{
    internal var json: Dictionary<String, AnyObject>
    var host: APIHost.APIHostEnum!
    var method: String!
    
    init(host: APIHost.APIHostEnum, method: String)
    {
        self.host = host
        self.method = method
        
        self.json = [String:AnyObject]()
    }
    
    func appendParameter(key: String, value: AnyObject)
    {
        self.json[key] = value
    }
    
    func post(completion: ((result: NSDictionary) -> APIResult)? = nil, onError: (() -> Void)? = nil)
    {
        let request = NSMutableURLRequest(URL: NSURL(string: "\(APIHost.URL(self.host))\(self.method)")!)
        request.HTTPMethod = "POST"
        request.addValue("application/json",forHTTPHeaderField: "Content-Type")
        request.addValue("application/json",forHTTPHeaderField: "Accept")
        
        do
        {
            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(json, options: NSJSONWritingOptions.PrettyPrinted)
        }
        catch let postError
        {
            print(postError)
        }
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request)
        {
            (data, response, error) -> Void in
            
            guard data != nil else
            {
                onError?()
                return
            }
            do
            {
                if let jsonResult : NSDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
                {
                    completion?(result: jsonResult)
                }
            }
            catch
            {
                onError?()
            }
        }
        
        task.resume()
    }
}