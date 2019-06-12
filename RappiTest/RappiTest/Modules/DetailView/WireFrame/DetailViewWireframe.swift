//
//  DetailViewWireframe.swift
//  RappiTest
//
//  Created by Mauricio Jimenez on 11/06/19.
//  Copyright © 2019 com.MauJimenez. All rights reserved.
//

import Foundation
import UIKit
import Hero

class DetailViewWireframe : NSObject {
    
    // MARK: Constants
    
    let viewM = DetailViewController()
    let presenter = DetailViewPresenter()
    let interactor = DetailViewInteractor()
    //let dataManager = DetailViewDataManagerAPI()
    
    
    // MARK: Instance Variables
    
    var navigationController: UINavigationController?
    
    override init() {
        super.init()
        
        
        viewM.presenter = presenter
        presenter.view = viewM
        interactor.view = viewM
        
        // Set Presenter interfaces
        presenter.interactor = interactor
        presenter.wireframe = self

        navigationController = UINavigationController(rootViewController: viewM)
        
    }
    
    init(viewController: DetailViewController, navigation: UINavigationController?) {
        super.init()
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.wireframe = self
        navigationController = navigation
    }
    
}

extension DetailViewWireframe : DetailViewWireframeInterface {
    func presentDetailInterfaceFromWindow(window: UIWindow) {
        viewM.presenter = presenter
        presenter.view = viewM
        presenter.interactor = interactor
        presenter.wireframe = self
        interactor.view = viewM
        navigationController = UINavigationController(rootViewController: viewM)
        
        window.rootViewController = self.navigationController
        window.makeKeyAndVisible()
    }
    
    func presentDetailFromViewController(view: MainViewController, navigation: UINavigationController?, modelDetail: DataListModel) {
        navigationController = navigation
        viewM.modelItem  = modelDetail
        
        viewM.keyVideo = DataSourceManager.getVideoKey()

        viewM.hero.isEnabled = true
        viewM.hero.modalAnimationType = .none
        
        let cardHeroId = "card\(modelDetail.id)"
        viewM.cardHeroId = cardHeroId
        
        //view.hero.replaceViewController(with: viewM)
        navigation?.pushViewController(viewM, animated: true)
    }
    
    
}
