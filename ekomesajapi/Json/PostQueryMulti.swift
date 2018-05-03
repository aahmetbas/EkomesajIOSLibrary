//
//  QueryMultiJson.swift
//  ekomesajapi
//
//  Created by Alperen Ahmet Baş on 3.05.2018.
//  Copyright © 2018 Alperen Ahmet Baş. All rights reserved.
//

import Foundation

public class PostQueryMulti {
    class func post(requestQueryMulti:RequestQueryMulti, completion: @escaping (_ response:ResponseQueryMulti) -> ()){
        let status = Status()
        let responseQueryMulit = ResponseQueryMulti()
        
        let myUrl = URL(string: "http://gw.barabut.com/v1/json/syncreply/QueryMulti")
        var request = URLRequest(url: myUrl!)
        let postString = requestQueryMulti.convertToJson
        
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        request.timeoutInterval = 60
        request.httpBody = postString.data(using: String.Encoding.utf8, allowLossyConversion: true)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            guard data != nil else {
                print("no data found: \(String(describing: error))")
                completion(responseQueryMulit)
                return
            }
            do {
                if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String:AnyObject]{
                    if let responseStatus = json["Response"]?.value(forKey: "Status") as? [String:AnyObject]{
                        status.code = responseStatus["Code"] as! Int
                        status.desc = responseStatus["Description"] as! String
                        responseQueryMulit.status = status
                        
                        if(status.code == 200){
                            let reportDetail = json["Response"]?.value(forKey: "Report") as? [String:AnyObject]
                            let repotList = reportDetail?["List"] as? [AnyObject]
                            for queryMulit in repotList! {
                                autoreleasepool {
                                    let temp = QueryMulti()
                                    temp.id         = queryMulit.value(forKey: "Id") as! Int
                                    temp.received   = queryMulit.value(forKey: "Received") as! String
                                    temp.state      = queryMulit.value(forKey: "State") as! String
                                    temp.sender     = queryMulit.value(forKey: "Sender") as! String
                                    temp.cost       = queryMulit.value(forKey: "Cost") as! Int
                                    temp.message    = queryMulit.value(forKey: "Message") as! String
                                    temp.coding     = queryMulit.value(forKey: "Coding") as! String
                                    temp.count      = queryMulit.value(forKey: "Count") as! Int
                                    temp.deliveredCount   = queryMulit.value(forKey: "DeliveredCount") as! Int
                                    temp.undeliveredCount = queryMulit.value(forKey: "UndeliveredCount") as! Int
                                    responseQueryMulit.list.append(temp)
                                }
                            }
                        }
                    }
                    completion(responseQueryMulit)
                } else {
                    let jsonStr = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                    print("Error could not parse JSON: \(String(describing: jsonStr))")
                    completion(responseQueryMulit)
                }
            } catch let parseError {
                print(parseError)
                let jsonStr = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                print("Error could not parse JSON: '\(String(describing: jsonStr))'")
                completion(responseQueryMulit)
            }
        }
        task.resume()
    }
}
