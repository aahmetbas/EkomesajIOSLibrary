//
//  PostQueryStats.swift
//  ekomesajapi
//
//  Created by Alperen Ahmet Baş on 3.05.2018.
//  Copyright © 2018 Alperen Ahmet Baş. All rights reserved.
//

import Foundation

public class PostQueryStats {
    class func post(credential:Credential, completion: @escaping (_ response:ResponseQueryStats) -> ()){
        let status = Status()
        let responseQueryStats = ResponseQueryStats()
        
        let myUrl = URL(string: "http://gw.barabut.com/v1/json/syncreply/QueryStats")
        var request = URLRequest(url: myUrl!)
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
                completion(responseQueryStats)
                return
            }
            do {
                if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String:AnyObject]{
                    if let responseStatus = json["Response"]?.value(forKey: "Status") as? [String:AnyObject]{
                        status.code = responseStatus["Code"] as! Int
                        status.desc = responseStatus["Description"] as! String
                        responseQueryStats.status = status
                        
                        if(status.code == 200){
                            let reportDetail = json["Response"]?.value(forKey: "Report") as? [String:AnyObject]
                            let repotList = reportDetail?["List"] as? [AnyObject]
                            for queryStats in repotList! {
                                autoreleasepool {
                                    let temp = QueryStats()
                                    temp.year         = queryStats.value(forKey: "Year") as! Int
                                    temp.month        = queryStats.value(forKey: "Month") as! Int
                                    temp.delivered    = queryStats.value(forKey: "Delivered") as! Int
                                    temp.undelivered  = queryStats.value(forKey: "Undelivered") as! Int
                                    temp.count        = queryStats.value(forKey: "Count") as! Int
                                    responseQueryStats.list.append(temp)
                                }
                            }
                        }
                    }
                    completion(responseQueryStats)
                } else {
                    let jsonStr = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                    print("Error could not parse JSON: \(String(describing: jsonStr))")
                    completion(responseQueryStats)
                }
            } catch let parseError {
                print(parseError)
                let jsonStr = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                print("Error could not parse JSON: '\(String(describing: jsonStr))'")
                completion(responseQueryStats)
            }
        }
        task.resume()
    }
}
