//
//  DetailViewWireframe.swift
//  RappiTest
//
//  Created by Mauricio Jimenez on 11/06/19.
//  Copyright © 2019 com.MauJimenez. All rights reserved.
//

import Foundation
import UIKit

class DetailViewWireframe : NSObject {
    
    // MARK: Constants
    
    let view = DetailViewController()
    let presenter = DetailViewPresenter()
    let interactor = DetailViewInteractor()
    //let dataManager = DetailViewDataManagerAPI()
    
    
    // MARK: Instance Variables
    
    var navigationController: UINavigationController?
    
    override init() {
        super.init()
        
        
        view.presenter = presenter
        presenter.view = view
        interactor.view = view
        
        // Set Presenter interfaces
        presenter.interactor = interactor
        presenter.wireframe = self

        navigationController = UINavigationController(rootViewController: view)
        
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
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.wireframe = self
        interactor.view = view
        navigationController = UINavigationController(rootViewController: view)
        
        window.rootViewController = self.navigationController
        window.makeKeyAndVisible()
    }
    
    func presentDetailFromViewController(navigation: UINavigationController?, modelDetail: DataListModel) {
        navigationController = navigation
        view.modelItem  = modelDetail
        view.keyVideo = DataSourceManager.getVideoKey()
        navigation?.pushViewController(view, animated: true)
    }
    
    
}
