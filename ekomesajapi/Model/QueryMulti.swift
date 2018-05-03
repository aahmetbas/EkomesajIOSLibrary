//
//  QueryMulti.swift
//  ekomesajapi
//
//  Created by Alperen Ahmet Baş on 3.05.2018.
//  Copyright © 2018 Alperen Ahmet Baş. All rights reserved.
//

import Foundation

public class QueryMulti:NSObject {
    public var id         = 0
    public var cost       = 0
    public var state      = ""
    public var count      = 0
    public var coding     = ""
    public var message    = ""
    public var received   = ""
    public var sender     = ""
    public var sent       = ""
    public var deliveredCount  = 0
    public var undeliveredCount  = 0
    
    public override var description: String{
        var temp = "Id: \(id) Cost: \(cost) State: \(state) Count: \(count) Coding: \(coding) Message: \(message) "
        temp = temp + "Received: \(received) Sender: \(sender) Sent: \(sent)"
        temp = temp + "DeliveredCount: \(deliveredCount) UndeliveredCount: \(undeliveredCount)"
        return temp
    }
}

