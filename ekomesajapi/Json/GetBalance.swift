//
//  GetBalance.swift
//  ekomesajapi
//
//  Created by Alperen Ahmet Baş on 3.05.2018.
//  Copyright © 2018 Alperen Ahmet Baş. All rights reserved.
//

import Foundation

public class GetBalance {
    class func post(credential:Credential, completion: @escaping (_ response:ResponseBalance) -> ()){
        let status = Status()
        let responseBalance = ResponseBalance()
        
        let myUrl = NSURL(string: "http://gw.barabut.com/v1/json/syncreply/GetBalance")
        var request = URLRequest(url: myUrl! as URL)
        let postString = credential.convertToJson
        
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        request.timeoutInterval = 60
        request.httpBody = postString.data(using: String.Encoding.utf8, allowLossyConversion: true)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            guard data != nil else {
                print("no data found: \(String(describing: error))")
                completion(responseBalance)
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String:AnyObject]{
                    if let responseStatus = json["Response"]?.value(forKey: "Status") as? [String:AnyObject]{
                        status.code = responseStatus["Code"] as! Int
                        status.desc = responseStatus["Description"] as! String
                        responseBalance.status = status
                        
                        if(status.code == 200){
                            let balance = json["Response"]?.value(forKey: "Balance") as? [String:AnyObject]
                            responseBalance.balance.main  = balance?["Main"] as! Int
                            responseBalance.balance.limit = balance?["Limit"] as! Int
                        }
                    }
                    completion(responseBalance)
                } else {
                    let jsonStr = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                    print("Error could not parse JSON: \(String(describing: jsonStr))")
                    completion(responseBalance)
                }
            } catch let parseError {
                print(parseError)
                let jsonStr = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                print("Error could not parse JSON: '\(String(describing: jsonStr))'")
                completion(responseBalance)
            }
        }
        task.resume()
    }
}
