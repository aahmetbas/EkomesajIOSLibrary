//
//  RequestQueryMulti.swift
//  ekomesajapi
//
//  Created by Alperen Ahmet Baş on 3.05.2018.
//  Copyright © 2018 Alperen Ahmet Baş. All rights reserved.
//

import Foundation

public class RequestQueryMulti:NSObject {
    public var credential = Credential()
    public var beginDate = ""
    public var endDate = ""
    
    override init() {
        self.credential = Credential()
        self.beginDate  = ""
        self.endDate     = ""
    }
    
    init(credential: Credential, beginDate: String, endDate:String) {
        self.credential = credential
        self.beginDate  = beginDate
        self.endDate    = endDate
    }
    
    public var convertToJson:String {
        return "{" + credential.description + "," + convert + "}"
    }
    
    private var convert:String {
        return "\"Range\":{\"Begin\":\"\(beginDate)\",\"End\":\"\(endDate)\"}"
    }
}
