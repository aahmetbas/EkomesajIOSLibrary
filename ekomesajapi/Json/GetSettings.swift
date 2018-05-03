//
//  GetSettings.swift
//  ekomesajapi
//
//  Created by Alperen Ahmet Baş on 3.05.2018.
//  Copyright © 2018 Alperen Ahmet Baş. All rights reserved.
//

import Foundation

public class GetSettings {
    class func post(credential:Credential, completion: @escaping (_ response:ResponseSettings) -> ()){
        let status = Status()
        let responseSettings = ResponseSettings()
        
        let myUrl = NSURL(string: "http://gw.barabut.com/v1/json/syncreply/GetSettings")
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
                completion(responseSettings)
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String:AnyObject]{
                    if let responseStatus = json["Response"]?.value(forKey: "Status") as? [String:AnyObject]{
                        status.code = responseStatus["Code"] as! Int
                        status.desc = responseStatus["Description"] as! String
                        responseSettings.status = status
                        
                        if(status.code == 200){
                            let jsonSetting = json["Response"]?.value(forKey: "Settings") as? [String:AnyObject]
             
                            responseSettings.settings.balance.main  = jsonSetting!["Balance"]?.value(forKey: "Main") as! Int
                            responseSettings.settings.balance.limit = jsonSetting!["Balance"]?.value(forKey: "Limit") as! Int
                            
                            let operatorSettings = OperatorSettings()
                            if let account:String = jsonSetting!["OperatorSettings"]?.value(forKey: "Account") as? String{
                                operatorSettings.account = account
                            }
                            
                            if let msisdn:String = jsonSetting!["OperatorSettings"]?.value(forKey: "MSISDN") as? String{
                                 operatorSettings.msisdn = msisdn
                            }
                            
                            if let variantId:String = jsonSetting!["OperatorSettings"]?.value(forKey: "VariantId") as? String{
                                operatorSettings.variantId = variantId
                            }
                            
                            if let serviceId:String = jsonSetting!["OperatorSettings"]?.value(forKey: "ServiceId") as? String{
                                operatorSettings.serviceId = serviceId
                            }
                            
                            if let unitPrice:Int = jsonSetting!["OperatorSettings"]?.value(forKey: "UnitPrice") as? Int{
                                operatorSettings.unitPrice = unitPrice
                            }
                            responseSettings.settings.operatorSettings = operatorSettings
                            
                            let senderList = jsonSetting?["Senders"] as? [AnyObject]
                            for sender in senderList! {
                                autoreleasepool {
                                    let temp = Sender()
                                    temp.value        = sender.value(forKey: "Value") as! String
                                    temp.isDefault    = sender.value(forKey: "Default") as! Bool
                                    responseSettings.settings.senders.append(temp)
                                }
                            }
                            
                            if let keywordList = jsonSetting!["OperatorSettings"]?.value(forKey: "Keywords") as? [AnyObject]{
                                for keyword in keywordList {
                                    autoreleasepool {
                                        let temp = Keyword()
                                        temp.serviceNumber  = keyword.value(forKey: "ServiceNumber") as! String
                                        temp.value          = keyword.value(forKey: "Value") as! String
                                        temp.timestamp      = keyword.value(forKey: "Timestamp") as! String
                                        temp.validity       = keyword.value(forKey: "Validity") as! Int
                                        responseSettings.settings.keywords.append(temp)
                                    }
                                }
                            }
                        }
                    }
                    completion(responseSettings)
                } else {
                    let jsonStr = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                    print("Error could not parse JSON: \(String(describing: jsonStr))")
                    completion(responseSettings)
                }
            } catch let parseError {
                print(parseError)
                let jsonStr = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                print("Error could not parse JSON: '\(String(describing: jsonStr))'")
                completion(responseSettings)
            }
        }
        task.resume()
    }
}
