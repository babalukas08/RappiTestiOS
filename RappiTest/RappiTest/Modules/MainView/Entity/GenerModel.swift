//
//  GenerModel.swift
//  RappiTest
//
//  Created by Mauricio Jimenez on 07/06/19.
//  Copyright © 2019 com.MauJimenez. All rights reserved.
//
// GenerModel
import Foundation
import ObjectMapper

public enum TypeItem : String, PersistenceInterface {
    
    case serie
    case movie
    
    var pathRequest: String {
        switch self {
        case .movie:
            return Constants.UrlServices.GetGenerMovie
        case .serie:
            return Constants.UrlServices.GetGenerSerie
        }
    }
    
    var pathBaseRequest: String {
        switch self {
        case .movie:
            return Constants.UrlServices.BasePathMovie
        case .serie:
            return Constants.UrlServices.BasePathTV
        }
    }
    
    var realmKey: String {
        switch self {
        case .movie:
            return Constants.KeysRealmObject.RealmGendersMovie
        case .serie:
            return Constants.KeysRealmObject.RealmGendersSerie
        }
    }
    
    var data : [GenerModel] {
        return DataSourceManager.getGenderData(by: self)
    }
    
    var titleSection: String {
        switch self {
        case .serie:
            return "Categorias Series"
        case .movie:
            return "Categorias Peliculas"
        }
    }
    
}

public class BaseGenerModel: Mappable, CustomStringConvertible {
    
    var genres: [GenerModel] = []
    var typeItem : TypeItem = .serie
    
    init() {}
    
    required public init?(map: Map){}
    
    public func mapping(map: Map) {
        genres  <- map["genres"]
        typeItem <- map["typeItem"]
    }
    
    public var description: String {
        return "BaseGenerModel: {genres: \(String(describing: genres)), typeItem: \(typeItem)}"
    }
    
    public func getSelect() -> [GenerModel] {
        return self.genres.filter({$0.isSelect == true})
    }
}

public class GenerModel: Mappable, CustomStringConvertible {
    
    var id: Int = 0
    var name : String = ""
    var isSelect : Bool = false
    
    init() {}
    
    required public init?(map: Map){}
    
    public func mapping(map: Map) {
        id  <- map["id"]
        name   <- map["name"]
        isSelect <- map["isSelect"]
    }
    
    public var description: String {
        return "GenerModel: {id: \(String(describing: id)), name: \(String(describing: name)), isSelect: \(isSelect)}"
    }
    
}
