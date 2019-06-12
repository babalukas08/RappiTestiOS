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
    
    func pushToDetail(view: MainViewController, navigation: UINavigationController?, modelDetail: DataListModel) {
        print("Implement wireFrame to push")
        let detailWireFrame = DetailViewWireframe()
        detailWireFrame.presentDetailFromViewController(view: view, navigation: navigation, modelDetail: modelDetail)
    }
    
    func pushToMainView(navigation: UINavigationController?) {
        let mainView = MainViewWireFrame()
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        appDelegate.initWindow()
        
        guard let window = appDelegate.window else {
            return
        }
        
        mainView.presentMainViewInterfaceFromWindow(window: window)
    }
    
    
}
