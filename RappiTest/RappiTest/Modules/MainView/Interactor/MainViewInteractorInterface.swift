//
//  MainViewInteractorInterface.swift
//  RappiTest
//
//  Created by Mauricio Jimenez on 06/06/19.
//  Copyright © 2019 com.MauJimenez. All rights reserved.
//

import Foundation
import UIKit

protocol MainViewInteractorInterface : class {
    
    // Dependencies
    
    var dataManager: MainViewDataManagerAPIInterface? { get set }
    var view: MainViewInterface? { get set }
    
    // Add here your methods for communication VIEW -> PRESENTER
    // Services Methods
    func getCatalogs()
    func getGenders()
    func sendDetail(by id: DataListModel)
    
    // Navigation Methods
    func pushToDetail(navigation: UINavigationController?, modelDetail: DataListModel)
}
