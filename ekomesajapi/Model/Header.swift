//
//  Header.swift
//  ekomesajapi
//
//  Created by Alperen Ahmet Baş on 3.05.2018.
//  Copyright © 2018 Alperen Ahmet Baş. All rights reserved.
//

import Foundation

public class Header:NSObject {
    public var from     = ""
    public var scheduledDeliveryTime = ""
    public var validityPeriod = 0
    
    public var convertToJson:String {
        return "\"Header\":{\"From\":\"\(from)\",\"ValidityPeriod\":\(validityPeriod),\"ScheduledDeliveryTime\":\"\(scheduledDeliveryTime)\"}"
    }
}
