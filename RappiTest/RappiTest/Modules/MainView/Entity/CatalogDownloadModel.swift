//
//  CatalogDownloadModel.swift
//  RappiTest
//
//  Created by Mauricio Jimenez on 06/06/19.
//  Copyright © 2019 com.MauJimenez. All rights reserved.
//

import Foundation
import ObjectMapper

public class CatalogDownloadModel: Mappable, CustomStringConvertible {
    
    var catalogName: CatalogsType = .popularMovie
    var isDownload : Bool = false
    
    init(catalogName: CatalogsType, isDownload : Bool) {
        self.catalogName = catalogName
        self.isDownload = isDownload
    }
    
    required public init?(map: Map){}
    
    public func mapping(map: Map) {
        catalogName  <- map["catalogName"]
        isDownload   <- map["isDownload"]
    }
    
    public var description: String {
        return "CatalogDownloadModel: {catalogName: \(String(describing: catalogName)), isDownload: \(String(describing: isDownload))}"
    }
}
