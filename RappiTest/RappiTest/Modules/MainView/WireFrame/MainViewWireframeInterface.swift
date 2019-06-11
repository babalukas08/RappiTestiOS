//
//  MainViewWireframeInterface.swift
//  RappiTest
//
//  Created by Mauricio Jimenez on 06/06/19.
//  Copyright © 2019 com.MauJimenez. All rights reserved.
//

import UIKit

protocol MainViewWireframeInterface : class {
    
    // Add here your methods for communication PRESENTER -> WIREFRAME
    func presentMainViewInterfaceFromWindow(window: UIWindow)
    func presentMainViewFromViewController(navigation: UINavigationController?)
}
