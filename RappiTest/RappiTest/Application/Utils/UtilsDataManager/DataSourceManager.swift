//
//  DataManager.swift
//  GoSample
//
//  Created by Mauricio Jimenez on 22/04/19.
//  Copyright © 2019 com.AlphaSoluciones. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift
import Alamofire
import ObjectMapper

final class DataSourceManager {
    
    // Get String model of Realm
    static func requestDataFromCache(realName: String, cacheManagerName: String) -> String? {
        var stringValue: String?
        //print("Reading Data from cache")
        
        if let cacheManager = try? RealmCacheManager(realmName: cacheManagerName ) {
            if let cacheObject = cacheManager.get(realName) {
                stringValue = cacheObject.value
            }
        }
        else {
            print("Data NOT read")
        }
        
        return stringValue
    }
    
    // Save String model of Realm
    static func saveCacheModel(_ urlString: String, value: String) -> ManagerResult {
        print("Saving CacheModel to cache")
        if let cacheManager = try? RealmCacheManager(realmName: Constants.KeysRealmObject.CacheManagerRealm) {
            cacheManager.add(urlString, value: value)
            print("CacheModel saved to cache successfully")
            return .success
        }
        else {
            print("CacheModel NOT saved")
            return .failure(message: "Error al guardar Dato en DB")
        }
    }
    
    // Remove Entity from REalm
    static func removeCacheModel(_ urlString: String) -> ManagerResult {
        print("Saving CacheModel to cache")
        if let cacheManager = try? RealmCacheManager(realmName: Constants.KeysRealmObject.CacheManagerRealm) {
            cacheManager.remove(urlString)
            print("CacheModel delete to cache successfully")
            return .success
        }
        else {
            print("CacheModel NOT saved")
            return .failure(message: "Error al guardar Dato en DB")
        }
    }
    
    // Remove All DB
    static func removeAllData() -> ManagerResult {
        print("Remove AllData from DB")
        if let cacheManager = try? RealmCacheManager(realmName: Constants.KeysRealmObject.CacheManagerRealm) {
            cacheManager.removeAll()
            print("CacheModel delete All DB to cache successfully")
            return .success
        }
        else {
            print("CacheModel NOT saved")
            return .failure(message: "Error al guardar Dato en DB")
        }
    }
    
    // MARK: - Model Storage

//    static func getIndexModelStorage(model: ModelStorage) -> Int? {
//        let data = self.getDataStorage()
//        guard let index = data.index(where: { (item) -> Bool in
//            model.barcode == item.barcode
//        }) else {
//            return nil
//        }
//
//        return index
//    }
    
   
    // MARK: - This methods is fors Samples
    static func getSampleAgrupador() -> String {
        let code = String(repeating: "9", count: 4) + DataSourceManager.randomString(length: 8)
        print(code)
        return code
    }
    
    static func randomString(length: Int) -> String {
        let letters = "0123456789"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    static func getBarCodeRandom() -> String {
        let data = ["38979827","37790099","39290534","11891128","12794534","13058899","13725167","14156048","14247967","14916907","15322138","15322141","15921198","16088803","16788647","17003351","31135405","37732215","36274593","36231000","39359959","15197103","40026065","40161807"]
        
        return data.randomElement()!
    }
    
    
    // MARK: - Get Headers for Request
    static func getHeaders(_ withToken: Bool) -> [String: String] {
        
        var headers = [String: String]()
        
        // add Keys to Headers
        headers["Content-Type"] = Constants.UrlServices.Content_Type
        headers["Accept"] = Constants.UrlServices.Content_Type
    
        return headers
    }
    
    static func getBodyToken() -> [String: String] {
        
        var headers = [String: String]()
        
        // add Keys to Headers
        headers["client_id"] = "e4322c795fed4e2dabdbd525e7a1decc"
        headers["granttype"] = "password"
        headers["scope"] = "FullControl"
        headers["username"] = "eph_loftdigital"
        headers["password"] = "3ph_n4v1d4d3s"
        
        
        return headers
    }
    
    static func getBaseModel(by type: CatalogsType) -> BaseResponseModel? {
        guard let dataJsonString = DataSourceManager.requestDataFromCache(realName: type.realmKey, cacheManagerName: Constants.KeysRealmObject.CacheManagerRealm) else {
            return nil
        }
        
        guard let model : BaseResponseModel = Mapper<BaseResponseModel>().map(JSONString: dataJsonString) else {
            return nil
        }
        
        return model

    }
    
    static func getGenderModel(by type: TypeItem) -> BaseGenerModel? {
        guard let dataJsonString = DataSourceManager.requestDataFromCache(realName: type.realmKey, cacheManagerName: Constants.KeysRealmObject.CacheManagerRealm) else {
            return nil
        }
        
        guard let model : BaseGenerModel = Mapper<BaseGenerModel>().map(JSONString: dataJsonString) else {
            return nil
        }
        
        return model
        
    }
    
    static func getGenderData(by type: TypeItem) -> [GenerModel] {
        guard let dataJsonString = DataSourceManager.requestDataFromCache(realName: type.realmKey, cacheManagerName: Constants.KeysRealmObject.CacheManagerRealm) else {
            return []
        }
        
        guard let model : BaseGenerModel = Mapper<BaseGenerModel>().map(JSONString: dataJsonString) else {
            return []
        }
        
        return model.genres
        
    }
    
    static func getDataFilter() -> [BaseGenerModel] {
        var result = [BaseGenerModel]()
        
        if let seriesFilter = self.getGenderModel(by: TypeItem.serie) {
            result.append(seriesFilter)
        }
        
        if let movieFilter = self.getGenderModel(by: TypeItem.movie) {
            result.append(movieFilter)
        }
        
        return result
    }
    
    static func filtersSelect() -> [Int] {
        let data = self.getDataFilter()
        let ids = data.map{$0.genres.filter{$0.isSelect}.compactMap({$0.id})}.flatMap({$0.map{$0}})
        
        return ids
    }
    
    static func getDataMain(ids: [Int]? = nil) -> [MainListModel] {
        var data = [MainListModel]()
        let catalog = Constants.Catalogs.dataCatalogs
        
        for value in catalog {
            guard let model = self.getBaseModel(by: value) else {
                continue
            }
            
            if let id = ids {
                let models = self.getFilterByGender(data: model.results, ids: id)
                data.append(MainListModel(typeCatalog: value, data: models))
            }
            else {
                let models = self.getMainModel(data: model.results)
                data.append(MainListModel(typeCatalog: value, data: models))
            }
            
        }
        
        return data
    }
    
    static func getMainModel(data: [Any]) -> [DataListModel] {
        var result = [DataListModel]()
        for value in data {
            if let movie: MovieModel = Mapper<MovieModel>().map(JSONObject: value) {
                if movie.title.isEmpty {
                    if let tv: TvModel = Mapper<TvModel>().map(JSONObject: value) {
                        result.append(DataListModel(tv: tv))
                    }
                }
                else {
                    result.append(DataListModel(movie: movie))
                }
            }
            else if let tv: TvModel = Mapper<TvModel>().map(JSONObject: value) {
                result.append(DataListModel(tv: tv))
            }
        }
        
        
        return result
    }
    
    // get ids Gender
    static func getFilterByGender(data: [Any], ids: [Int]) -> [DataListModel] {
        var result = [DataListModel]()
        for value in data {
            if let movie: MovieModel = Mapper<MovieModel>().map(JSONObject: value) {
                if movie.title.isEmpty {
                    if let tv: TvModel = Mapper<TvModel>().map(JSONObject: value) {
                        if ids.contains(where: { (value) -> Bool in
                            return tv.genre_ids.contains(value)
                        }) {
                            result.append(DataListModel(tv: tv))
                        }
                    }
                }
                else {
                    if ids.contains(where: { (value) -> Bool in
                        return movie.genre_ids.contains(value)
                    }) {
                        result.append(DataListModel(movie: movie))
                    }
                }
            }
            else if let tv: TvModel = Mapper<TvModel>().map(JSONObject: value) {
                if ids.contains(where: { (value) -> Bool in
                    return tv.genre_ids.contains(value)
                }) {
                    result.append(DataListModel(tv: tv))
                }
            }
        }
        
        
        return result
    }
    
    // MARK: - Video
    static func getVideoKey() -> String {
        guard let dataJsonString = DataSourceManager.requestDataFromCache(realName: Constants.KeysRealmObject.RealmCurrentVideo, cacheManagerName: Constants.KeysRealmObject.CacheManagerRealm) else {
            return ""
        }
        
        guard let model : VideoResponseModel = Mapper<VideoResponseModel>().map(JSONString: dataJsonString) else {
            return ""
        }
        
        return model.getFirstVideoKey()
        
    }

    
    // GET AccessTokenModel
//    static func getAccessTokenModelDB() -> AccessTokenModel? {
//        
//        guard let dataJsonString = DataSourceManager.requestDataFromCache(realName: Constants.KeysRealmObject.RealmAccessTokenModel, cacheManagerName: Constants.KeysRealmObject.CacheManagerRealm) else {
//            return nil
//        }
//        
//        guard let model : AccessTokenModel = Mapper<AccessTokenModel>().map(JSONString: dataJsonString) else {
//            return nil
//        }
//
//        return model
//
//    }
//    
//    // GET AccesToken String
//    static func getAccessToken() -> String {
//        guard let model = self.getAccessTokenModelDB() else {
//            return ""
//        }
//        
//        return model.getAccessToken()
//    }
    
}
