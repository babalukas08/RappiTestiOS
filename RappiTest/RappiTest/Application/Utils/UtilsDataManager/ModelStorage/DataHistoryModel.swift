//
//  DataHistoryModel.swift
//  LoftDigitalCliente
//
//  Created by Mauricio Jimenez on 23/05/19.
//  Copyright © 2019 com.AlphaSoluciones. All rights reserved.
//

import Foundation
import ObjectMapper

public class DataHistoryModel: Mappable, CustomStringConvertible {
    // variables Model
    var dateSave: String = ""
    var data: [ModelStorage] = []
    var typeApp : Int = Constants.UrlServices.environment.hashValue
    
    init() { }
    
    init(dateSave: String, data: [ModelStorage]) {
        self.dateSave = dateSave
        self.data = data
    }
    
    required public init?(map: Map){
        
    }
    
    public func mapping(map: Map) {
        dateSave <- map["dateSave"]
        data <- map["data"]
        typeApp <- map["typeApp"]
    }
    
    public var description: String {
        return "DataHistoryModel: {dateSave: \(dateSave) data: \(String(describing: data)), typeApp: \(typeApp)}"
    }
    
}
