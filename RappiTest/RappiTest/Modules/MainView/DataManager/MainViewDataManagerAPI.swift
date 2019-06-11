//
//  MainViewDataManagerAPI.swift
//  RappiTest
//
//  Created by Mauricio Jimenez on 06/06/19.
//  Copyright © 2019 com.MauJimenez. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

protocol PersistenceInterface {
    var pathRequest: String { get }
    var realmKey : String { get }
    var titleSection : String { get }
}

public enum CatalogsType : String, PersistenceInterface {
    case topMovie
    case topTv
    case popularMovie
    case popularTv
    case upCommingMovie
    
    var pathRequest : String {
        switch self {
        case .topMovie:
            return Constants.UrlServices.GetTopRatedMovie
        case .topTv:
            return Constants.UrlServices.GetTopRatedTv
        case .popularMovie:
            return Constants.UrlServices.GetPopularMovie
        case .popularTv:
            return Constants.UrlServices.GetPopularTv
        case .upCommingMovie:
            return Constants.UrlServices.GetUpcomingMovie
        }
    }
    
    var realmKey : String {
        switch self {
        case .topMovie:
            return Constants.KeysRealmObject.RealmTopRatedMovies
        case .topTv:
            return Constants.KeysRealmObject.RealmTopRatedTv
        case .popularMovie:
            return Constants.KeysRealmObject.RealmPopularMovies
        case .popularTv:
            return Constants.KeysRealmObject.RealmPopularTv
        case .upCommingMovie:
            return Constants.KeysRealmObject.RealmUpcomingMovies
        }
    }
    
    var titleSection : String {
        switch self {
        case .topMovie:
            return "Mejores peliculas"
        case .topTv:
            return "Mejores series"
        case .popularMovie:
            return "Peliculas populares"
        case .popularTv:
            return "Series populares"
        case .upCommingMovie:
            return "Proximas peliculas"
        }
    }
    
    var data : BaseResponseModel? {
        return DataSourceManager.getBaseModel(by: self)
    }
}

public enum CatalogResult {
    case success(type: CatalogsType)
    case failure(type: CatalogsType)
}

public enum GenderResult {
    case success(type: TypeItem)
    case failure(type: TypeItem)
}

class MainViewDataManagerAPI : MainViewDataManagerAPIInterface {
    
    var interactor: MainViewInteractorInterfaceOutput?
    let manager = Alamofire.SessionManager.default
    
    func getCatalogs() {
        var catalogData = [CatalogDownloadModel]()
        let dataCatalog = Constants.Catalogs.dataCatalogs

        for value in dataCatalog {
            self.getCatalog(typeCatalog: value) { (result) in
                switch result {
                case .success(let type):
                    catalogData.append(CatalogDownloadModel(catalogName: type, isDownload: true))
                case .failure(let type):
                    catalogData.append(CatalogDownloadModel(catalogName: type, isDownload: false))
                }
                
                if catalogData.count == dataCatalog.count {
                    print("success all Catalog")
                    self.saveCatalogDownload(data: catalogData) { (_) in
                        self.interactor?.standarResult(.success, typeServices: .getCatalog)
                    }
                }
                else {
                    print("failure download catalog")
                }
            }
        }
    }
    
    func getGenders() {
        let genders = Constants.Catalogs.dataGenders
        var aux = genders.count
        for value in genders {
            self.getGender(type: value) { (result) in
                switch result {
                case .success(_):
                    aux -= 1
                case .failure(_):
                    print("Error download gender by: \(value)")
                }
                
                if aux == 0 {
                    self.interactor?.standarResult(.success, typeServices: .genders)
                }
            }
        }
    }
    
    
    func sendDetail(by id: DataListModel) {
        print(id)
        let headers = DataSourceManager.getHeaders(true)
        let url = id.typeItem.pathBaseRequest + "/\(id.id)" + Constants.UrlServices.BasePathVideo
        manager.request(url, method: .get, parameters: nil, headers: headers).responseObject{ (response: DataResponse<VideoResponseModel>) in
            switch response.result {
            case .success(_):
                let responseData = response.result.value
                if let data = responseData {
                    if data.id > 0 {
                        // save token in Realm for retrive later
                        let result = DataSourceManager.saveCacheModel(Constants.KeysRealmObject.RealmCurrentVideo, value: data.toJSONString() ?? "")
                        switch result {
                        case .success:
                            self.interactor?.standarResult(.success, typeServices: .video)
                        case .failure(let message):
                            self.interactor?.standarResult(.failure(message: message), typeServices: .video)
                        }
                    }
                        // make for error
                    else {
                        self.interactor?.standarResult(.failure(message: "Error"), typeServices: .video)
                    }
                }
            case .failure(_):
                print(response.result.error ?? "")
                self.interactor?.standarResult(.failure(message: "Error"), typeServices: .video)
                break
            }
        }
    }
    
    
    private func getGender(type: TypeItem, completion: @escaping (GenderResult) -> Void) {
        let headers = DataSourceManager.getHeaders(true)
        manager.request(type.pathRequest, method: .get, parameters: nil, headers: headers).responseObject{ (response: DataResponse<BaseGenerModel>) in
            switch response.result {
            case .success(_):
                let responseData = response.result.value
                if let data = responseData {
                    if data.genres.count > 0 {
                        // save token in Realm for retrive later
                        data.typeItem = type
                        let result = DataSourceManager.saveCacheModel(type.realmKey, value: data.toJSONString() ?? "")
                        switch result {
                        case .success:
                            completion(.success(type: type))
                        case .failure(_):
                            completion(.failure(type: type))
                        }
                    }
                        // make for error
                    else {
                        completion(.failure(type: type))
                    }
                }
            case .failure(_):
                print(response.result.error ?? "")
                completion(.failure(type: type))
                break
            }
        }
    }
    
    // MARK: - methods for get catalogs
    private func saveCatalogDownload(data: [CatalogDownloadModel], completion: @escaping (ServicesManagerResult) -> Void) {
        let result = DataSourceManager.saveCacheModel(Constants.KeysRealmObject.RealmCatalogDownload, value: data.toJSONString() ?? "")
        switch result {
        case .success:
            completion(.success)
        case .failure(let message):
            completion(.failure(message: message))
        }
    }
    private func getCatalog(typeCatalog: CatalogsType, completion: @escaping (CatalogResult) -> Void) {
        let headers = DataSourceManager.getHeaders(true)
        manager.request(typeCatalog.pathRequest, method: .get, parameters: nil, headers: headers).responseObject{ (response: DataResponse<BaseResponseModel>) in
            switch response.result {
            case .success(_):
                let responseData = response.result.value
                if let data = responseData {
                        if data.page > 0 {
                            // save token in Realm for retrive later
                            let result = DataSourceManager.saveCacheModel(typeCatalog.realmKey, value: data.toJSONString() ?? "")
                            switch result {
                            case .success:
                                completion(.success(type: typeCatalog))
                            case .failure(_):
                                completion(.failure(type: typeCatalog))
                            }
                        }
                            // make for error
                        else {
                            completion(.failure(type: typeCatalog))
                        }
                }
            case .failure(_):
                print(response.result.error ?? "")
                completion(.failure(type: typeCatalog))
                break
            }
        }
    }
}
