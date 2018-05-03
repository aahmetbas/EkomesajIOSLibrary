//
//  ResponseLogin.swift
//  ekomesajapi
//
//  Created by Alperen Ahmet Baş on 3.05.2018.
//  Copyright © 2018 Alperen Ahmet Baş. All rights reserved.
//

import Foundation

public class ResponseLogin:NSObject {
    public var status = Status()
    public var userId = 0
    
    public override var description: String{
        return "UserId: \(userId)"
    }
}
