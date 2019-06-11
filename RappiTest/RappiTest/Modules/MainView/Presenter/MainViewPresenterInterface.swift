//
//  MainViewPresenterInterface.swift
//  RappiTest
//
//  Created by Mauricio Jimenez on 06/06/19.
//  Copyright © 2019 com.MauJimenez. All rights reserved.
//

import Foundation
import UIKit
protocol MainViewPresenterInterface : class {
    
    // Dependencies
    var view: MainViewInterface? { get set }
    
    var interactor: MainViewInteractorInterface? { get set }
    var wireframe: MainViewWireframeInterface? { get set }
    
    
    // Add here your methods for communication VIEW -> PRESENTER
    // Services Methods
    func getCatalogs()
    func getGenders()
    func sendDetail(by id: DataListModel)
    
    // Navigation Methods
    func pushToDetail(navigation: UINavigationController?, modelDetail: DataListModel)
    
}
