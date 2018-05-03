//
//  Envelopes.swift
//  ekomesajapi
//
//  Created by Alperen Ahmet Baş on 3.05.2018.
//  Copyright © 2018 Alperen Ahmet Baş. All rights reserved.
//

import Foundation
public class Envelopes:NSObject {
    public var message = ""
    public var to = ""
    
    init(to: String, message: String) {
        self.message = message
        self.to = to
    }
    
    public override var description: String{
        return "{\"Message\":\"\(message)\", \"To\":\"\(to)\"}"
    }
}
