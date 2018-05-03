//
//  Query.swift
//  ekomesajapi
//
//  Created by Alperen Ahmet Baş on 3.05.2018.
//  Copyright © 2018 Alperen Ahmet Baş. All rights reserved.
//

import Foundation

public class PostQuery {
    class func post(requestQuery:RequestQuery, completion: @escaping (_ response:ResponseQuery) -> ()){
        let status = Status()
        let responseQuery = ResponseQuery()
        
        let myUrl = URL(string: "http://gw.barabut.com/v1/json/syncreply/Query")
        var request = URLRequest(url: myUrl!)
        let postString = requestQuery.convertToJson
        
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        request.timeoutInterval = 60
        request.httpBody = postString.data(using: String.Encoding.utf8, allowLossyConversion: true)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            guard data != nil else {
                print("no data found: \(String(describing: error))")
                completion(responseQuery)
                return
            }
            do {
                if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String:AnyObject]{
                    if let responseStatus = json["Response"]?.value(forKey: "Status") as? [String:AnyObject]{
                        status.code = responseStatus["Code"] as! Int
                        status.desc = responseStatus["Description"] as! String
                        responseQuery.status = status
                        
                        if(status.code == 200){
                            let reportDetail = json["Response"]?.value(forKey: "ReportDetail") as? [String:AnyObject]
                            let repotList = reportDetail?["List"] as? [AnyObject]
                            for query in repotList! {
                                autoreleasepool {
                                    let temp = Query()
                                    temp.id         = query.value(forKey: "Id") as! Int
                                    temp.network    = query.value(forKey: "Network") as! Int
                                    temp.cost       = query.value(forKey: "Cost") as! Int
                                    temp.sequence   = query.value(forKey: "Sequence") as! Int
                                    temp.errorCode  = query.value(forKey: "ErrorCode") as! Int
                                    temp.msisdn     = query.value(forKey: "MSISDN") as! String
                                    temp.submitted  = query.value(forKey: "Submitted") as! String
                                    temp.lastUpdate = query.value(forKey: "LastUpdated") as! String
                                    temp.state      = query.value(forKey: "State") as! String
                                    temp.payLoad    = query.value(forKey: "Payload") as! String
                                    temp.xser       = query.value(forKey: "Xser") as! String
                                    responseQuery.list.append(temp)
                                }
                            }
                        }
                    }
                    completion(responseQuery)
                } else {
                    let jsonStr = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                    print("Error could not parse JSON: \(String(describing: jsonStr))")
                    completion(responseQuery)
                }
            } catch let parseError {
                print(parseError)
                let jsonStr = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                print("Error could not parse JSON: '\(String(describing: jsonStr))'")
                completion(responseQuery)
            }
        }
        task.resume()
    }
}
