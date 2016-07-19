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
    var host: APIHost.APIHostEnum! { get set }
    var method: String! { get set }
    
    var resultHandler: ((result: NSDictionary) -> Void)? { get set }
    var errorHandler: ((error: ErrorType?) -> Void)? { get set }
}

extension APIRequest
{
    func post(onCompletion completion: ((result: NSDictionary) -> Void)? = nil, onError: ((ErrorType?) -> Void)? = nil)
    {
        let request = NSMutableURLRequest(URL: NSURL(string: "\(APIHost.URL(self.host))\(self.method)")!)
        request.HTTPMethod = "POST"
        request.addValue("application/json",forHTTPHeaderField: "Content-Type")
        request.addValue("application/json",forHTTPHeaderField: "Accept")
        
        Log.string("Executing POST request at \(APIHost.URL(self.host))\(self.method)")
        
        do
        {
            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(self.json, options: NSJSONWritingOptions.PrettyPrinted)
        }
        catch let postError
        {
            Log.error(postError as NSError)
        }
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request)
        {
            (data, response, error) -> Void in
            
            guard data != nil else
            {
                onError?(error)
                return
            }
            do
            {
                if let jsonResult : NSDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
                {
                    Log.string("Received response for POST request at \(APIHost.URL(self.host))\(self.method) with JSON object:")
                    Log.dictionary(jsonResult as? Dictionary<String, AnyObject>)
                    completion?(result: jsonResult)
                }
            }
            catch
            {
                onError?(error)
            }
        }
        
        task.resume()
    }
}