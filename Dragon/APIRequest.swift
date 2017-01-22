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
    var method: String { get set }
    var json: [String:Any] { get set }
    var host: APIHost { get set }
}

extension APIRequest
{
    var cleanedMethod: String {
        get {
            return method.characters.first == "/" ? String(method.characters.dropFirst()) : method
        }
    }
    
    func request<T: APIResult>(onCompletion completion: ((_ result: T) -> Void)? = nil, onError: ((_ error: Error?) -> Void)? = nil)
    {
        let resultHandler = { (result) -> Void in
            completion?(T(result: result))
        }
        let errorHandler = onError
        self.post(onCompletion: resultHandler, onError: errorHandler)
    }
    
    func post(onCompletion completion: ((_ result: [String:Any]) -> Void)? = nil, onError: ((Error?) -> Void)? = nil)
    {
        let urlStr = "\(self.host.url())\(self.cleanedMethod)"
        guard let url = URL(string: urlStr) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = try? JSONSerialization.data(withJSONObject: self.json, options: .prettyPrinted)
        Log.info("Executing POST request at \(urlStr)")
        let task = URLSession.shared.dataTask(with: request,
            completionHandler: { (data, response, error) -> Void in
                guard let jsonData = data else
                {
                    onError?(error)
                    return
                }
                do
                {
                    if let jsonResult = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as? [String:Any]
                    {
                        Log.info("Received response for POST request at \(urlStr)")
                        completion?(jsonResult)
                    }
                }
                catch let error
                {
                    onError?(error)
                }
            }
        )
        task.resume()
    }
}
