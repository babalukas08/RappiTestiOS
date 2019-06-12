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
            Constants.UrlServices.BaseUrl: .disableEvaluation,
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
    static func sendAccessToken(completion: @escaping (_ result: ServicesManagerResult) -> Void) {}

}
