//
//  ShadowViewStyleSheet.swift
//  LinioUIKit
//
//  Created by Mauricio Jimenez on 29/05/17.
//  Copyright © 2017 AlgoBonito. All rights reserved.


import UIKit

public enum ShadowViewStyleSheet: String {
    
    case cardRect
    case cardRound
    case cardCornerRounded
    case cardTopShadow
    
    public func getStyle() -> ShadowStyle {
        switch self {
        case .cardRect:
            var shadowStyle = ShadowStyle()
            shadowStyle.borderRadius = 0
            shadowStyle.shadowOffsetStyle = CGSize(width: 0, height: 2)
            shadowStyle.shadowOpacityStyle = 0.2
            shadowStyle.shadowRadiusStyle = 10
            return shadowStyle
            
        case .cardRound:
            var shadowStyle = ShadowStyle()
            shadowStyle.borderRadius = 6
            shadowStyle.shadowOffsetStyle = CGSize(width: 0, height: 3)
            shadowStyle.shadowOpacityStyle = 0.2
            shadowStyle.shadowRadiusStyle = 5
            return shadowStyle
            
        case .cardCornerRounded:
            var shadowStyle = ShadowStyle()
            shadowStyle.borderRadius = 20
            shadowStyle.shadowOffsetStyle = CGSize(width: 0, height: 3)
            shadowStyle.shadowOpacityStyle = 0.2
            shadowStyle.shadowRadiusStyle = 19
            return shadowStyle
        case .cardTopShadow:
            var shadowStyle = ShadowStyle()
            shadowStyle.borderRadius = 0
            shadowStyle.shadowOffsetStyle = CGSize(width: 0, height: -3)
            shadowStyle.shadowOpacityStyle = 0.2
            shadowStyle.shadowRadiusStyle = 19
            return shadowStyle
        }
    }
    
}


