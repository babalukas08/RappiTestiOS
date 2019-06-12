//
//  VideoResponseModel.swift
//  RappiTest
//
//  Created by Mauricio Jimenez on 11/06/19.
//  Copyright © 2019 com.MauJimenez. All rights reserved.
//
//VideoResponseModel
import Foundation
import ObjectMapper


public class VideoResponseModel: Mappable, CustomStringConvertible {
    
    var id : Int = 0
    var results: [VideModel] = []
    
    init() {}
    
    required public init?(map: Map){}
    
    public func mapping(map: Map) {
        id  <- map["id"]
        results  <- map["results"]
    }
    
    public var description: String {
        return "VideoResponseModel: {results: \(String(describing: results)), results: \(results)}"
    }
    
    public func getFirstVideoKey() -> String {
        return self.results.first?.key ?? ""
    }
}

public class VideModel: Mappable, CustomStringConvertible {
    
    var id: Int = 0
    var iso_3166_1 : String = ""
    var iso_639_1 : String = ""
    var key : String = ""
    var name : String = ""
    var site : String = ""
    var size : String = ""
    var type : String = ""
    
    init() {}
    
    required public init?(map: Map){}
    
    public func mapping(map: Map) {
        id  <- map["id"]
        iso_3166_1   <- map["iso_3166_1"]
        iso_639_1 <- map["iso_639_1"]
        key <- map["key"]
        name <- map["name"]
        site <- map["site"]
        size <- map["size"]
        type <- map["type"]
    }
    
    public var description: String {
        return "VideModel: {id: \(String(describing: id)), iso_3166_1: \(String(describing: iso_3166_1)), iso_639_1: \(iso_639_1), key: \(key), name: \(name), size: \(size), type: \(type)}"
    }
    
}
