//
//  MainViewWireFrame.swift
//  RappiTest
//
//  Created by Mauricio Jimenez on 06/06/19.
//  Copyright © 2019 com.MauJimenez. All rights reserved.
//

import Foundation
import UIKit

class MainViewWireFrame : NSObject {
    
    // MARK: Constants
    
    let view = MainViewController()
    let presenter = MainViewPresenter()
    let interactor = MainViewInteractor()
    let dataManager = MainViewDataManagerAPI()
    
    
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
        
        // Set Interactor interfaces
        interactor.dataManager = dataManager
        
        
        // Set dataManager interfaces
        dataManager.interactor = presenter
        
        navigationController = UINavigationController(rootViewController: view)
        
    }
    
    init(viewController: MainViewController, navigation: UINavigationController?) {
        super.init()
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.wireframe = self
        interactor.dataManager = dataManager
        dataManager.interactor = presenter  // LoginInteractorInterfaceOutput
        navigationController = navigation
    }
    
}

extension MainViewWireFrame : MainViewWireframeInterface {
    func presentMainViewInterfaceFromWindow(window: UIWindow) {
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.wireframe = self
        interactor.dataManager = dataManager
        interactor.view = view
        dataManager.interactor = presenter  // LoginInteractorInterfaceOutput
        navigationController = UINavigationController(rootViewController: view)
        
        window.rootViewController = self.navigationController
        window.makeKeyAndVisible()
    }
    
    func presentMainViewFromViewController(navigation: UINavigationController?) {
        navigationController = navigation
        navigation?.pushViewController(view, animated: true)
    }
    
    
}
