//
//  ViewStyleSheet.swift
//  LinioUI
//
//  Created by Mauricio Jimenez on 29/05/17.
//  Copyright © 2017 AlgoBonito. All rights reserved.

import UIKit

public enum ViewStyleSheet: String {
    
    // Styles view
    case btn_default
    case isEnabledView
    case transparent
    case rounded
    case roundCorners
    case redButton
    case redButtonRect
    case redButtonOpacy
    case redButtonOpacyRect
    case grayPhotoCell
    // loft Digital
    case rectBgGrayView
    case rectWhiteView
    case rectYellow
    case transparentGrayBorder
    case roundTransparent
    case blackWhiteAlpha50
    case quantityView
    case footerView
    
    public func getStyle() -> ViewStyle {
        switch self {
            // General View
        case .footerView:
            var viewStyle = ViewStyle()
            viewStyle.shape = ViewStyle.ViewShape.rect
            viewStyle.backgroundColor = ColorPallete.grayFooter.asColor()
            return viewStyle
        case .quantityView:
            var viewStyle = ViewStyle()
            viewStyle.shape = ViewStyle.ViewShape.rect
            viewStyle.backgroundColor = ColorPallete.white.asColor()
            viewStyle.borderColor = ColorPallete.grayLayer.asColor()
            viewStyle.borderWidth = 2
            return viewStyle
        case .grayPhotoCell:
            var viewStyle = ViewStyle()
            viewStyle.shape = ViewStyle.ViewShape.rect
            viewStyle.backgroundColor = ColorPallete.grayRequest.asColor()
            //viewStyle.backgroundColor = ColorPallete.white.asColor()
            viewStyle.borderColor = UIColor.clear
            viewStyle.borderWidth  = 0
            
            return viewStyle
            // Loft Digital
        case .rectBgGrayView:
            var viewStyle = ViewStyle()
            viewStyle.shape = ViewStyle.ViewShape.rect
            viewStyle.backgroundColor = ColorPallete.graybgView.asColor()
            return viewStyle
        case .rectWhiteView:
            var viewStyle = ViewStyle()
            viewStyle.shape = ViewStyle.ViewShape.rect
            viewStyle.backgroundColor = ColorPallete.white.asColor()
            return viewStyle
        case .rectYellow:
            var viewStyle = ViewStyle()
            viewStyle.shape = ViewStyle.ViewShape.rect
            viewStyle.backgroundColor = ColorPallete.yellowPH.asColor()
            return viewStyle
        case .transparentGrayBorder:
            var viewStyle = ViewStyle()
            viewStyle.shape = ViewStyle.ViewShape.rect
            viewStyle.backgroundColor = UIColor.white
            viewStyle.borderColor = ColorPallete.black.asColor()
            viewStyle.borderWidth = 1
            return viewStyle
        case .roundTransparent:
            var viewStyle = ViewStyle()
            viewStyle.backgroundColor = UIColor.clear
            viewStyle.shape = ViewStyle.ViewShape.round
            return viewStyle
        case .blackWhiteAlpha50:
            var viewStyle = ViewStyle()
            viewStyle.shape = ViewStyle.ViewShape.rect
            viewStyle.backgroundColor = ColorPallete.black.asColor(withAlpha: 0.5)
            return viewStyle
        // Genetal Buttons
        
        case .redButton:
            var viewStyle = ViewStyle()
            viewStyle.shape = ViewStyle.ViewShape.rect
            viewStyle.cornerRadiusStyle = 5
            viewStyle.backgroundColor = ColorPallete.redLogin.asColor()
            return viewStyle
        case .redButtonRect:
            var viewStyle = ViewStyle()
            viewStyle.shape = ViewStyle.ViewShape.rect
            viewStyle.backgroundColor = ColorPallete.redLogin.asColor()
            return viewStyle
        case .redButtonOpacy:
            var viewStyle = ViewStyle()
            viewStyle.shape = ViewStyle.ViewShape.rect
            viewStyle.cornerRadiusStyle = 5
            viewStyle.backgroundColor = ColorPallete.redLogin.asColor(withAlpha: 0.5)
            return viewStyle
        case .redButtonOpacyRect:
            var viewStyle = ViewStyle()
            viewStyle.shape = ViewStyle.ViewShape.rect
            viewStyle.backgroundColor = ColorPallete.redLogin.asColor(withAlpha: 0.5)
            return viewStyle
        case .btn_default:
            var viewStyle = ViewStyle()
            viewStyle.shape = ViewStyle.ViewShape.rect
            viewStyle.backgroundColor = ColorPallete.blackBGAlert.asColor(withAlpha: 0.70)
            viewStyle.height = 50
            return viewStyle
        case .isEnabledView:
            var viewStyle = ViewStyle()
            viewStyle.shape = ViewStyle.ViewShape.rect
            viewStyle.backgroundColor = ColorPallete.blackBGAlert.asColor(withAlpha: 0.70)
            return viewStyle
        case .transparent:
            var viewStyle = ViewStyle()
            viewStyle.backgroundColor = UIColor.clear
            return viewStyle
        case .rounded:
            var viewStyle = ViewStyle()
            viewStyle.shape = ViewStyle.ViewShape.round
            return viewStyle
        case .roundCorners:
            var viewStyle = ViewStyle()
            viewStyle.backgroundColor = ColorPallete.black.asColor(withAlpha: 0.70)
            viewStyle.shape = ViewStyle.ViewShape.rect
            viewStyle.cornerRadiusStyle = 20
            return viewStyle
        }
    }
}
