//
//  Sender.swift
//  ekomesajapi
//
//  Created by Alperen Ahmet Baş on 3.05.2018.
//  Copyright © 2018 Alperen Ahmet Baş. All rights reserved.
//

import Foundation

public class Sender:NSObject {
    public var value     = ""
    public var isDefault = false
    
    override public var description:String {
        let str = "Value: \(value) Default: \(isDefault)"
        return str
    }
}
