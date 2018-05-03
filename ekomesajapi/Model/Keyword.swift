//
//  Keyword.swift
//  ekomesajapi
//
//  Created by Alperen Ahmet Baş on 3.05.2018.
//  Copyright © 2018 Alperen Ahmet Baş. All rights reserved.
//

import Foundation

public class Keyword:NSObject {
    public var serviceNumber = ""
    public var timestamp     = ""
    public var value         = ""
    public var validity      = 0
    
    override public var description:String {
        let str = "Value: \(value) ServiceNumber: \(serviceNumber) Timestamp: \(timestamp) Validity: \(validity)"
        return str
    }
}
