//
//  DetailViewPresenterInterface.swift
//  RappiTest
//
//  Created by Mauricio Jimenez on 11/06/19.
//  Copyright © 2019 com.MauJimenez. All rights reserved.
//

import Foundation
import UIKit
protocol DetailViewPresenterInterface : class {
    
    // Dependencies
    var view: DetailViewInterface? { get set }
    
    var interactor: DetailViewInteractorInterface? { get set }
    var wireframe: DetailViewWireframeInterface? { get set }
    
    
    // Navigation Methods
    func pushToBack(navigation: UINavigationController?)
    
}
