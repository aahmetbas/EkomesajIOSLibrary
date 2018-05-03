//
//  RequestQuery.swift
//  ekomesajapi
//
//  Created by Alperen Ahmet Baş on 3.05.2018.
//  Copyright © 2018 Alperen Ahmet Baş. All rights reserved.
//

import Foundation

public class RequestQuery:NSObject {
    public var credential = Credential()
    public var messageId = ""
    public var msisdn = ""
    
    override init() {
        self.credential = Credential()
        self.messageId  = ""
        self.msisdn     = ""
    }
    
    init(credential: Credential, messageId: String) {
        self.credential = credential
        self.messageId  = messageId
    }
    
    init(credential: Credential, messageId: String, phoneNumber:String) {
        self.credential = credential
        self.messageId  = messageId
        self.msisdn     = phoneNumber
    }
    
    public var convertToJson:String {
        return "{" + credential.description + "," + convert + "}"
    }
    
    private var convert:String {
        return "\"MessageId\":\"\(messageId)\",\"MSISDN\":\"\(msisdn)\""
    }
}
