//
//  APIRouterUpdate.swift
//  LoftDigitalCliente
//
//  Created by Mauricio Jimenez on 27/05/19.
//  Copyright © 2019 com.AlphaSoluciones. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

enum APIRouterUpdate: URLRequestConvertible {
    // content Type
    static let contentType = Constants.UrlServices.Content_Type
    // Methods
    static let sendTokenPath = Constants.APIMethods.AccessToken
    static let sendDetailPath = Constants.APIMethods.ProductInfo
    
    // Cases
    case sendToken(body: String)
    case sendDetail(model: DetailProductRequestModel)
    
    /// Returns a URL request or throws if an `Error` was encountered.
    ///
    /// - throws: An `Error` if the underlying `URLRequest` is `nil`.
    ///
    /// - returns: A URL request.
    public func asURLRequest() throws -> URLRequest {
        var contentType = APIRouterUpdate.contentType
        let result: (path: String, body: String?) = {
            switch self {
            case .sendToken(let body):
                contentType = Constants.UrlServices.Content_TypeToken
                return (APIRouterUpdate.sendTokenPath, body)
            case .sendDetail(let model):
                return (APIRouterUpdate.sendDetailPath, Mapper().toJSONString(model, prettyPrint: true))
            }
        }()
        
        let request = APIUtils.createRequestMyAPI(result.path, content_Type: contentType,
                                                  body: result.body, typeRequest: .POST);
        
        
        return request as URLRequest
    }
}
