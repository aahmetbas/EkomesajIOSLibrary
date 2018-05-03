//
//  PostSubmit.swift
//  ekomesajapi
//
//  Created by Alperen Ahmet Baş on 3.05.2018.
//  Copyright © 2018 Alperen Ahmet Baş. All rights reserved.
//

import Foundation

public class PostSubmit {
    class func post(requestSubmit:RequestSubmit, completion: @escaping (_ response:ResponseSubmit) -> ()){
        let status = Status()
        let responseSubmit = ResponseSubmit()
        
        let myUrl = URL(string: "http://gw.barabut.com/v1/json/syncreply/Submit")
        var request = URLRequest(url: myUrl!)
        let postString = requestSubmit.convertToJson
        
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        request.timeoutInterval = 60
        request.httpBody = postString.data(using: String.Encoding.utf8, allowLossyConversion: true)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            guard data != nil else {
                print("no data found: \(String(describing: error))")
                completion(responseSubmit)
                return
            }
            do {
                if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String:AnyObject]{
                    if let responseStatus = json["Response"]?.value(forKey: "Status") as? [String:AnyObject]{
                        status.code = responseStatus["Code"] as! Int
                        status.desc = responseStatus["Description"] as! String
                        responseSubmit.status = status
                        
                        if(status.code == 200){
                            responseSubmit.messageId = (json["Response"]?.value(forKey: "MessageId") as? Int)!
                        }
                    }
                    completion(responseSubmit)
                } else {
                    let jsonStr = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                    print("Error could not parse JSON: \(String(describing: jsonStr))")
                    completion(responseSubmit)
                }
            } catch let parseError {
                print(parseError)
                let jsonStr = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                print("Error could not parse JSON: '\(String(describing: jsonStr))'")
                completion(responseSubmit)
            }
        }
        task.resume()
    }
}
