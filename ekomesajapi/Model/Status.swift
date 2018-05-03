//
//  Status.swift
//  ekomesajapi
//
//  Created by Alperen Ahmet Baş on 3.05.2018.
//  Copyright © 2018 Alperen Ahmet Baş. All rights reserved.
//

import Foundation

public class Status:NSObject {
    public var code  = 0
    public var desc  = ""
    
    public override var description: String{
        return "Code: \(code) Description: \(desc)"
    }
}
