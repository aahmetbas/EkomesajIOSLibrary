//
//  ResponseQueryStats.swift
//  ekomesajapi
//
//  Created by Alperen Ahmet Baş on 3.05.2018.
//  Copyright © 2018 Alperen Ahmet Baş. All rights reserved.
//

import Foundation

public class ResponseQueryStats:NSObject {
    public var status = Status()
    public var list:[QueryStats] = []
}
