//
//  Submit.swift
//  ekomesajapi
//
//  Created by Alperen Ahmet Baş on 3.05.2018.
//  Copyright © 2018 Alperen Ahmet Baş. All rights reserved.
//

import Foundation

public class Submit:NSObject {
    public var dataCoding   = ""
    public var message      = ""
    public var header       = Header()
    public var to:[String]  = []
    
    public var convertToJson:String {
        return "{" + description + "}"
    }
    
    override public var description:String {
        var str = "\"DataCoding\":\"\(dataCoding)\"," + header.convertToJson + ",\"Message\":\"\(message)\","
        str = str + "\"To\":[\(convertList)]"
        return str
    }
    
    private var convertList:String{
        var str = ""
        if(0 < to.count){
            for i in 0..<(to.count - 1){
                str = str + "\"\(to[i])\","
            }
            str = str + "\"\(to[to.count - 1])\""
        }
        return str
    }
}
