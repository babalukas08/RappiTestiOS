//
//  MainListModel.swift
//  RappiTest
//
//  Created by Mauricio Jimenez on 06/06/19.
//  Copyright © 2019 com.MauJimenez. All rights reserved.
//

import Foundation
import ObjectMapper

public class MainListModel: Mappable, CustomStringConvertible {
    
    var titleSection: String = ""
    var typeCatalog : CatalogsType = .popularMovie
    var data: [DataListModel] = []

    init(typeCatalog : CatalogsType, data: [DataListModel]) {
        self.titleSection = typeCatalog.titleSection
        self.typeCatalog = typeCatalog
        self.data = data
    }
    
    required public init?(map: Map){}
    
    public func mapping(map: Map) {
        titleSection          <- map["titleSection"]
        data                  <- map["data"]
        typeCatalog           <- map["typeCatalog"]
    }
    
    public var description: String {
        return "MainListModel: {titleSection: \(String(describing: titleSection)), data: \(String(describing: data))}"
    }
}

public class DataListModel: Mappable, CustomStringConvertible {
    
    var name: String = ""
    var id: Int = 0
    var image: String = ""
    var genre_ids : [Int] = []
    var typeItem: TypeItem = .movie
    
    var vote_average:  Double       = 0.0
    var overview: String            = ""
    var vote_count: Int             = 0
    var date: String = ""
    
    init() {}
    
    init(movie: MovieModel) {
        self.name = movie.title
        self.id = movie.id
        self.image = movie.poster_path
        self.genre_ids = movie.genre_ids
        self.typeItem = .movie
        self.vote_average = movie.vote_average
        self.overview = movie.overview
        self.vote_count = movie.vote_count
        self.date = movie.release_date
    }
    
    init(tv: TvModel) {
        self.name = tv.name
        self.id = tv.id
        self.image = tv.poster_path
        self.genre_ids = tv.genre_ids
        self.typeItem = .serie
        self.vote_average = tv.vote_average
        self.overview = tv.overview
        self.vote_count = tv.vote_count
        self.date = tv.first_air_date
    }
    
    required public init?(map: Map){}
    
    public func mapping(map: Map) {
        name <- map["name"]
        id   <- map["id"]
        image <- map["image"]
        genre_ids <- map["genre_ids"]
        typeItem <- map["typeItem"]
        vote_average <- map["vote_average"]
        overview <- map["overview"]
        vote_count <- map["vote_count"]
        date <- map["date"]
        
    }
    
    public var description: String {
        return "DataListModel: {name: \(String(describing: name)), id: \(String(describing: id)), genre_ids: \(String(describing: image)), genre_ids: \(genre_ids)}"
    }
    
    func validateIds(data: [Int]) -> Bool {
        let d = data.filter({self.genre_ids.contains($0)})
        return d.count > 0        
    }
}
