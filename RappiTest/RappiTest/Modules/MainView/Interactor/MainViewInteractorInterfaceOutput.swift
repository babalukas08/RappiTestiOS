//
//  MainViewInteractorInterfaceOutput.swift
//  RappiTest
//
//  Created by Mauricio Jimenez on 06/06/19.
//  Copyright © 2019 com.MauJimenez. All rights reserved.
//

protocol MainViewInteractorInterfaceOutput : class {
    
    // Add here your methods for communication PRESENTER -> INTERACTOR
    func standarResult(_ result: ServicesManagerResult, typeServices: ServicesType)
}

enum ServicesType : String {
    case getCatalog
    case detail
    case genders
    case updateList
    case sendEmail
    case getToken
    case newBag
}
