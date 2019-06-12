//
//  CarouselUtils.swift
//  LoftDigitalCliente
//
//  Created by Mauricio Jimenez on 23/05/19.
//  Copyright © 2019 com.AlphaSoluciones. All rights reserved.
//

import Foundation
import UIKit


/// Enum Type of carousel images
enum TypeCarouselImages: String {
    /// Full - Default
    case full
    /// Home - Add button to home view
    case small
    /// ChildView - Add button to back to previus view
    case customize
    
    case iPadMiddle
    
    case iPadFull
    
    case iPhoneView
    
    case historical
    
    
    public func getlayoutData(size: CGSize? = nil, insets: UIEdgeInsets? = nil) -> CarouselData {
        
        var data = CarouselData()
        
        switch self {
        case .full:
            data.size = CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
            data.insets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        case .small:
            data.size = CGSize(width: 50, height: 50)
            data.insets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        case .customize:
            if let sizeCustom = size {
                data.size = sizeCustom
            }
            if let insetsEdge = insets {
                data.insets = insetsEdge
            }
        case .iPadFull:
            let wi = (UIScreen.main.bounds.size.width - 125)/4
            data.size = CGSize(width: wi, height: wi + 108)
            data.insets = UIEdgeInsets(top: 0, left: 34, bottom: 0, right: 34)
        case .iPadMiddle:
            let wi = ((UIScreen.main.bounds.size.width/2) - 71)/2
            data.size = CGSize(width: wi, height: wi + 136)
            data.insets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        case .iPhoneView:
            let wi = (UIScreen.main.bounds.size.width - 10)
            data.size = CGSize(width: wi, height: wi - 172)
            data.insets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        case .historical:
            let wi = ((UIScreen.main.bounds.size.width/2) - 71)/2
            data.size = CGSize(width: wi, height: wi + 38)
            data.insets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        }
        
        return data
    }
}

public struct CarouselData  {
    public var size: CGSize = CGSize(width: 0, height: 0)
    public var insets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    
    public init() { }
    public init(size: CGSize, insets: UIEdgeInsets) {
        self.size   = size
        self.insets = insets
    }
}
