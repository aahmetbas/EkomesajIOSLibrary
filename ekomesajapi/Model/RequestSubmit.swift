//
//  RequestSubmit.swift
//  ekomesajapi
//
//  Created by Alperen Ahmet Baş on 3.05.2018.
//  Copyright © 2018 Alperen Ahmet Baş. All rights reserved.
//

import Foundation

public class RequestSubmit:NSObject {
    public var credential = Credential()
    public var submit = Submit()
    
    override init() {
        self.credential = Credential()
        self.submit  = Submit()
    }
    
    init(credential: Credential, submit: Submit) {
        self.credential = credential
        self.submit = submit
    }
    
    public var convertToJson:String {
        return "{" + credential.description + "," + submit.description + "}"
    }
}
