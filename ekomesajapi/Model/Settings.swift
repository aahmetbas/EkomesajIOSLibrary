//
//  Settings.swift
//  ekomesajapi
//
//  Created by Alperen Ahmet Baş on 3.05.2018.
//  Copyright © 2018 Alperen Ahmet Baş. All rights reserved.
//

import Foundation

public class Settings:NSObject {
    public var balance = Balance()
    public var senders:[Sender] = []
    public var keywords:[Keyword] = []
    public var operatorSettings = OperatorSettings()
}
