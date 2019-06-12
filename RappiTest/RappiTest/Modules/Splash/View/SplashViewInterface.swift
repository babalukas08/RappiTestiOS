//
//  SplashViewInterface.swift
//  RappiTest
//
//  Created by Mauricio Jimenez on 12/06/19.
//  Copyright © 2019 com.MauJimenez. All rights reserved.
//

import Foundation
import UIKit

protocol SplashViewInterface : class {
    
    // Dependencies
    var presenter: MainViewPresenterInterface? { get set }
    
    // Add here your methods for communication PRESENTER -> VIEW
    func servicesResult(_ result: ServicesManagerResult, typeServices: ServicesType)
}
