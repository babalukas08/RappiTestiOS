//
//  APIUtils.swift
//  TestAlsea
//
//  Created by Mauricio Jimenez on 20/12/17.
//  Copyright © 2017 com.MauJimenez. All rights reserved.
//
import Foundation
import Alamofire
import ObjectMapper
import AdSupport

class APIUtils {
    
    /* Creates a correctly formatted NSMutableURLRequest for use with Alamofire */
    static func createRequestMyAPI(_ path: String, content_Type: String, body: String?, typeRequest: TypeRequest = .POST) -> NSMutableURLRequest {
        //no country code, no dice
        //url building
        let apiURL = URL(string: Constants.UrlServices.BaseUrl)!
        let mutableURLRequest = NSMutableURLRequest(url: apiURL.appendingPathComponent(path))
        
        //set method and content type
        mutableURLRequest.httpMethod = typeRequest.rawValue
        mutableURLRequest.setValue(content_Type, forHTTPHeaderField: "Content-Type")
        
        if content_Type == Constants.UrlServices.BaseUrl {
//            let oauth = String(format: Constants.UrlServices.Authorization, DataSourceManager.getAccessToken())
            //mutableURLRequest.setValue("", forHTTPHeaderField: "Authorization")
            //mutableURLRequest.setValue(Constants.UrlServices.GENEXUS_AGENT, forHTTPHeaderField: "GENEXUS-AGENT")
            mutableURLRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        }
        
        
        //set request ID
        let uuid = (ASIdentifierManager.shared().isAdvertisingTrackingEnabled) ?
            ASIdentifierManager.shared().advertisingIdentifier.uuidString :
            UUID().uuidString
        let requestID = "iOS-\(uuid)-\(Int((Date().timeIntervalSince1970)))"
        mutableURLRequest.setValue(requestID, forHTTPHeaderField: "X-Request-ID")
        
        
        //set body
        if let dataBody = body {
            //print("\n\n dataBody: \(dataBody) \n\n\n")
            mutableURLRequest.httpBody = dataBody.data(using: String.Encoding.utf8)
        }
        else {
            mutableURLRequest.httpBody = "{}".data(using: String.Encoding.utf8)
        }
        
        return mutableURLRequest
    }
    
    static func checkForCriticalError(_ response: HTTPURLResponse) -> (Bool, String?) {
        if response.statusCode == 401 {
            return (true, "Non-authenticated user, please log in again.")
        }
        else if response.statusCode == 403 {
            return (true, "Resource cannot be accessed by this client.")
        }
        else if response.statusCode == 400 {
            return (true, "Bad request sent by the application")
        }
        else {
            return (false, nil)
        }
    }
    
    // This function is in charge of validating if the key in the values is in uppercase or low case in case of not finding the value returns an empty string
    static func validateHeaderValue(allHeaders: [AnyHashable : Any]?, key: String) -> String {
        if let headersDic = allHeaders {
            if let headerValue = headersDic[key] as? String {
                return headerValue
            }
            else if let headerValue = headersDic[key.lowercased()] as? String {
                return headerValue
            }
        }
        return ""
    }
}

enum TypeRequest: String {
    case POST
    case GET
}


