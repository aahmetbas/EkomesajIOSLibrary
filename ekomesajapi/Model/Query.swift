//
//  Query.swift
//  ekomesajapi
//
//  Created by Alperen Ahmet Baş on 3.05.2018.
//  Copyright © 2018 Alperen Ahmet Baş. All rights reserved.
//

import Foundation

public class Query:NSObject {
    public var id         = 0
    public var network    = 0
    public var msisdn     = ""
    public var cost       = 0
    public var submitted  = ""
    public var lastUpdate = ""
    public var state      = ""
    public var sequence   = 0
    public var errorCode  = 0
    public var payLoad    = ""
    public var xser       = ""
    
    public override var description: String{
        var temp = "Id: \(id) Network: \(network) MSISDN: \(msisdn) Cost: \(cost) Submitted: \(submitted) "
        temp = temp + "LastUpdate: \(lastUpdate) State: \(state) Sequence: \(sequence) ErrorCode: \(errorCode) "
        temp = temp + "PayLoad: \(payLoad) Xser: \(xser) "
        return temp
    }
}
