//
//  MainViewPresenter.swift
//  RappiTest
//
//  Created by Mauricio Jimenez on 06/06/19.
//  Copyright © 2019 com.MauJimenez. All rights reserved.
//

import Foundation
import UIKit
class MainViewPresenter : MainViewPresenterInterface {
    
    
    var view: MainViewInterface?
    
    var interactor: MainViewInteractorInterface?
    
    var wireframe: MainViewWireframeInterface?
    var wireframeSplash: SplashViewWireframeInterface?

    
    func getCatalogs() {
        self.interactor?.getCatalogs()
    }
    
    func getGenders() {
        self.interactor?.getGenders()
    }
    func sendDetail(by id: DataListModel) {
        self.interactor?.sendDetail(by: id)
    }
    
    func pushToDetail(view: MainViewController, navigation: UINavigationController?, modelDetail: DataListModel) {
        self.interactor?.pushToDetail(view: view, navigation: navigation, modelDetail: modelDetail)
    }
    
    func pushToMainView(navigation: UINavigationController?) {
        self.interactor?.pushToMainView(navigation: navigation)
    }
    
    
}

extension MainViewPresenter : MainViewInteractorInterfaceOutput {
    func standarResult(_ result: ServicesManagerResult, typeServices: ServicesType) {
        self.view?.servicesResult(result, typeServices: typeServices)
    }
}
