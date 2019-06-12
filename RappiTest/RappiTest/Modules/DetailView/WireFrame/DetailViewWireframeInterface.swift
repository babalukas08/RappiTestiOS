//
//  DetailViewWireframeInterface.swift
//  RappiTest
//
//  Created by Mauricio Jimenez on 11/06/19.
//  Copyright © 2019 com.MauJimenez. All rights reserved.
//

import UIKit

protocol DetailViewWireframeInterface : class {
    
    // Add here your methods for communication PRESENTER -> WIREFRAME
    func presentDetailInterfaceFromWindow(window: UIWindow)
    func presentDetailFromViewController(view: MainViewController, navigation: UINavigationController?, modelDetail: DataListModel)
}
