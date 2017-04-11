//
//  APIRequest.swift
//  Dragon
//
//  Created by Michael Fourre on 4/29/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation

protocol APIRequest {
    associatedtype APIResultType: APIResult
    var method: String { get set }
    var json: [String:Any] { get set }
    var host: APIHost { get set }
}

extension APIRequest {
    var cleanedMethod: String {
        return self.method.characters.first == "/" ? String(self.method.characters.dropFirst()) : self.method
    }
    
    var defaultError: (Error?) -> Void {
        return { (error) -> Void in
            Log.error("Error during APIRequest: \(error?.localizedDescription ?? "")")
            Message("\(error?.localizedDescription ?? "")").display() //TODO: Remove in production
        }
    }
    
    func request(onCompletion: ((_ result: APIResultType) -> Void)? = nil, onError: ((_ error: Error?) -> Void)? = nil, finally: (() -> Void)? = nil) {
        let resultHandler = { (result) -> Void in
            onCompletion?(APIResultType(result: result))
        }
        let errorHandler = onError
        self.post(onCompletion: resultHandler, onError: errorHandler, finally: finally)
    }
    
    func post(onCompletion: ((_ result: [String:Any]) -> Void)? = nil, onError: ((Error?) -> Void)? = nil, finally: (() -> Void)? = nil) {
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
                defer { finally?() }
                guard let jsonData = data else {
                    onError?(error) ?? self.defaultError(error)
                    return
                }
                do {
                    if let jsonResult = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as? [String:Any] {
                        Log.info("Received response for POST request at \(urlStr)")
                        onCompletion?(jsonResult)
                    }
                }
                catch let error {
                    onError?(error) ?? self.defaultError(error)
                }
            }
        )
        task.resume()
    }
}
