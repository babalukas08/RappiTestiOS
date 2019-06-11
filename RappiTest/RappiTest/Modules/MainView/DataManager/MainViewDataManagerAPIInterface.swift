//
//  MainViewDataManagerAPIInterface.swift
//  RappiTest
//
//  Created by Mauricio Jimenez on 06/06/19.
//  Copyright © 2019 com.MauJimenez. All rights reserved.
//

import Foundation

protocol MainViewDataManagerAPIInterface : class {
    
    // Dependencies
    
    var interactor: MainViewInteractorInterfaceOutput? { get set }
    
    // Add here your methods for communication INTERACTOR -> APIDATAMANAGER
    // Services Methods
    func getCatalogs()
    func getGenders()
    func sendDetail(by id: String)
}
