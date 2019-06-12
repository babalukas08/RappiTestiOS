//
//  SplashViewWireframeInterface.swift
//  RappiTest
//
//  Created by Mauricio Jimenez on 12/06/19.
//  Copyright © 2019 com.MauJimenez. All rights reserved.
//

import UIKit

protocol SplashViewWireframeInterface : class {
    
    // Add here your methods for communication PRESENTER -> WIREFRAME
    func presentSplashInterfaceFromWindow(window: UIWindow)
    func presentSplashFromViewController(navigation: UINavigationController?)
}
