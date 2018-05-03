//
//  SubmitMulti.swift
//  ekomesajapi
//
//  Created by Alperen Ahmet Baş on 3.05.2018.
//  Copyright © 2018 Alperen Ahmet Baş. All rights reserved.
//

import Foundation

public class SubmitMulti:NSObject {
    public var dataCoding   = ""
    public var header       = Header()
    public var envelopes:[Envelopes]  = []
    
    public var convertToJson:String {
        return "{" + description + "}"
    }
    
    override public var description:String {
        return "\"DataCoding\":\"\(dataCoding)\"," + header.convertToJson + ",\"Envelopes\":[\(convertList)]"
    }
    
    private var convertList:String{
        var str = ""
        if(0 < envelopes.count){
            for i in 0..<(envelopes.count - 1){
                str = str + "\(envelopes[i].description),"
            }
            str = str + "\(envelopes[envelopes.count - 1].description)"
        }
        return str
    }
}

