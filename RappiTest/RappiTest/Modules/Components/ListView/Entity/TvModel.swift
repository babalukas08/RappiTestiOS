//
//  TvModel.swift
//  RappiTest
//
//  Created by Mauricio Jimenez on 06/06/19.
//  Copyright © 2019 com.MauJimenez. All rights reserved.
//
// BaseTvSeriesModel
import Foundation
import ObjectMapper

public class TvModel: BaseTvSeriesModel {
    
    var original_name: String = ""
    var name: String = ""
    var first_air_date : String = ""
    var origin_country : [Int:String] = [:]
    
    override init() {
        super.init()
    }
    
    required public init?(map: Map){
        super.init(map: map)
    }
    
    public override func mapping(map: Map) {
        super.mapping(map: map)
        original_name <- map["original_name"]
        name <- map["name"]
        first_air_date <- map["first_air_date"]
        origin_country <- map["origin_country"]
    }
    
    public override var description: String {
        return "\(super.description) TvModel: {original_name: \(String(describing: original_name)), name: \(String(describing: name)), first_air_date: \(String(describing: first_air_date)), origin_country: \(origin_country)}"
    }
}
