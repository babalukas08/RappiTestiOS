//
//  MovieModel.swift
//  RappiTest
//
//  Created by Mauricio Jimenez on 06/06/19.
//  Copyright © 2019 com.MauJimenez. All rights reserved.
//

import Foundation
import ObjectMapper

public class MovieModel: BaseTvSeriesModel {
    
    var adult: Bool = false
    var original_title: String = ""
    var release_date : String = ""
    var title : String = ""
    var video: Bool = false
    
    override init() {
        super.init()
    }
    
    required public init?(map: Map){
        super.init(map: map)
    }
    
    public override func mapping(map: Map) {
        super.mapping(map: map)
        adult <- map["adult"]
        original_title <- map["original_title"]
        release_date <- map["release_date"]
        title <- map["title"]
        video <- map["video"]
    }
    
    public override var description: String {
        return "\(super.description) MovieModel: {adult: \(String(describing: adult)), original_title: \(String(describing: original_title)), release_date: \(String(describing: release_date)), title: \(title), video: \(video)}"
    }
}
