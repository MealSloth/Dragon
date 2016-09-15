//
//  APIRequest.swift
//  Dragon
//
//  Created by Michael Fourre on 4/29/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation

protocol APIRequest
{
    var json: Dictionary<String, AnyObject> { get set }
    var method: String! { get set }
    var host: APIHost! { get set }
    
    var resultHandler: ((result: Dictionary<String, AnyObject>) -> Void)? { get set }
    var errorHandler: ((error: NSError?) -> Void)? { get set }
}

extension APIRequest
{
    func post(onCompletion completion: ((result: Dictionary<String, AnyObject>) -> Void)? = nil, onError: ((NSError?) -> Void)? = nil)
    {
        let url = "\(self.host.url())\(self.method)"
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        request.HTTPMethod = "POST"
        request.addValue("application/json",forHTTPHeaderField: "Content-Type")
        request.addValue("application/json",forHTTPHeaderField: "Accept")
        
        Log.Info("Executing POST request at \(url)")
        
        do
        {
            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(self.json, options: NSJSONWritingOptions.PrettyPrinted)
        }
        catch let postError as NSError
        {
            Log.Error("\(postError)")
        }
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) -> Void in
            guard data != nil else
            {
                onError?(error)
                return
            }
            do
            {
                if let jsonResult: Dictionary<String, AnyObject> = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? Dictionary<String, AnyObject>
                {
                    Log.Info("Received response for POST request at \(url)")
                    completion?(result: jsonResult)
                }
            }
            catch let error as NSError
            {
                onError?(error)
            }
        }
        
        task.resume()
    }
}
