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
    
    func getCatalogs() {
        self.interactor?.getCatalogs()
    }
    
    func getGenders() {
        self.interactor?.getGenders()
    }
    func sendDetail(by id: String) {
        self.interactor?.sendDetail(by: id)
    }
    
    func pushToDetail(navigation: UINavigationController?) {
        self.interactor?.pushToDetail(navigation: navigation)
    }
    
    
}

extension MainViewPresenter : MainViewInteractorInterfaceOutput {
    func standarResult(_ result: ServicesManagerResult, typeServices: ServicesType) {
        self.view?.servicesResult(result, typeServices: typeServices)
    }
}
