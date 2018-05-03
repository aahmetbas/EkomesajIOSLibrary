//
//  RequestSubmitMulti.swift
//  ekomesajapi
//
//  Created by Alperen Ahmet Baş on 3.05.2018.
//  Copyright © 2018 Alperen Ahmet Baş. All rights reserved.
//

import Foundation

public class RequestSubmitMulti:NSObject {
    public var credential = Credential()
    public var submitMulti = SubmitMulti()
    
    override init() {
        self.credential  = Credential()
        self.submitMulti = SubmitMulti()
    }
    
    init(credential: Credential, submitMulti: SubmitMulti) {
        self.credential = credential
        self.submitMulti = submitMulti
    }
    
    public var convertToJson:String {
        return "{" + credential.description + "," + submitMulti.description + "}"
    }
}

