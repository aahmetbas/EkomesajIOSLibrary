//
//  Balance.swift
//  ekomesajapi
//
//  Created by Alperen Ahmet Baş on 3.05.2018.
//  Copyright © 2018 Alperen Ahmet Baş. All rights reserved.
//

import Foundation

public class Balance:NSObject {
    public var main   = 0
    public var limit  = 0
    
    override public var description:String {
        let str = "Main: \(main) Limit: \(limit)"
        return str
    }
}
