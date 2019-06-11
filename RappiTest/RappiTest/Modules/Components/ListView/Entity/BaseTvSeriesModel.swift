//
//  TVAndSeriesModel.swift
//  RappiTest
//
//  Created by Mauricio Jimenez on 06/06/19.
//  Copyright © 2019 com.MauJimenez. All rights reserved.
//

import Foundation
import ObjectMapper

public class BaseTvSeriesModel: Mappable, CustomStringConvertible {
    var id: Int                     = 0
    var vote_count: Int             = 0
    var genre_ids : [Int]           = []
    var popularity: Double          = 0.0
    var backdrop_path: String       = ""
    var original_language: String   = ""
    var vote_average:  Double       = 0.0
    var overview: String            = ""
    var poster_path: String         = ""

    init() {
        
    }
    
    required public init?(map: Map){}
    
    public func mapping(map: Map) {
        vote_count          <- map["vote_count"]
        id                  <- map["id"]
        vote_average        <- map["vote_average"]
        popularity          <- map["popularity"]
        poster_path         <- map["poster_path"]
        original_language   <- map["original_language"]
        genre_ids           <- map["genre_ids"]
        backdrop_path       <- map["backdrop_path"]
        overview            <- map["overview"]
        
    }
    
    public var description: String {
        return "TVAndSeriesModel: {id: \(String(describing: id)), vote_count: \(String(describing: vote_count)), genre_ids: \(String(describing: genre_ids)), popularity: \(popularity), backdrop_path: \(backdrop_path), original_language: \(original_language), vote_average: \(vote_average), overview: \(overview), poster_path: \(poster_path)}"
    }
}
