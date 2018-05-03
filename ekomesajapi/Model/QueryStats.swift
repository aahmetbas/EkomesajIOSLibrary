//
//  QueryStats.swift
//  ekomesajapi
//
//  Created by Alperen Ahmet Baş on 3.05.2018.
//  Copyright © 2018 Alperen Ahmet Baş. All rights reserved.
//

import Foundation

public class QueryStats:NSObject {
    public var year         = 0
    public var month        = 0
    public var delivered    = 0
    public var undelivered  = 0
    public var count        = 0
    
    public override var description: String{
        return "Year: \(year) Month: \(month) Delivered: \(delivered) Undelivered: \(undelivered) Count: \(count)"
    }
}
