//
//  ServicesManager.swift
//  PalacioJuguetes
//
//  Created by Mauricio Jimenez on 11/09/18.
//  Copyright © 2018 com.MauJimenez. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import ObjectMapper

enum ServicesDefualtResult {
    case success
    case failure(message : String)
}

final class ServicesManager: NSObject {
    
    static var manager: Alamofire.SessionManager = {
        
        // Create the server trust policies
        let serverTrustPolicies: [String: ServerTrustPolicy] = [
            Constants.UrlServices.urlBase: .disableEvaluation,
            ]
        
        // Create custom manager
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        let manager = Alamofire.SessionManager(
            configuration: URLSessionConfiguration.default,
            serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies)
        )
        
        return manager
    }()
    
    // this function validate error Data and return error string message
    static func sendAccessToken(completion: @escaping (_ result: ServicesManagerResult) -> Void) {
        self.manager.request(APIRouterUpdate.sendToken(body: Constants.UrlServices.BodyToken))
            .validate(statusCode: 1...501)
            .responseString { response in
                switch response.result {
                case .success:
                    if let responseStr = response.result.value {
                        print(responseStr)
                        if let modelResponse = Mapper<AccessTokenModel>().map(JSONString: responseStr) {
                            let result = DataSourceManager.saveCacheModel(Constants.KeysRealmObject.RealmAccessTokenModel, value: modelResponse.toJSONString() ?? "")
                            switch result {
                            case .success:
                                completion(.success)
                            case .failure(let message):
                                completion(.failure(message: message))
                            }
                        }
                    }
                    else {
                        completion(.failure(message: Constants.GlobalMessage.WebServiceError.wsError))
                    }
                case .failure:
                    completion(.failure(message: Constants.GlobalMessage.WebServiceError.wsError))
                }
        }
    }
    
    static func sendServices(data: Any, completion: @escaping (_ result: ServicesManagerResult) -> Void) {
        if let sku = data as? String {
            self.sendDetailRequest(sku: sku) { (resultDetail) in
                completion(resultDetail)
            }
        }
        
    }
    
    static func validateResponseAccessToken<T: Any>(result: ServicesManagerResult, data: T, completion: @escaping (_ result: ServicesManagerResult) -> Void) {
        switch result {
        case .success:
            self.sendServices(data: data, completion: { (result) in
                completion(result)
            })
        case .failure(let message):
            completion(.failure(message: message))
        default:
            completion(result)
        }
    }

    
    // MARK: - sendDetailRequest
    static func sendDetailRequest(sku: String, completion: @escaping (_ result: ServicesManagerResult) -> Void) {
        let model = DetailProductRequestModel(sku: sku)
        self.manager.request(APIRouterUpdate.sendDetail(model: model))
            .validate(statusCode: 1...501)
            .responseString { response in
                switch response.result {
                case .success:
                    if let responseStr = response.result.value {
                        if let modelResponse = Mapper<DetailProductResponseModel>().map(JSONString: responseStr) {
                            print("\n modelresponse: \(modelResponse) \n\n")
                            if let error = modelResponse.error {
                                if error.code != "0" {
                                    // Send Request AccessToken
                                    ServicesManager.sendAccessToken { (result) in
                                        print(result)
                                        self.validateResponseAccessToken(result: result, data: sku, completion: { (resultAccess) in
                                            completion(resultAccess)
                                        })
                                    }
                                }
                                else {
                                    completion(.failure(message: modelResponse.message))
                                }
                            }
                            else {
                                if modelResponse.ok == 1 {
                                        if modelResponse.products.count > 0 {
                                            DataSourceManager.saveCurrentDetailProduct(model: modelResponse.products[0], completion: { (result) in
                                                completion(result)
                                            })
                                        }
                                        else {
                                            completion(.failure(message: modelResponse.message))
                                        }
                                    
                                }
                                else {
                                    completion(.failure(message: modelResponse.message))
                                }
                            }
                            
                        }
                        else {
                            completion(.failure(message: Constants.GlobalMessage.WebServiceError.wsError))
                        }
                    }
                    else {
                        completion(.failure(message: Constants.GlobalMessage.WebServiceError.wsError))
                    }
                case .failure:
                    completion(.failure(message: Constants.GlobalMessage.WebServiceError.wsError))
                }
        }
    }
}
