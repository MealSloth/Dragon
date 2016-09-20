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
    
    var resultHandler: ((_ result: Dictionary<String, AnyObject>) -> Void)? { get set }
    var errorHandler: ((_ error: NSError?) -> Void)? { get set }
}

extension APIRequest
{
    func post(onCompletion completion: ((_ result: Dictionary<String, AnyObject>) -> Void)? = nil, onError: ((Error?) -> Void)? = nil)
    {
        let url = "\(self.host.url())\(self.method)"
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        request.addValue("application/json",forHTTPHeaderField: "Content-Type")
        request.addValue("application/json",forHTTPHeaderField: "Accept")
        
        Log.info("Executing POST request at \(url)")
        
        do
        {
            request.httpBody = try JSONSerialization.data(withJSONObject: self.json, options: JSONSerialization.WritingOptions.prettyPrinted)
        }
        catch let postError as NSError
        {
            Log.error("\(postError)")
        }
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            guard data != nil else
            {
                onError?(error)
                return
            }
            do
            {
                if let jsonResult: Dictionary<String, AnyObject> = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? Dictionary<String, AnyObject>
                {
                    Log.info("Received response for POST request at \(url)")
                    completion?(jsonResult)
                }
            }
            catch let error
            {
                onError?(error)
            }
        }) 
        
        task.resume()
    }
}
