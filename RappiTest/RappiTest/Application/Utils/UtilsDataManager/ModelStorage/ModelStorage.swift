//
//  ModelStorage.swift
//  LoftDigitalCliente
//
//  Created by Mauricio Jimenez on 23/05/19.
//  Copyright © 2019 com.AlphaSoluciones. All rights reserved.
//

import Foundation
import ObjectMapper

public class ModelStorage: Mappable, CustomStringConvertible {
    // variables Model
    var barcode: String = ""
    var registerClient: RequestCreateShoppingCartModel?
    var dateSave: String = ""
    var totalAccount: CGFloat = 0.0
    var totalProduct = 0

    init() { }
    
    init(barcode: String, registerClient: RequestCreateShoppingCartModel, dateSave: String, totalAccount: CGFloat) {
        self.barcode = barcode
        self.registerClient = registerClient
        self.dateSave = dateSave
        self.totalAccount = totalAccount
        totalProduct = self.registerClient?.productsList.count ?? 0
    }
    
    required public init?(map: Map){
        
    }
    
    public func mapping(map: Map) {
        barcode <- map["barcode"]
        registerClient <- map["registerClient"]
        dateSave <- map["dateSave"]
        totalAccount <- map["totalAccount"]
        totalProduct <- map["totalProduct"]
    }
    
    public var description: String {
        return "ModelStorage: {barcode: \(barcode) registerClient: \(String(describing: registerClient)), dateSave: \(dateSave), totalAccount : \(totalAccount)}"
    }
    
    
    var name : String {
        guard let nameStr = self.registerClient?.listname else {
            return ""
        }
        
        return nameStr
    }
    
    var project : String {
        guard let pro = self.registerClient?.listvendor else {
            return ""
        }
        
        return pro
    }
    
}

