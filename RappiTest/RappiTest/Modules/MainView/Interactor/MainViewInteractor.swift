//
//  MainViewInteractor.swift
//  RappiTest
//
//  Created by Mauricio Jimenez on 06/06/19.
//  Copyright © 2019 com.MauJimenez. All rights reserved.
//

import Foundation
import UIKit
class MainViewInteractor : MainViewInteractorInterface {
    var dataManager: MainViewDataManagerAPIInterface?
    
    var view: MainViewInterface?
    
    func getCatalogs() {
        self.dataManager?.getCatalogs()
    }
    
    func getGenders() {
        self.dataManager?.getGenders()
    }
    
    func sendDetail(by id: DataListModel) {
        self.dataManager?.sendDetail(by: id)
    }
    
    func pushToDetail(navigation: UINavigationController?, modelDetail: DataListModel) {
        print("Implement wireFrame to push")
        let detailWireFrame = DetailViewWireframe()
        detailWireFrame.presentDetailFromViewController(navigation: navigation, modelDetail: modelDetail)
    }
    
    
}
