//
//  OperatorSettings.swift
//  ekomesajapi
//
//  Created by Alperen Ahmet Baş on 3.05.2018.
//  Copyright © 2018 Alperen Ahmet Baş. All rights reserved.
//

import Foundation

public class OperatorSettings:NSObject {
    public var account      = ""
    public var msisdn       = ""
    public var serviceId    = ""
    public var unitPrice     = 0
    public var variantId    = ""
    
    override public var description:String {
        let str = "Account: \(account) MSISDN: \(msisdn) ServiceId: \(serviceId) UnitPrice: \(unitPrice) VariantId: \(variantId)"
        return str
    }
}

