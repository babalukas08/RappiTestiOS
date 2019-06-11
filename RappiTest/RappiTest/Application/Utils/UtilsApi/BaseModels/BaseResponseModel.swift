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
    
    var page:           Int = 0
    var total_results:  Int = 0
    var total_pages:    Int = 0
    var results:        [Any] = []
    // For Error
    var status_code:    String = ""
    var status_message: String = ""
    var success:        Bool   = false
    init() { }
    
    required public init?(map: Map){}
    
    public func mapping(map: Map) {
        page            <- map["page"]
        total_results   <- map["total_results"]
        total_pages     <- map["total_pages"]
        results         <- map["results"]
        status_code     <- map["status_code"]
        status_message  <- map["status_message"]
        success         <- map["success"]
    }
    
    public var description: String {
        return "StandardResponseModel: {page: \(page), title: \(total_results), results: \(results), status_code: \(status_code), status_message: \(status_message), success: \(success)}"
    }
}

