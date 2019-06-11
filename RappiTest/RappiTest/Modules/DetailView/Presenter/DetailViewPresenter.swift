//
//  DetailViewPresenter.swift
//  RappiTest
//
//  Created by Mauricio Jimenez on 11/06/19.
//  Copyright © 2019 com.MauJimenez. All rights reserved.
//

import Foundation
import UIKit
class DetailViewPresenter : DetailViewPresenterInterface {
    var view: DetailViewInterface?
    
    var interactor: DetailViewInteractorInterface?
    
    var wireframe: DetailViewWireframeInterface?
    
    func pushToBack(navigation: UINavigationController?) {
        self.interactor?.pushToBack(navigation: navigation)
    }
}
