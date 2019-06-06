//
//  BaseResponseModel.swift
//  GoSample
//
//  Created by Mauricio Jimenez on 22/04/19.
//  Copyright © 2019 com.AlphaSoluciones. All rights reserved.
//

import Foundation
import ObjectMapper

public class BaseResponseModel: Mappable, CustomStringConvertible {
    var ok :   Int?
    var message: String?
    
    init() { }
    
    required public init?(map: Map){
        
    }
    
    public func mapping(map: Map) {
        ok     <- map["ok"]
        message        <- map["message"]
    }
    
    public var description: String {
        return "BaseResponseModel: {\(String(describing: ok)), \(String(describing: message))}"
    }
    
    public func getCodeResponse() -> Int {
        guard let code = ok else {
            return -1
        }
        
        return code
    }
}

public struct ErrorModel {
    var errordata: ErrorResponseModel?
    var errorcode: String?
    
    public init (errordata : ErrorResponseModel?, errorcode : String?) {
        self.errordata = errordata
        self.errorcode = errorcode
    }
}
