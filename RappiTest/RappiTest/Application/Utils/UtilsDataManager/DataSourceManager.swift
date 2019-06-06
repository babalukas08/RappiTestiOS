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
    
    static func removeLocalCache(typeDelete: TypeDeleteAll, productDelete: DetailProductModel? = nil, completion: @escaping (_ result: ServicesManagerResult) -> Void) {
        switch typeDelete {
        case .local:
            self.deleteCurrentModelStorage { (result) in
                switch result {
                case .success:
                    self.deleteCurrentProductDetail(completion: { (end) in
                        completion(end)
                    })
                case .failure(let message):
                    completion(.failure(message: message))
                }
            }
        case .list:
            guard let model = self.getModelStorage() else {
                completion(.failure(message: "Error"))
                return
            }
            
            guard let register = model.registerClient else {
                completion(.failure(message: "Error"))
                return
            }
            
            register.productsList.removeAll()
            register.products.removeAll()
            model.registerClient = register
            
            self.saveModelStorage(model: model) { (result) in
                switch result {
                case .success:
                    self.updateModelsStorage(model: model, completion: { (response) in
                        completion(response)
                    })
                case .failure(let message):
                    completion(.failure(message: message))
                }
            }
        case .oneProduct:
            guard let model = self.getModelStorage() else {
                completion(.failure(message: "Error"))
                return
            }
            
            guard let register = model.registerClient else {
                completion(.failure(message: "Error"))
                return
            }
            
            guard let product = productDelete else {
                completion(.failure(message: "Error"))
                return
            }
            
            if let index = self.getIndexDetailProduct(model: product) {
                register.productsList.remove(at: index)
                register.products.remove(at: index)
                model.registerClient = register
                
                self.saveModelStorage(model: model) { (result) in
                    switch result {
                    case .success:
                        self.updateModelsStorage(model: model, completion: { (response) in
                            completion(response)
                        })
                    case .failure(let message):
                        completion(.failure(message: message))
                    }
                }
            }
        }
        
    }
    
    // MARK: - Model Storage
    // Save Current Model Storage by current client
    static func saveModelStorage(model: ModelStorage, completion: @escaping (_ result: ServicesManagerResult) -> Void) {
        //RealmCurrentModelStorage
        let result = DataSourceManager.saveCacheModel(Constants.KeysRealmObject.RealmCurrentModelStorage, value: model.toJSONString() ?? "")
        switch result {
        case .success:
            completion(.success)
        case .failure(let message):
            completion(.failure(message: message))
        }
    }
    
    // Get Current Model Storage
    static func getModelStorage() -> ModelStorage? {
        
        guard let dataJsonString = DataSourceManager.requestDataFromCache(realName: Constants.KeysRealmObject.RealmCurrentModelStorage, cacheManagerName: Constants.KeysRealmObject.CacheManagerRealm) else {
            return nil
        }
        
        guard let model : ModelStorage = Mapper<ModelStorage>().map(JSONString: dataJsonString) else {
            return nil
        }
        
        return model
        
    }
    
    static func updateRegisterModel(by model: RequestCreateShoppingCartModel,completion: @escaping (_ result: ServicesManagerResult) -> Void) {
        guard let modelStorage = DataSourceManager.getModelStorage() else {
            completion(.failure(message: "Error"))
            return
        }
        
        modelStorage.registerClient = model
        
        
        DataSourceManager.saveModelStorage(model: modelStorage) { (result) in
                completion(result)
        }
        
    }
    
    
    // Delete Current ModelStorage
    static func deleteCurrentModelStorage(completion: @escaping (_ result: ServicesManagerResult) -> Void) {
        let result = self.removeCacheModel(Constants.KeysRealmObject.RealmCurrentModelStorage)
        switch result {
        case .success:
            completion(.success)
        case .failure(let message):
            completion(.failure(message: message))
        }
    }
    
    // this func get the Shopping Model for Request
    static func getModelRequest() -> RequestCreateShoppingCartModel? {
        guard let model = self.getModelStorage()?.registerClient else {
            return nil
        }
        
        guard let product = self.getDetailProduct() else {
            return model
        }
        
        model.addProductToCart(model: product)
        
        return model
    }
    
    
    
    // this func get current ListCode for update List
    static func getCurrentListCode() -> String {
        guard let model = getModelStorage() else {
            return ""
        }
        
        return model.barcode.isEmpty ? "" : model.barcode
    }
    
    // This func is for update the parameter 'listCode' for update list
    static func updateModelStorage(by listCode: String, completion: @escaping (_ result: ServicesManagerResult) -> Void) {
        
        guard let model = DataSourceManager.getModelStorage() else {
            completion(.failure(message: "Error al actualizar listCode"))
            return
        }
        
        model.barcode = listCode
        
        if let modelRegister = self.getModelRequest() {
            modelRegister.listcode = listCode
            model.registerClient = modelRegister
        }
        
        DataSourceManager.saveModelStorage(model: model) { (result) in
            switch result {
            case .success:
                DataSourceManager.updateModelsStorage(model: model, completion: { (result) in
                    completion(result)
                })
            case .failure(let message):
                completion(.failure(message: message))
            }
        }
    }
    
    // This func update the Model Storage after response success
    static func updateModelStorage(completion: @escaping (_ result: ServicesManagerResult) -> Void) {
        
        guard let model = DataSourceManager.getModelStorage() else {
            completion(.failure(message: "Error al actualizar listCode"))
            return
        }
        
        if let modelRegister = self.getModelRequest() {
            model.registerClient = modelRegister
        }
        
        DataSourceManager.saveModelStorage(model: model) { (result) in
            switch result {
            case .success:
                // this line update the DataHistoryModel
                self.updateModelsStorage(model: model, completion: { (response) in
                    completion(response)
                })
            case .failure(let message):
                completion(.failure(message: message))
            }
        }
    }
    
    static func getDetailProducts() -> [DetailProductModel] {
        guard let model = self.getModelStorage()?.registerClient?.productsList else {
            return []
        }
        
        return model
    }
    
    static func setDetailModel(row: Int, completion: @escaping (_ result: ServicesManagerResult) -> Void) {
        guard let model = DataSourceManager.getModelRequest()?.productsList else {
            completion(.failure(message: "Error"))
            return
        }
        
        DataSourceManager.saveCurrentDetailProduct(model: model[row]) { (result) in
            completion(result)
        }
    }
    
    static func setHistory(row: Int, completion: @escaping (_ result: ServicesManagerResult) -> Void) {
        let modal = DataSourceManager.getDataStorage()
        
        DataSourceManager.saveModelStorage(model: modal[row]) { (result) in
            completion(result)
        }
    }
    
    
    // MARK: - Detail Product
    // This is for save current Detail Product for Response
    static func saveCurrentDetailProduct(model: DetailProductModel, completion: @escaping (_ result: ServicesManagerResult) -> Void) {
        let result = DataSourceManager.saveCacheModel(Constants.KeysRealmObject.RealmCurrentProduct, value: model.toJSONString() ?? "")
        switch result {
        case .success:
            completion(.success)
        case .failure(let message):
            completion(.failure(message: message))
        }
    }
    
    // This get Detail Current Product
    static func getDetailProduct() -> DetailProductModel? {
        
        guard let dataJsonString = DataSourceManager.requestDataFromCache(realName: Constants.KeysRealmObject.RealmCurrentProduct, cacheManagerName: Constants.KeysRealmObject.CacheManagerRealm) else {
            return nil
        }
        
        guard let model : DetailProductModel = Mapper<DetailProductModel>().map(JSONString: dataJsonString) else {
            return nil
        }
        
        return model
        
    }
    
    // Delete Current Product Detail
    static func deleteCurrentProductDetail(completion: @escaping (_ result: ServicesManagerResult) -> Void) {
        let result = self.removeCacheModel(Constants.KeysRealmObject.RealmCurrentProduct)
        switch result {
        case .success:
            completion(.success)
        case .failure(let message):
            completion(.failure(message: message))
        }
    }
    
    static func updateQuantity(qty: Int, completion: @escaping (_ result: ServicesManagerResult) -> Void) {
        guard let product = self.getDetailProduct() else {
            return
        }
        
        product.qty = qty
        
        self.saveCurrentDetailProduct(model: product) { (result) in
            completion(result)
        }
    }
    
    static func updateQuantityby(model: DetailProductModel, qty: Int, completion: @escaping (_ result: ServicesManagerResult) -> Void) {
        if let index = self.getIndexDetailProduct(model: model) {
            
            guard let model = self.getModelStorage() else {
                completion(.failure(message: "Error"))
                return
            }
            
            guard let register = model.registerClient else {
                completion(.failure(message: "Error"))
                return
            }
            
            register.products[index].qty = qty
            register.productsList[index].qty = qty
            model.registerClient = register
            
            self.saveModelStorage(model: model) { (result) in
                switch result {
                case .success:
                    self.updateModelsStorage(model: model, completion: { (response) in
                        completion(response)
                    })
                case .failure(let message):
                    completion(.failure(message: message))
                }
            }

        }
    }
    
    
    // MARK: - DataHistoryModel
    // This function save the data for history clients or carts by clients
    static func saveDataHistory(dataHistory: DataHistoryModel, completion: @escaping (_ result: ServicesManagerResult) -> Void) {
        
        let result = DataSourceManager.saveCacheModel(Constants.KeysRealmObject.RealmCurrentStorage, value: dataHistory.toJSONString() ?? "")
        switch result {
        case .success:
            completion(.success)
        case .failure(let message):
            completion(.failure(message: message))
        }
        
    }
    
    // This Function get the data for history clients
    static func getDataStorageModel() -> DataHistoryModel? {
        
        guard let dataJsonString = DataSourceManager.requestDataFromCache(realName: Constants.KeysRealmObject.RealmCurrentStorage, cacheManagerName: Constants.KeysRealmObject.CacheManagerRealm) else {
            return nil
        }
        
        guard let model : DataHistoryModel = Mapper<DataHistoryModel>().map(JSONString: dataJsonString) else {
            return nil
        }
        
        return model
        
    }
    
    static func getDataStorage() -> [ModelStorage] {
        guard let data = self.getDataStorageModel() else {
            return []
        }
        
        
        return data.data
    }
    
    static func getIndexModelStorage(model: ModelStorage) -> Int? {
        let data = self.getDataStorage()
        guard let index = data.index(where: { (item) -> Bool in
            model.barcode == item.barcode
        }) else {
            return nil
        }
        
        return index
    }
    
    static func getIndexDetailProduct(model: DetailProductModel) -> Int? {
        let data = self.getDetailProducts()
        guard let index = data.index(where: { (item) -> Bool in
            model.sku == item.sku
        }) else {
            return nil
        }
        
        return index
    }
    
    
    // This func is for add/update the DataHistory Model
    static func updateModelsStorage(model: ModelStorage, completion: @escaping (_ result: ServicesManagerResult) -> Void) {
        
        var data = self.getDataStorage()

        if let storage = self.getDataStorageModel() {
        
            // if exist the model on the current update list
            if let index = getIndexModelStorage(model: model) {
                data[index] = model
            }
            else { // if current model not exist on data append new model
                data.append(model)
            }
            
            // this is for update all data history Model
            storage.data = data
            storage.dateSave = Date().formattedDate()
            
            self.saveDataHistory(dataHistory: storage) { (result) in
                completion(result)
            }
        }
        else {
            // add model for first time
            data.append(model)
            
            // add the new DataHistory
            let modelHistory = DataHistoryModel(dateSave: Date().formattedDate(), data: data)
            
            self.saveDataHistory(dataHistory: modelHistory) { (result) in
                completion(result)
            }
        }
        
    }
    
    
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
        headers["Content-Type"] = Constants.UrlServices.Content_TypeToken
        
        if !withToken {
            headers["Content-Type"] = Constants.UrlServices.Content_Type
            headers["Accept"] = Constants.UrlServices.Content_Type
            headers["GENEXUS-AGENT"] = Constants.UrlServices.GENEXUS_AGENT
            headers["Authorization"] = DataSourceManager.getAccessToken()
        }
        
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
    
    // GET AccessTokenModel
    static func getAccessTokenModelDB() -> AccessTokenModel? {
        
        guard let dataJsonString = DataSourceManager.requestDataFromCache(realName: Constants.KeysRealmObject.RealmAccessTokenModel, cacheManagerName: Constants.KeysRealmObject.CacheManagerRealm) else {
            return nil
        }
        
        guard let model : AccessTokenModel = Mapper<AccessTokenModel>().map(JSONString: dataJsonString) else {
            return nil
        }
        
        return model
        
    }
    
    // GET AccesToken String
    static func getAccessToken() -> String {
        guard let model = self.getAccessTokenModelDB() else {
            return ""
        }
        
        return model.getAccessToken()
    }
    
}
