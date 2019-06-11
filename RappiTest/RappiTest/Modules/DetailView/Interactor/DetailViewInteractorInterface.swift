//
//  DetailViewInteractorInterface.swift
//  RappiTest
//
//  Created by Mauricio Jimenez on 11/06/19.
//  Copyright © 2019 com.MauJimenez. All rights reserved.
//

import Foundation
import UIKit

protocol DetailViewInteractorInterface : class {
    
    // Dependencies    
    var view: DetailViewInterface? { get set }
    
    // Navigation Methods
    func pushToBack(navigation: UINavigationController?)
}
