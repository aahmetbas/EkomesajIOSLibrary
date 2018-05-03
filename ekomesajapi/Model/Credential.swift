//
//  Credential.swift
//  ekomesajapi
//
//  Created by Alperen Ahmet Baş on 3.05.2018.
//  Copyright © 2018 Alperen Ahmet Baş. All rights reserved.
//

import Foundation

public class Credential:NSObject {
    public var username = ""
    public var password = ""
    
    override init() {
        self.username = ""
        self.password = ""
    }
    
    init(username: String, password: String) {
        self.username = username
        self.password = password
    }
    
    public var convertToJson:String {
        return "{" + description + "}"
    }
    
    override public var description:String {
        let str = "\"Credential\":{\"Username\":\"\(username)\",\"Password\":\"\(password)\"}"
        return str
    }
}
